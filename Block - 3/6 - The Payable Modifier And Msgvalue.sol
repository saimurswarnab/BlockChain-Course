// Sample Smart Contract
// This is the Smart Contract we're getting started with:

//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SampleContract {
    string public myString = "Hello World";


    function updateString(string memory _newString) public {
        myString = _newString;
    }
}

/*
In order for it to receive Eth, you need to add two things here:
1. you need to add the payable modifier. That is the keyword "payable" right next to the visibility specifier "public"
2. you need to understand the global msg-objects property called value. msg.value.
But before that, try to send 1 eth to the smart contracts "updateString" function. You will see it ends in an error.
*/

/*
The first thing we need to change is the "payable" modifier.
What is the payable modifier
The payable modifier tells solidity that the function is expecting eth to receive. That's it! Let's expand our smart contract so it can receive eth:
*/

//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract SampleContract {
    string public myString = "Hello World"
    function updateString(string memory _newString) public payable {
        myString = _newString;
    }
}

/*
What is msg.value
You're probably wondering what exactly is the msg-object. The msg-object contains information about the current message with the smart contract. It's a global variable that can be accessed in every function.
*/


// Let's extend the smart contract to charge 1 eth for each string update:
//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract SampleContract {
    string public myString = "Hello World";
    function updateString(string memory _newString) public payable {
        if(msg.value == 1 ether) {
            myString = _newString;
        } else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}


// Run it again, and you'll see that every time you send 1 eth, you can update the string. But if you send less or more, you just get refunded.