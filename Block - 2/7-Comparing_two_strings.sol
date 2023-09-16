/*
There are no native string comparison functions in Solidity. There is still a way to compare two strings: by comparing their keccak256 hashes.
Extend the contract with the highlighted part:
*/

//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleStrings {

    string public myString = "Hello World";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }



   function compareTwoStrings(string memory _myString) public view returns(bool) {


       return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));


   }

}
