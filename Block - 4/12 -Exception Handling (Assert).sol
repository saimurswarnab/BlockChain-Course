/*
Assert is used to check invariants. Those are states our contract or variables should never reach, ever. For example, if we decrease a value then it should never get bigger, only smaller.

Let's change a few things in our Smart Contract to add an integer roll-over bug that we can easily trigger.

Bug

This contract has an intentional limitation, which we will use to trigger a bug. To subsequently fix it.
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

contract ExceptionExample {
    mapping(address => uint8) public balanceReceived;

    /**
     * @dev Receive money and add it to the sender's balance.
     */
    function receiveMoney() public payable {
        balanceReceived[msg.sender] += uint8(msg.value);
    }

    /**
     * @dev Withdraw money from the sender's balance and transfer it to the specified address.
     * @param _to The address to transfer the funds to.
     * @param _amount The amount to withdraw.
     * @notice The amount to withdraw must be of type uint8.
     * @notice The maximum value that can be withdrawn is 255 (uint8 maximum value).
     */
    function withdrawMoney(address payable _to, uint8 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        // Check if the sender has sufficient balance to withdraw the requested amount.
        // If not, the transaction reverts with the provided error message.

        balanceReceived[msg.sender] -= _amount;
        // Subtract the withdrawn amount from the sender's balance.

        _to.transfer(_amount);
        // Transfer the requested amount to the specified address.
    }
}

/*
Deploy a new Contract Instance
Enter 257 Wei into the Value field
Hit "receiveMoney"


The Transaction goes through. Let's check our balance, we should have 257 Wei, or?



That's only 1 Wei. Where is the rest? What happened? 🤔
We are storing the balance in an uint8. Unsigned integers go from 0 to 2^n-1, so that's 2^8-1 or 255. So, it can store a max of 255 Wei. We sent 257 Wei to the contract. It automatically rolls over to 0. So, we end up with 257 - 255 - 1 (the 0 value) = 1.
How can we fix it?
Well, the obvious way here is to increase the uint8 to a uint256. But that is only half the story, because even with large numbers it can roll over. Okay okay, the obvious way is to use Solidity 0.8. But bear with me, there are many internal states a contract should never reach. And the easiest to showcase here is with integers and rollovers.
Add an Assert to check invariants
Asserts are here to check states of your Smart Contract that should never be violated. For example: a balance can only get bigger if we add values or get smaller if we reduce values.
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

contract ExceptionExample {
    mapping(address => uint8) public balanceReceived;

    /**
     * @dev Receive money and add it to the sender's balance.
     * @notice The received amount must be within the range of uint8.
     * @notice The balance after adding the received amount must not exceed the maximum value of uint8.
     */
    function receiveMoney() public payable {
        assert(msg.value == uint8(msg.value));
        // Ensure that the received amount fits within the range of uint8.

        balanceReceived[msg.sender] += uint8(msg.value);
        // Add the received amount to the sender's balance.

        assert(balanceReceived[msg.sender] >= uint8(msg.value));
        // Ensure that the balance after adding the received amount does not exceed the maximum value of uint8.
    }

    /**
     * @dev Withdraw money from the sender's balance and transfer it to the specified address.
     * @param _to The address to transfer the funds to.
     * @param _amount The amount to withdraw.
     * @notice The amount to withdraw must be less than or equal to the sender's available balance.
     * @notice The balance after subtracting the withdrawn amount must not be less than zero.
     */
    function withdrawMoney(address payable _to, uint8 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        // Check if the sender has sufficient balance to withdraw the requested amount.
        // If not, the transaction reverts with the provided error message.

        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        // Ensure that the balance after subtracting the withdrawn amount does not go below zero.

        balanceReceived[msg.sender] -= _amount;
        // Subtract the withdrawn amount from the sender's balance.

        _to.transfer(_amount);
        // Transfer the requested amount to the specified address.
    }
}

// Run it again. Try to input 257 Wei. Or also try run two transactions with 200 Wei each, so it doesn't overflow for the transaction itself, but for the second assertion, where it checks if the balance is still valid.
