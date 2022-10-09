// should take care of core state management
// has no opinions about links except for ensuring that they are called from another contract
// also checks for (non)existence before (un)linking

// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract EdgeHub is IEdgeHub, ERC165 {

    // EdgeAddress => NFT_Source => NFT_Target => EdgeID => Exists?

    mapping(address => mapping(address => mapping(uint256 => mapping(address => mapping(uint256 => bool))))) edge;

    // EdgeAddress => NFT_Source => NFT_Target => EdgeID => Data

    mapping(address => mapping(address => mapping(uint256 => mapping(address => mapping(uint256 => bytes))))) edgeData;

    modifier notZeroAddress(address _token) {
        require(
            _token != address(0),
            "token address should not be zero address"
        );
        _;
    }

    modifier tokenExists(address _token) {
        require(
            // change token checking logic for erc20 & erc1155 
            _isERC721AndExists(_token),
            "token not ERC721 token or does not exist"
        );
    }

    function link(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) external tokenExists(sourceToken) tokenExists(targetToken) notZeroAddress(sourceToken.tokenAddress) notZeroAddress(targetToken.tokenAddress) {
        require(
            !edgeExists(msg.sender, sourceToken, targetToken, edgeId), 
            "Edge already created at this id"
        );
        require(
            msg.sender != tx.origin,
            "Caller must be an external contract"
        );
        _addLink(sourceToken, targetToken, linkId, data);
        emit Linked(tx.origin, sourceToken, targetToken, linkId, data);
    }

    function unlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) external tokenExists(sourceToken) tokenExists(targetToken) notZeroAddress(sourceToken.tokenAddress) notZeroAddress(targetToken.tokenAddress) {
        require(
            edgeExists(msg.sender, sourceToken, targetToken, edgeId), 
            "Edge does not exist at this id"
        );
        require(
            msg.sender != tx.origin,
            "Caller must be an external contract"
        );
        _removeLink(sourceToken, targetToken, edgeId);
        emit Unlinked(tx.origin, sourceToken, targetToken, edgeId, data);
    }

    function edgeExists(address edgeType, NFT sourceToken, NFT targetToken, uint256 edgeId) public view returns (bool) {
        return edge[edgeType][sourceToken.tokenAddress][sourceToken.tokenId][targetToken.tokenAddress][targetToken.tokenId][edgeId];
    }

    function getEdgeData(address edgeType, NFT sourceToken, NFT targetToken, uint256 edgeId) public view returns (bytes) {
        require(edgeExists(edgeType, sourceToken, targetToken, edgeId), "Edge does not exist.");
        return edgeData[edgeType][sourceToken.tokenAddress][sourceToken.tokenId][targetToken.tokenAddress][targetToken.tokenId][edgeId];
    }

    function _addLink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes data
    ) private {
        // msg.sender should always refer to the calling contract which implements the IEdge interface
        edge[msg.sender][sourceToken.tokenAddress][sourceToken.tokenId][targetToken.tokenAddress][targetToken.tokenId][edgeId] = true;
        edgeData[msg.sender][sourceToken.tokenAddress][sourceToken.tokenId][targetToken.tokenAddress][targetToken.tokenId][edgeId] = data;

    }

    function _removeLink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId
    ) private {
        // msg.sender should always refer to the calling contract which implements the IEdge interface
        edge[msg.sender][sourceToken.tokenAddress][sourceToken.tokenId][targetToken.tokenAddress][targetToken.tokenId][edgeId] = false;
        delete edgeData[msg.sender][sourceToken.tokenAddress][sourceToken.tokenId][targetToken.tokenAddress][targetToken.tokenId][edgeId];
    }

    function _isERC721AndExists(NFT memory token)
        internal
        view
        returns (bool)
    {
        // Although can use try catch here, it's better to check is erc721 token in dapp.
        return
            IERC165(token.tokenAddress).supportsInterface(
                type(IERC721).interfaceId
            )
                ? IERC721(token.tokenAddress).ownerOf(token.tokenId) !=
                    address(0)
                : false;
    }

}