/*
You know that an address has a property .balance which gives you the balance in wei. You also know that an address has a function named .transfer(...) which lets you transfer from the contract to the address an amount in wei.
Difference .send and .transfer
There is another function called .send(...) which works like .transfer(...), but with a major difference: If the target address is a contract and the transfer fails, then .transfer will result in an exception and .send will simply return false, but the transaction won't fail.
Let's try this:
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Sender {
    receive() external payable {}

    // Function to transfer funds from the contract to a specified address
    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    // Function to send funds from the contract to a specified address
    function withdrawSend(address payable _to) public {
        // Attempt to send funds and store the success status in a variable
        bool sentSuccessful = _to.send(10);

        // Require that the sending of funds was successful, otherwise revert with an error message
        require(sentSuccessful, "Sending fund was unsuccessful");
    }
}


contract ReceiverNoAction {
    // Function to retrieve the balance of the contract
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {}
}


contract ReceiverAction {
    uint public balanceReceived;

    // Function to retrieve the balance of the contract
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    // Function to receive funds and update the balanceReceived variable
    receive() external payable {
        balanceReceived += msg.value;
    }
}

/*
Now, let's play around with this:
Deploy the Sender contract

fund the Sender contract with some 100 wei (hit transact to let it go to the receive function)

Deploy the ReceiverNoAction and copy the contract address

Send 10 wei to the ReceiverNoAction with withdrawTransfer. It works, because the function receive in ReceiverNoAction doesn't do anything and doesn't use up more than 2300 gas

Send 10 wei to the ReceiverNoAction with withdrawSend. It also works, because the function still does not need more than 2300 gas.

Deploy the ReceiverAction Smart contract and copy the contract address

Send 10 Wei to the ReceiverAction with withdrawTransfer. It fails, because the contract tries to write a storage variable which costs too much gas.

Send 10 Wei to the ReceiverAction with withdrawSend. The transaction doesn't fail, but it also doesn't work, which leaves you now in an odd state. 👈🏻 That's the Problem right here.

Always check the return value of low level send functions. Ideally with an require(sentSuccessful) or so

Sending More Gas to Smart Contracts

Of course, it would be great if you can call smart contracts from other smart contracts and also send a value, as a well as, more gas.

There are two ways to achieve that:

External function calls on contract instances

Low-Level calls on the address

Let's start with the easy one, the external function call.

External Function Calls

Sometimes you want to call another smart contract. But not just that, you also want to send eth/wei to another smart contract. You're maybe wondering, how can that be achieved?

Let's have a look at this sample smart contract:
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

contract ContractOne {

    mapping(address => uint) public addressBalances;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {

    function deposit() public payable {}

    function depositOnContractOne(address _contractOne) public { 
        ContractOne one = ContractOne(_contractOne);
        one.deposit{value: 10, gas: 100000}(); 
    }
}

/*
How do we go about this?
Deploy ContractOne

Deploy ContractTwo

Send 1 ETH to ContractTwo.deposit()

Copy ContractOne Address and sent a transaction to ContractTwo.depositOnContractOne with the address from ContractOne.

You see that the ContractTwo address is the one who deposited the funds

And you also see that not all 100000 gas were used. The remainder was returned

You will witness that this time it works and it doesn't error out. And the reason is, because we supply 100000 gas to the ContractOne.deposit function. This, in turn, can now successfully write the storage variable.

You can also leave the gas amount, then it will forward all gas and let the called contract execute its logic and return the remainder. Safer is to provide an upper limit, just in case.

But that only works if you know:

That the receiving contract is a contract

And that the receiving contract has a specific function

But what if you don't know any of these? For example, a wallet withdrawTo method should possibly also work, if the receiving address is actually a contract that writes to storage variables.

This is where address.call comes in. Let's use the same example, but instead of a named contract calls, lets do this first semi-anonymous and then completely anonymous.

Low-Level Calls on Address-Type Variables

Let's change the contract from above to:
*/
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

contract ContractOne {

    mapping(address => uint) public addressBalances;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {

    function deposit() public payable {}

    function depositOnContractOne(address _contractOne) public { 
        bytes memory payload = abi.encodeWithSignature("deposit()");
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload);
        require(success);
    }
}

/*
What does it do? Exactly the same as above, but with low level calls (_contractOne.call) and therefore the typesafety is gone. We have to manually check if success returned true, otherwise there is no chance we know if the called contract errored out. Interestingly here, it needs slightly more gas as well than the version above.
But it can be even one level lower. Because, what if we don't even know the function to all at all. That means, we would need to send the funds to the fallback receive function in ContractOne.
Let's change the contract slightly:
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

contract ContractOne {

    mapping(address => uint) public addressBalances;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

   receive() external payable {

       addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {

    function deposit() public payable {}

    function depositOnContractOne(address _contractOne) public { 

       (bool success, ) = _contractOne.call{value: 10, gas: 100000}("");

       require(success);
    }
}

/*
What changed, you might ask?
Now we generically send 10 wei to the address _contractOne. This can be a smart contract. It can be a wallet. If its a contract it will always call the fallback function. But it will provide enough gas to execute arbitrary logic.

Re-Entrancy

Be careful here with so-called re-entrency attacks. If you provide enough gas for the called contract to execute arbitary logic, then its also possible for the smart contract to call back into the calling contract and potentially change state variables.
Always try to follow the so-called checks-effects-interactions pattern, where the external smart contract interaction comes last.
*/