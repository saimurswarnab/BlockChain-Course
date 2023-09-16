/*
A pure function is a function that neither writes, nor reads from state variables. It can only access its own arguments and other pure functions. Let me give you an example:
*/

//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleViewPure {
    uint public myStorageVariable; // Public state variable to store an unsigned integer.

    // Function to get the value of 'myStorageVariable'.
    // The function is marked as 'view' to indicate that it doesn't modify the contract's state.
    // 'view' functions can read state variables but cannot modify them.
    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable; // Return the current value of 'myStorageVariable'.
    }

    // Function to perform addition of two unsigned integers 'a' and 'b'.
    // The function is marked as 'pure' since it doesn't read or modify any state variables.
    // 'pure' functions are used for computations and cannot read or modify state variables.
    function getAddition(uint a, uint b) public pure returns(uint) {
        return a + b; // Return the sum of 'a' and 'b'.
    }

    // Function to set the value of 'myStorageVariable' to a new value specified by '_newVar'.
    // The function modifies the state variable 'myStorageVariable'.
    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar; // Update 'myStorageVariable' with the new value '_newVar'.
        return _newVar; // Return the new value '_newVar'.
    }
}
