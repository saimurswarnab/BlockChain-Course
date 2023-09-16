// Exception Handling: Require, Assert and Revert in Solidity
/*
The Smart Contract
Let's start with this basic Smart Contract. Attention, it's written in Solidity 0.6, not the latest version, because of the integer roll-over example that we will demonstrate.
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
contract ExceptionRequireExample {
    mapping(address => uint) public balanceReceived;

    /**
     * @dev Receive money and add it to the sender's balance.
     */
    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    /**
     * @dev Withdraw money from the sender's balance and transfer it to the specified address.
     * @param _to The address to transfer the funds to.
     * @param _amount The amount to withdraw.
     */
    function withdrawMoney(address payable _to, uint _amount) public {
        if (_amount <= balanceReceived[msg.sender]) {
            // Check if the sender has sufficient balance to withdraw the requested amount

            balanceReceived[msg.sender] -= _amount;
            // Subtract the withdrawn amount from the sender's balance

            _to.transfer(_amount);
            // Transfer the requested amount to the specified address
        }
        // If the sender does not have sufficient balance, the transaction fails silently
    }
}

/*
Okay, what does the Smart Contract do? It's a simplistic wallet contract.

You can send Ether to the Smart Contract (via receiveMoney).

You can withdraw Ether via withdrawMoney

The Balance of your account is stored in the balanceReceived mapping.

So far so good, its pretty in line what we did before. Pay attention to the withdrawMoney function. There is an if-else control structure. If you don't have enough balance, then simply nothing happens. That is not ideal, there is no user-feedback.
Let's give it a try!

Copy your address into the withdraw money field.

Enter a number, like 1000, and Hit withdrawMoney

You see, the transaction works without any problem. That's not good, because internally nothing happened and the user has the feedback that he just did a withdrawal for 1000 wei. Although nothing happened.

Try yourself first

Before heading to the next step, try yourself first to replace the if/else with a require()

Require is here for user-input validation and if it evaluates to false, it will throw an exception.

For example require(false) or require(1 == 0) will throw an exception. You can optionally add an error message require(false, "Some Error Message")

Add a Require

Alright, now it's time to add a require instead of the if/else control structure. Did you try? Let's compare our code:
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;


contract ExceptionExample {
    mapping(address => uint) public balanceReceived;

    /**
     * @dev Receive money and add it to the sender's balance.
     */
    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    /**
     * @dev Withdraw money from the sender's balance and transfer it to the specified address.
     * @param _to The address to transfer the funds to.
     * @param _amount The amount to withdraw.
     */
    function withdrawMoney(address payable _to, uint _amount) public {
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
If you run this now and try to withdraw more Ether than you have, it will output an error. Repeat the steps from before:
Deploy a new Instance!

Copy your address

Enter an amount

Click on "withdrawMoney"

How cool is that! Not only your transaction fails, which is what we want, we also get proper feedback to the user. Great! But if we have require statements, what are assert for?

*/