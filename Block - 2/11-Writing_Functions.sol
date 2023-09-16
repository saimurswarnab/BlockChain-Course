/*
Writing, View and Pure Functions¶
So far, we have mostly interacted and modified state variables from our Smart Contract. For example, when we write the address, we modify a state variable. When we update an uint variable, we also modify the state.
For this, we needed to send a transaction. That works very transparently in Remix and also looks instantaneous and completely free of charge, but in reality it isn't. Modifying the State costs gas, is a concurrent operation that requires mining and doesn't return any values.
Reading values, on the other hand, is virtually free and doesn't require mining.
There are two types of reading functions:
view: Accessing state variables
pure: Not accessing state variables
*/

// As before, let's quickly create a state-modifing writing function:
//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleViewPure {

    uint public myStorageVariable;

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }

}

/*
As you can see here, a writing function can have return variables, but they won't actually return anything to the transaction initializer. There are several reason for it, but the most prominent one is: at the time of sending the transaction the actual state is unknown. It is possible that someone sends a competing transaction that alters the state and from there it only depends on the transaction ordering - which is something that happens on the miner side. You will see that extensively in the next section.
What's the return variable for then?
It's for Smart Contract communication. It is used to return something when a smart contract calls another smart contract function.
How to return variables then in Solidity? With Events! Something we're talking about later on.
*/
