// Add Partial Withdrawals
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MappingsStructExample {
    // Mapping to store the balance received by each address
    mapping(address => uint) public balanceReceived;


    // Function to get the total balance of the contract
    function getBalance() public view returns(uint) {
        // Return the balance of the contract (total amount held)
        return address(this).balance;
    }


    // Function to receive money and update the balance of the sender
    function sendMoney() public payable {
        // Increment the balance of the sender with the amount sent in the transaction
        balanceReceived[msg.sender] += msg.value;
    }


    // Function to withdraw a specific amount of money from the sender's balance
    function withdrawMoney(address payable _to, uint _amount) public {
        // Check if the sender has enough funds to withdraw the requested amount
        require(_amount <= balanceReceived[msg.sender], "Not enough funds");

        // Deduct the withdrawn amount from the sender's balance
        balanceReceived[msg.sender] -= _amount;

        // Transfer the requested amount to the specified address
        _to.transfer(_amount);
    }


    // Function to withdraw the entire balance of the sender
    function withdrawAllMoney(address payable _to) public {
        // Get the balance to send out
        uint balanceToSend = balanceReceived[msg.sender];

        // Set the sender's balance to 0 (withdrawn all)
        balanceReceived[msg.sender] = 0;

        // Transfer the balance to the specified address
        _to.transfer(balanceToSend);
    }
}


/*
Run the Smart Contract
To understand what's going on here:
When someone withdraws funds, we check if the amount he wants to withdraw is smaller or equal than the amount he previously deposited. If yes, then we deduct the amount from his balance and send out the funds.


Deposit and Withdraw 50%
We will deposit 1 Ether from Account#1 and Withdraw 50% to Account#3. I won't provide Screenshots for the first few steps, since it's exactly the same as previously:
select Account#1 from the Accounts Dropdown
Value: 1 Ether
Hit the "sendMoney" button
Select Account#3 from the Accounts Dropdown
Copy the Address And Paste it in the "withdrawMoney" Input field
Add "500000000000000000" as amount
Switch back to Account#1 and hit the "withdrawMoney" button.
Check the Balance of "Account#3"

*/
