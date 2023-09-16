// Let's create a Smart Contract which will always fail to execute.
// Create a new file in Remix with the following content:

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract WillThrow {
    /**
     * @dev A function that intentionally throws an error.
     * It uses the `require` statement to check a condition that will always evaluate to false.
     * When the condition fails, the transaction is reverted and an error message is displayed.
     * This function does not modify the contract state or read any external state.
     */
    function aFunction() public {
        require(false, "Error message");
        // The require statement with a false condition will always trigger an error.
        // The transaction will be reverted, and the provided error message will be displayed.
    }
}

// Now let's add a contract directly underneath that catches the error within a function call and instead emits an event with the error message. It will catch the error, and instead of unsuccessfully showing an error, it will successfully mine the transaction. During the transaction, it will emit an event that shows the error message. You can see it later in the transaction logs.

// See
    /**
     * @dev Function to catch and handle an error thrown by another contract.
     * It creates an instance of the `WillThrow` contract and attempts to execute its `aFunction`.
     * If the `aFunction` throws an error, it catches the error and emits an `ErrorLogging` event
     * with the error message.
     */
    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            // Here we could perform additional actions if the function execution succeeds,
            // but in this case, it will always throw an error and not reach this point.
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
            // Catch the error and emit an event with the error message.
        }
    }
}



