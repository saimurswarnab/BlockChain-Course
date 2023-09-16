/*
One thing we haven't really talked about yet is the constructor.
It's something you need to understand before we proceed!
The constructor is a special function. It is automatically called during Smart Contract deployment. And it can never be called again after that.
It also has a special name! It's simply called constructor() { ... }.
Let's see how that works to our advantage. Let's extend the Smart Contract we wrote before to make it a bit more secure.
*/

//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleConstructor {

    address public myAddress;

    constructor(address _someAddress) {
        myAddress = _someAddress;
    }

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
    function setMyAddressToMsgSender() public {
        myAddress = msg.sender;
    }

}


/*
constructor(): is a special function that is called only once during contract deployment. It can have arguments, like here. But it also has the same global objects available as in any other transaction. So in msg.sender is the address of the person who deployed the Smart Contract, which you can use.
*/