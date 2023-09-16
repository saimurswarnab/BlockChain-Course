// Withdrawals using Mappings
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract ExampleMappingWithdrawls {
    // Mapping to store user balances
    mapping (address => uint) public balanceReceived;

    // Function to deposit money
    function depositMoney() public payable {
        // Increment the user's balance with the amount sent in the transaction
        balanceReceived[msg.sender] += msg.value;
    }

    // Function to get the total balance of the contract
    function getBalance() public view returns(uint) {
        // Return the balance of the contract (total amount held)
        return address(this).balance;
    }

    // Function to withdraw all money from the contract
    function withdrawAllMoney(address payable _to) public {
        // Get the balance to send out
        uint balanceToSendOut = balanceReceived[msg.sender];
        // Set the user's balance to 0 (withdrawn all)
        balanceReceived[msg.sender] = 0;
        // Transfer the balance to the specified address
        _to.transfer(balanceToSendOut);
    }
}

/*
Run the Smart Contract
When someone sends money using the "sendMoney" function, we track the msg.value (amount in Wei) with the balanceReceived mapping for the person who interacted with the Smart Contract.
If that same person tries to withdraw money again using "withdrawAllMoney", we look in that mapping how much he sent there previously, then reset the mapping and send the amount.
Deposit and Withdraw

We will deposit 1 Ether from two different accounts and then withdraw Ether again:

select Account#1 from the Accounts Dropdown
Value: 1 Ether
Hit the "sendMoney" button
Select Account#2 from the Accounts Dropdown
Value: 1 Ether
Hit the "sendMoney" button

Now check the Balance of the Smart Contract:

You have 2 Ether (2 * 10^18 Wei) in the Smart Contract. But if you check the accounts individual amount from the mapping, then you see that each account can max withdraw 1 Ether:



Withdraw all Money to Account#3
Let's withdraw all the funds stored in the Smart Contract to Account#3 from the Accounts Dropdown:
Copy the address of Account#3 (select Account#3, copy)
Paste the Address into the withdrawAllMoney input field, but don't hit the button yet
Go back to Account#1
Hit the "withdrawAllMoney" button with Account#3-Address in the input field
Select Account#2 from the Accounts Dropdown
Hit the "withdrawAllMoney" button again with Account#3-Address in the input field
Check the Balance of the Smart Contract and of Account#3

*/

