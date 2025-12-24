// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleATM {
    address public accountHolder;
    bool public isLocked;
    mapping(address => uint256) private ledger;

    event Deposit(address indexed user, uint256 amount);
    event Debit(address indexed user, uint256 amount);
    event LockStatusChanged(bool status);

    modifier onlyAccountHolder() {
        require(msg.sender == accountHolder, "Not authorized");
        _;
    }

    modifier whenActive() {
        require(!isLocked, "ATM is locked");
        _;
    }

    constructor() {
        accountHolder = msg.sender;
        isLocked = false;
    }

    function deposit() public payable whenActive {
        require(msg.value > 0, "Amount must be positive");
        ledger[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function debit(uint256 _value) public whenActive {
        require(ledger[msg.sender] >= _value, "Insufficient balance");

        ledger[msg.sender] -= _value;
        (bool success, ) = payable(msg.sender).call{value: _value}("");
        require(success, "Withdrawal failed");

        emit Debit(msg.sender, _value);
    }

    function inquiry() public view returns (uint256) {
        return ledger[msg.sender];
    }

    function toggleLock() public onlyAccountHolder {
        isLocked = !isLocked;
        emit LockStatusChanged(isLocked);
    }

    function totalLiquidity() public view onlyAccountHolder returns (uint256) {
        return address(this).balance;
    }
}