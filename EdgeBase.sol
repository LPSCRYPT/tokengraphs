// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.8;

/**
 * @title ERC-Link: Link Common Token With ERC-721 Standard
 * @dev See https://eips.ethereum.org/EIPS/eip-Link
 * @dev This standard derives significantly from EIP-4786, removing opinionated logic for nested token structures, which will be seperated into a seperate EIP which inherits the Link standard
 * @dev LinkMap subgraph allows for basic front-end link viewability for any deployed ERC-Link compliant token structure
 */

abstract contract EdgeBase {

    event EdgeBaseConstructed(address, uint256);

     address public immutable HUB;

    constructor(address hub) {
        if (hub == address(0)) revert("Invalid Parameters");
        HUB = hub;
        emit EdgeBaseConstructed(hub, block.timestamp);
    }

}