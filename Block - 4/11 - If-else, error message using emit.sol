//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessageExample {
    event ErrorMessage(string message);

    /**
     * @dev Show a message if the provided value is less than 10.
     * @param value The value to check.
     */
    function showMessage(uint value) public {
        if (value < 10) {
            // Emit an error message event if the condition is not satisfied
            emit ErrorMessage("Value must be greater than or equal to 10");
        } else {
            // Perform other actions when the condition is satisfied
            // ...
        }
    }
}

