/* 
Address Types
One type, which is very specific to Ethereum and Solidity, is the type "address".
Ethereum supports transfer of Ether and communication between Smart Contracts. Those reside on an address. Addresses can be stored in Smart Contracts and can be used to transfer Ether from the Smart Contract to to an address stored in a variable.
That's where variables of the type address come in.
In general, a variable of the type address holds 20 bytes. That's all that happens internally. Let's see what we can do with Solidity and addresses.
*/

// Let's create a new Smart Contract to have an example.

//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleAddress {

    address public someAddress;

    function setSomeAddress(address _someAddress) public {
        someAddress = _someAddress;
    }

    function getAddressBalance() public view returns(uint) {
        return someAddress.balance;
    }

}

/*
Important Concepts
As you continue, please pay special attention to the following few concepts here which are really important and different than in any other programming language:
The Smart Contract is stored under its own address
The Smart Contract can store an address in the variable "someAddress", which can be its own address, but can be any other address as well.
All information on the blochain is public, so we can retrieve the balance of the address stored in the variable "someAddress"
The Smart Contract can transfer funds from his own address to another address. But it cannot transfer the funds from another address.
Transferring Ether is fundamentally different than transferring ERC20 Tokens or NFTs, as you will see later.
Before you continue, read the statements above and keep them in mind. These are the most mind-blowing facts for Ethereum newcomers.

*/