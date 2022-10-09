// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.8;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
// import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
// import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

import "./IEdge.sol";
import "./EdgeBase.sol";
import "./EdgeHub.sol";

/**
 * @title Edge allows for interaction with EdgeHub
 * @dev pre-compute and post-comupute functions are intended to be extensible by inheriting contracts
 * @dev sanity checking on basic edge hygeine is done in the EdgeHub
 */

abstract contract Edge is EdgeBase, IEdge {

    EdgeHub public _EdgeHub;

    constructor(address hub) EdgeBase(hub) {
        // todo: sanity check EdgeBase(HUB) is valid
        // _EdgeHub = IEdgeHub(hub);
        _EdgeHub = EdgeHub(hub);
    }

    function link(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) public {
        _beforeLink(sourceToken, targetToken, edgeId, data);
        _EdgeHub.link(sourceToken, targetToken, edgeId, data);
        _afterLink(sourceToken, targetToken, edgeId, data);
    }
    
    function unlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) public {
        _beforeUnlink(sourceToken, targetToken, edgeId, data);
        _EdgeHub.unlink(sourceToken, targetToken, edgeId, data);
        _afterUnlink(sourceToken, targetToken, edgeId, data);
    }

    function _beforeLink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) internal virtual {}

    function _afterLink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data 
    ) internal virtual {}

    function _beforeUnlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) internal virtual {}

    function _afterUnlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data 
    ) internal virtual {}

}