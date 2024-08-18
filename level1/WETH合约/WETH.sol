// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract WETH {
    string public name = "Wrapped Ether";
    string public symbol = "WETH";
    uint8 public decimals = 18;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    event Deposit(address indexed addr, uint256 amount);
    event Withdraw(address indexed addr, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed from,
        address indexed delegateAds,
        uint256 amount
    );

    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "balance is not enough");
        balanceOf[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function appoval(address delegateAds, uint256 amount)
        public
        returns (bool)
    {
        allowance[msg.sender][delegateAds] = amount;
        emit Approval(msg.sender, delegateAds, amount);
        return true;
    }

    function transfer(address _to, uint256 amount) public returns (bool) {
        return transferFrom(msg.sender, _to, amount);
    }

    function transferFrom(
        address src,
        address _to,
        uint256 amount
    ) public returns (bool) {
        if (msg.sender != src) {
            require(balanceOf[msg.sender] >= amount);
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[msg.sender] -= amount;
        balanceOf[_to] += amount;
        emit Transfer(src, _to, amount);
        return true;
    }

    fallback() external payable {
        deposit();
    }

    receive() external payable {
        deposit();
    }
}
