/*
A view function is a function that reads from the state but doesn't write to the state. A classic view function woule be a getter-function. Let's extend the smart contract and write one:
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

    // Function to set the value of 'myStorageVariable' to a new value specified by '_newVar'.
    // The function is marked as 'pure' since it only modifies the local variable '_newVar'.
    // 'pure' functions cannot read or modify state variables.
    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar; // Update 'myStorageVariable' with the new value '_newVar'.
        return _newVar; // Return the new value '_newVar'.
    }
}
