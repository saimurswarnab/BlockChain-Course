/*
Strings are actually Arrays, very similar to a bytes-array. If that sounds too complicated, let me break down some quirks for you that are somewhat unique to Solidity:
Natively, there are no String manipulation functions.
No even string comparison is natively possible
There are libraries to work with Strings
Strings are expensive to store and work with in Solidity (Gas costs, we talk about them later)
As a rule of thumb: try to avoid storing Strings, use Events instead (more on that later as well!)
*/

/*
Example Smart Contract
Let's create the following example Smart Contract, store a String and retrieve it again:
*/


//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleStrings {

    string public myString = "Hello World";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }

}
