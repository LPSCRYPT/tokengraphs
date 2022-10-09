// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
// import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
// import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

interface IEdge {

    struct NFT {
        address tokenAddress;
        uint256 tokenId;
    }

    function link(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId
    ) external;

    function link(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) external;

    function unlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId
    ) external;

    function unlink(
        NFT memory sourceToken,
        NFT memory targetToken,
        uint256 edgeId,
        bytes memory data
    ) external;

}