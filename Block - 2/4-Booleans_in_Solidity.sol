//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleBoolean {

    bool public myBool; // Public boolean variable to store the value

    // Function to set the value of 'myBool'
    function setMyBool(bool _myBool) public {
        myBool = _myBool; // Assign the input value to 'myBool'
        // Alternatively, we can negate the value of '_myBool' and assign it:
        // myBool = !_myBool;
        // This would invert the value of 'myBool' (true to false or false to true).

        // Note: We can also use logical OR (||) or logical AND (&&) operators for more complex conditions.
    }
}