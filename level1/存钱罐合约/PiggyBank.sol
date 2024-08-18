// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract PiggyBank {
    address public owner; // PiggyBanks's owner
    mapping(address => uint256) public balances; // everyone's balance

    event Deposit(address indexed _addr, uint256 amount);
    event Withdraw(address indexed _addr, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insuffient balance.");
        require(address(this).balance >= amount, "Vault balance insufficient.");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
        balances[msg.sender] -= amount;

        emit Withdraw(msg.sender, amount);
    }

    function withdrawAll() public {
        require(msg.sender == owner, "Only owner can withdraw all funds.");
        selfdestruct(payable(owner));
    }
}
