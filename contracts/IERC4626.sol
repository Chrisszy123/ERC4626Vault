//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC4626 { 
    function totalAssets() external view returns (uint256); 
    function maxDeposit(address receiver) external view returns (uint256 maxAssets);

}