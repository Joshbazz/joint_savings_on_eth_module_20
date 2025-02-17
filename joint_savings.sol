// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    function withdraw(uint amount, address payable recipient) public {
        require (recipient == accountOne || recipient == accountTwo, "You don't own this account");
        require (address(this).balance >= amount, "Insufficient Funds");

        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public{
        accountOne = account1;
        accountTwo = account2;
    }

    receive() external payable {}
    fallback() external payable {}
}
