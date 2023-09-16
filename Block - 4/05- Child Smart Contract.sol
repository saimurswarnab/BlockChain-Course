/*
Solidity Structs

If you come from an object oriented programming language, you are normally used to declare a new class for logical group of variables.

In solidity you could define a new contract and give it certain properties, but usually that's extremely gas inefficient.

Solidity uses structs to define new datatypes and group several variables together.
*/

// Child Smart Contract
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract PaymentReceived {
    // Store the address of the sender and the amount of Ether received
    address public from;
    uint public amount;

    // Constructor to initialize the PaymentReceived contract with the sender's address and received amount
    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}


contract Wallet {
    // Declare a public variable to store the PaymentReceived contract instance
    PaymentReceived public payment;


    // Function to pay the contract and create a new PaymentReceived instance
    function payContract() public payable {
        // Create a new instance of the PaymentReceived contract with the sender's address and received amount
        payment = new PaymentReceived(msg.sender, msg.value);
    }
}

/*
If you deploy the "Wallet" smart contract and send 1 wei to the payContract function (1) , it will use up 221530 gas (2). Why? Because it deploys a new contract "PaymentReceived", then links it.

If you now want to interact with the contract, you actually need to tell Remix where to find its address (3) and then interact with it because its a normal contract (4).
Now, I know this is the "normal" way for everyone who is coming from an object oriented language out there. And there are good reasons to do so normally, but with Solditiy you are facing the challenge of limited resources

*/
