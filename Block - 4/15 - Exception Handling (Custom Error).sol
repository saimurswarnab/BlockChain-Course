// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


// Contract that demonstrates throwing a custom error
contract WillThrow {
    // Define a custom error called ThisIsACustomError
    error ThisIsACustomError(string, string);


    // Function that throws the custom error
    function aFunction() public pure {
        // Use the revert keyword to revert execution and throw the custom error
        revert ThisIsACustomError("Text 1", "text message 2");
    }
}

/*
The ThisIsACustomError error is defined using the error keyword. It specifies two parameters, string and string, to represent the custom error message.

The aFunction function is a public pure function that demonstrates the usage of custom errors and the revert statement. When called, it triggers a revert using the custom error ThisIsACustomError with the specified error message "Text 1" and "Text message 2".

*/