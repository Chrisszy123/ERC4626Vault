// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC4626Vault {
    mapping(address => uint256) private balances;
    address private owner;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function deposit(uint256 amount) external payable {
        require(amount > 0, "Amount must be greater than zero");

        balances[msg.sender] += amount;

        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        emit Withdrawal(msg.sender, amount);

        // Transfer the amount to the caller
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function isOwner() external view returns (bool) {
        return msg.sender == owner;
    }

    function transferOwnership(address newOwner) external {
        require(msg.sender == owner, "Only the owner can transfer ownership");
        require(newOwner != address(0), "Invalid new owner");

        owner = newOwner;
    }
}
