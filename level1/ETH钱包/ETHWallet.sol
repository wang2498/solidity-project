// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherWallet {
    address payable public immutable owner;
    event Log(string funName, address from, uint256 value, bytes data);

    constructor() payable  {
        owner = payable(msg.sender);
    }
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, "");
    }
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    function withdraw1() external {
        require(msg.sender == owner, "Not owner");
        owner.transfer(100);
        // payable(msg.sender).transfer(100);
    }

    function withdraw2() external {
        require(msg.sender == owner, "Not owner");
        bool success = payable(msg.sender).send(200);
        require(success, "Call Failed");
    }

    function withdraw3() external {
        require(msg.sender == owner, "Not owner");
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Call Failed");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
