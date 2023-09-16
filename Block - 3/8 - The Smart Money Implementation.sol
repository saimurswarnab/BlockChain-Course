/*
Smart Money Implementation¶
Are you up for a small challenge?
Write a smart contract that allows for:
1. Deposits from everyone
2. Withdrawals only in the amount that was deposited by the person who likes to withdraw
Sample Solution
And this is my sample solution to the challenge:
*/


//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SendWithdrawMoney {


    uint public balanceReceived;
    function deposit() public payable {
        balanceReceived += msg.value;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance());
    }
}