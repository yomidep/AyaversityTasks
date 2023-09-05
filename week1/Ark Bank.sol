// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArkBank {  //Declaring the bank contract
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {  // Certain functions only the contract deployer can call
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function deposit() public payable { // Deposit Function
        require(msg.value > 0, "Deposit amount must be more than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {  // Withdraw Function
        require(amount > 0, "Withdrawal amount must be more than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256) {   // Check Balance Function
        return balances[msg.sender];
    }

    function transfer(address to, uint256 amount) public {  // Transfer from one user to another
        require(to != address(0), "Invalid address");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function close() public onlyOwner {  // Function to close account
    require(address(this).balance > 0, "Contract balance is zero");
    payable(owner).transfer(address(this).balance);
}

}
