/*
Strings are actually arbitrary long bytes in UTF-8 representation. Strings do not have a length property, bytes do have that. Let's run an example and add a bytes variable with the same "Hello World".
*/

//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleStrings {

    string public myString = "Hello World";

    bytes public myBytes = "Hello World";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }

    function compareTwoStrings(string memory _myString) public view returns(bool) {
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }

    function getBytesLength() public view returns(uint) {
       return myBytes.length;
   }

}
