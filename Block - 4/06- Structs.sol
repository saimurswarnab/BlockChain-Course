/*
Using Structs
Let's change the Smart Contract above to use a struct instead. A struct is a way to generate a new DataType, by basically grouping several simple Data Types together - or group groups of simple types together, like a mapping.
Change the contract from above to:
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract Wallet2 {
    // Define a struct to hold the payment received information
    struct PaymentReceivedStruct {
        address from; // Address of the sender
        uint amount; // Amount of Ether received
    }
    // Declare a variable of the struct type to store payment information
    PaymentReceivedStruct public payment;

    // Function to receive payment and update the payment struct
    function payContract() public payable {
        // Create a new instance of the PaymentReceivedStruct and assign values to its properties
        payment = PaymentReceivedStruct(msg.sender, msg.value);
    }
}

/*
If you interact with the contract now, and you send the same 1 wei to the payContract function you will witness two things:
It suddenly costs only 75394 gas (almost 3 times less!)
You can directly interact with the payment public getter function without interacting with a separate contract.
Now you're probably thinking, what is the rule of thumb here?! Good question!
*/

