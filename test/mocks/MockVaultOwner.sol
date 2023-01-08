// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @notice Spoofs a code-containing vault owner, so that it can return the onLockReceived selector

contract MockVaultOwner {
    function beforeLockTransfer(
        address,
        address,
        bytes32,
        bytes calldata
    ) external pure returns (bytes4) {
        return this.beforeLockTransfer.selector;
    }
    function onLockReceived(
        address,
        address,
        bytes32,
        bytes calldata
    ) external pure returns (bytes4) {
        return this.onLockReceived.selector;
    }
}