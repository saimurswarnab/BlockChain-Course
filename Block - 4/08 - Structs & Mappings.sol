// Solidity Structs
/*
So far we relied on simple datatypes like addresses, uint or booleans. In the previous lecture we also grouped them together into structs and I showed you the difference between using smart contracts as data-stores vs structs as data-stores. But what if that's not enough and you need to track them in an array-like data-structure? Maybe you want to track the timestamp when a deposit happened. You want to track every single deposit from every user. You want to track how many deposits happened, and many more details.
“ Do only the most necessary functions on the blockchain, and everything else off-chain. But for sake of explaining Structs, we will track every single payment in the greatest detail possible with our Smart Contract.”
For the sake of this example, think about it like this:
While you are tracking the current balance with a mapping that maps address to uint (mapping( address => uint ) balanceReceived) with something schematically like balanceReceived[THE-ADDRESS] = THE-UINT, with a struct you would access the children with a . (period), while still retaining the mapping.
Let's say you have a struct
MyStruct {
    uint abc;
}

mapping(address => MyStruct) someMapping;

Then you would write to the mapping like this someMapping[THE-ADDRESS].abc = THE-UINT. Why is this useful? Let's have a look into our Smart Contract!

*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract mymapping {
    struct Transaction {
        uint amount; // Amount of the transaction
        uint timestamp; // Timestamp of the transaction
    }

    struct Balance {
        uint totalBalance; // Total balance of the address
        uint numDeposits; // Number of deposits made by the address
        mapping (uint => Transaction) deposits; // Mapping of deposit index to deposit transaction
        uint numWithdrawls; // Number of withdrawals made by the address
        mapping (uint => Transaction) withdrawls; // Mapping of withdrawal index to withdrawal transaction
    }

    mapping (address => Balance) public balances; // Mapping of address to its balance

    /**
     * @dev Get a specific deposit transaction of an address.
     * @param _from The address to retrieve the deposit transaction from.
     * @param _numDeposit The index of the deposit transaction to retrieve.
     * @return The deposit transaction with the specified index.
     */
    function getDepositNum (address _from, uint _numDeposit) public view returns (Transaction memory) {
        return balances[_from].deposits[_numDeposit];
    }

    /**
     * @dev Get a specific withdrawal transaction of an address.
     * @param _from The address to retrieve the withdrawal transaction from.
     * @param _numWithdrawl The index of the withdrawal transaction to retrieve.
     * @return The withdrawal transaction with the specified index.
     */
    function getWithdrawNum (address _from, uint _numWithdrawl) public view returns (Transaction memory) {
        return balances[_from].withdrawls[_numWithdrawl];
    }

    /**
     * @dev Deposit money to the contract.
     */
    function depositMoney() public payable {
        // Increase the total balance of the sender's address
        balances[msg.sender].totalBalance += msg.value;

        // Create a new deposit transaction with the deposited amount and current timestamp
        Transaction memory deposit = Transaction(msg.value, block.timestamp);

        // Store the deposit transaction in the deposits mapping of the sender's address
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;

        // Increment the number of deposits made by the sender's address
        balances[msg.sender].numDeposits++;
    }


    /**
     * @dev Withdraw money from the contract.
     * @param _to The address to transfer the withdrawal amount to.
     * @param _amount The amount to withdraw.
     */
    function withdrawMoney (address payable _to, uint _amount) public {
        // Decrease the total balance of the sender's address by the withdrawal amount
        balances[msg.sender].totalBalance -= _amount;

        // Create a new withdrawal transaction with the withdrawal amount and current timestamp
        Transaction memory withdrawal = Transaction(_amount, block.timestamp);

        // Store the withdrawal transaction in the withdrawals mapping of the sender's address
        balances[msg.sender].withdrawls[balances[msg.sender].numWithdrawls] = withdrawal;

        // Increment the number of withdrawals made by the sender's address
        balances[msg.sender].numWithdrawls++;

        // Transfer the specified amount to the provided address
        _to.transfer(_amount);
    }
}

/*

Mapping has no Length
Mappings have no length. It's important to understand this. Arrays have a length, but, because how mappings are stored differently, they do not have a length.
Let's say you have a mapping mapping(uint => uint) myMapping, then all elements myMapping[0], myMapping[1], myMapping[123123], ... are already initialized with the default value. If you map uint to uint, then you map key-type "uint" to value-type "uint".

Structs are initialized with their default value
Similar to anything else in Solidity, structs are initialized with their default value as well.
If you have a struct
struct Transaction {
    uint amount;
    uint timestamp;
}

and you have a mapping mapping(uint => Transaction) myMapping, then you can access already all possible uint keys with the default values. This would produce no error:
myMapping[0].amount, or myMapping[123123].amount, or myMapping[5555].timestamp.
Similar, you can set any value for any mapping key:
myMapping[1].amount = 123 is perfectly fine.

So, with these two things in mind, structs allow you to define something similar like cheap objects.
Back to our Smart Contract.
Balance <-> Transaction relationship
If you have a look at the two structs, then you see there is also a mapping inside:
  struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
       mapping(uint => Transaction) deposits;
       //...
    }

    mapping(address => Balance) public balanceReceived;
    //...
Because mappings have no length, we can't do something like balanceReceived.length or payments.length. It's technically not possible. In order to store the length of the deposits mapping, we have an additional helper variable numDeposits.
So, if you want to the first payment for address 0x123... you could address it like this: balanceReceived[0x123...].deposits[0].amount = .... But that would mean we have static keys for the payments mapping inside the Balance struct. We actually store the keys in numDeposits, that would mean, the current payment is in balanceReceived[0x123...].numDeposits. If we put this together, we can do balanceReceived[0x123...].deposits[balanceReceived[0x123...].numDeposits].amount = ....
Enough talking, let's give it a try!

*/

