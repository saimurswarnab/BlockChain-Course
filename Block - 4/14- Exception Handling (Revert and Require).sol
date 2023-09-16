//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RevertExample {
    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "Division by zero is not allowed");
       
        // Perform division
        uint256 result = a / b;

        // Check if the result is valid
        if (result > 100) {
            revert("Result is too large");
        }

        return result;
    }
}

/*
require: The require statement is used to validate a condition and revert the transaction if the condition evaluates to false. It is commonly used for input validation, preconditions, and enforcing contract rules. When a require statement fails, it reverts the transaction and returns any remaining gas to the caller. It also allows providing an optional error message to provide more information about the reason for the revert.

revert: The revert statement is used to explicitly revert the transaction and undo any state changes made so far. It can be used to handle exceptional situations or explicitly trigger a revert with a custom error message. When a revert statement is executed, it immediately stops the execution of the current function, rolls back all changes, and returns any remaining gas to the caller.


The key difference between require and revert is that require is primarily used for validating conditions and enforcing rules, while revert is used for explicitly reverting the transaction and providing custom error messages.

Here's a general guideline for their usage:
Use require to validate input parameters, enforce preconditions, or enforce contract rules.
Use revert to explicitly trigger a revert and provide custom error messages for exceptional conditions or specific logic requirements.

*/