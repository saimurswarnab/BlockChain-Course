//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleUint {
    uint256 public myUint; // Unsigned integer variable capable of storing values from 0 to (2^256)-1
    // Note: If we use and assign a default value again, it will not cost extra gas.

    uint8 public myUint8 = 250; // Unsigned 8-bit integer variable with an initial value of 250.

    uint8 public myUint8_EXP = 2**4; // Unsigned 8-bit integer variable with an initial value of 16.
    // The exponentiation operation is done using the ** operator.

    int public myInt = -10; // Signed integer variable capable of storing values from -2^128 to +2^128-1.

    // Function to set the value of 'myUint'
    function setMyUint(uint _myUint) public {
        myUint = _myUint; // Assign the input value to 'myUint'
    }

    // Function to decrement 'myUint' by 1
    function decrementUint() public {
        myUint--;
    }

    // Function to increment 'myUint8' by 1
    function incrementUint8() public {
        myUint8++;
    }

    // Function to increment 'myInt' by 1
    function incrementInt() public {
        myInt++;
    }
}

/*Rounding with Integers
Integers in Solidity are always rounded down! If we divide e.g. 100 / 101 = 0.990... but in Solidity the result will be 0. Integers in Solidity are actually cut off (not even rounded), in other words always rounded down.*/


/*In case you don't know what exactly integers are, then let's define first what we're talking about:
An integer is [...] a number that can be written without a fractional component. For example, 21, 4, 0, and −2048 are integers, while 9.75, ... is not. https://en.wikipedia.org/wiki/Integer
Integral types may be unsigned (capable of representing only non-negative integers) or signed (capable of representing negative integers as well) https://en.wikipedia.org/wiki/Integer_(computer_science)
In layman's terms: Integers are numbers without decimals. Unsigned integers cannot be negative.
In Solidity there are several integers sizes available, which mostly influence the amount of gas used to store a value.
The smallest one is (u)int8 (0 to 2^8-1, or 0 to 255), the biggest one is uint256 (0 to 2^256 - 1, or 0 to a "very large number" 🤔)
Let's define a simpleSmart Contract first so we can set an integer and then read the value again.
*/

