// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
// import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./INFT.sol";

/**
 * @title ERC-Link: Link Common Token With ERC-721 Standard
 * @dev See https://eips.ethereum.org/EIPS/eip-Link
 */
interface IEdgeHub is IERC165, INFT {

    /**
     * @dev Emited when sourceToken linked to targetToken.
     * @param from who link `sourceToken` to `targetToken`
     * @param sourceToken starting node, child node
     * @param targetToken ending node, parent node
     * @param data Additional data when link to the targetToken, either the numerical index of the link or other information
     */
    event Linked(
        address from,
        NFT sourceToken,
        NFT targetToken,
        uint256 edgeId,
        bytes data
    );

    /**
     * @dev Emited when sourceToken unlinked to `to`.
     */
    event Unlinked(
        address from, 
        NFT sourceToken, 
        NFT targetToken, 
        uint256 edgeId,
        bytes data
    );

    // function link(
    //     NFT memory sourceToken,
    //     NFT memory targetToken,
    //     uint256 edgeId
    // ) external;

    /**
     * @dev link a ERC-721 token to another ERC-721 token
     * @param sourceToken link this token to another
     * @param targetToken linked token
     * @param data can as the order of linking to NFT or other information
     */

    function link(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) external;

    // function unlink(
    //     NFT memory sourceToken,
    //     NFT memory targetToken,
    //     uint256 edgeId
    // ) external;

    /**
     * @dev unlink a ERC-721 token to a address
     * @param sourceToken unlink this token from targetToken
     * @param data can as information about token changes or other information
     */

    function unlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) external;

    function edgeExists(
        address edgeType,
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId
    ) external view returns (bool);

    function getEdgeData(
        address edgeType,
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId
    ) external view returns (bytes memory);
}