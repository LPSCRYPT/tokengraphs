// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.8;

interface INFT {

    /**
     * @dev Representation of an ERC-721 Token
     */

    struct NFT {
        address tokenAddress;
        uint256 tokenId;
    }
    
}