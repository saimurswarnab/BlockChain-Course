// Solidity Mapping of mappings
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract mappingsofmappings{
   
    mapping(uint => mapping(uint => bool)) uintUintBoolMapping;

    function setUintUintBoolMapping(uint _index1, uint _index2, bool _value) public {
        uintUintBoolMapping[_index1][_index2] = _value;
    }

    function getUintUintBoolMapping(uint _index1, uint _index2) public view returns (bool) {
        return uintUintBoolMapping[_index1][_index2];
    }
}


/*
Run the Smart Contract
The mapping uintUintBoolMapping is declared as mapping(uint => mapping(uint => bool)). It is a mapping that associates a pair of unsigned integer keys with a boolean value. Think of it as a grid or a table where the rows and columns are represented by unsigned integers, and each cell in the grid holds a boolean value.
*/

/* 
The setUintUintBoolMapping function allows you to set a value in the mapping by providing the two indices _index1 and _index2, and the boolean value _value. It assigns the _value to uintUintBoolMapping[_index1][_index2], which means it sets the boolean value at the given indices in the mapping.


For example, if you call setUintUintBoolMapping(1, 2, true), it will set the boolean value at the coordinates (1, 2) in the mapping to true.


The getUintUintBoolMapping function allows you to retrieve the boolean value from the mapping by providing the two indices _index1 and _index2. It returns the boolean value stored at uintUintBoolMapping[_index1][_index2].


For example, if you call getUintUintBoolMapping(1, 2), it will return the boolean value stored at the coordinates (1, 2) in the mapping.

*/
