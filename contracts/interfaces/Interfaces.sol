// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

interface IERC20DetailsLike {
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint256);
}
