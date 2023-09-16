/*
Fallback Functions: receive Ether
So far, all we did, was to receive Ether through an explicit function call. But how can you actually send a plain eth transaction to a smart contract?
That is, through the receive function and/or through the fallback function.
Example Contract
Add this contract to Remix:
*/

//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract SampleFallback {
    uint public lastValueSent;
}

/*
If you try and send 1 wei to this contract, it will fail:
  
Enter 1 Wei (or basically any value > 0) into the value field
1. Hit the "transact" button, so you send a low-level transaction
2. You will get an error that you need a receive or payable fallback function
The Receive Function
Let's add a receive function first, to showcase how that works.
Extend the Smart Contract, so it records the value sent and the function string:
*/

//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract SampleFallback {
    uint public lastValueSent;
    string public lastFunctionCalled;


   receive() external payable {
       lastValueSent = msg.value;
       lastFunctionCalled = "receive";
   }
}

/*
If you try to send now 1 wei using the low-level transact and then look into the "lastValueSent" function, as well as the "lastFunctionCalled" getter function, you will get "1" and "receive":
  
The Fallback Function
Let's now extend the smart contract to add a fallback function to the contract:
*/


//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract SampleFallback {
    uint public lastValueSent;
    string public lastFunctionCalled;


    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

   fallback() external payable {
       lastValueSent = msg.value;
       lastFunctionCalled = "fallback";
   }
}

/*
If you now, again, send 1 wei to the smart contract using the low-level transact functionality, yet again, the lastFunctionCalled will be receive:
  
Now, lets try "transact" with 0 value. You will see, the lastFunctionCalled will still be "receive".
But now, let's add a calldata 0x123456 and hit "transact" with 0 value:
  
Now, suddenly the "lastFunctionCalled" is fallback.
But what happens if you try to send 0x123456 as calldata with value > 0? Try it! Is it fallback or receive?
Receive vs Fallback
receive() is a function that gets priority over fallback() when a calldata is empty. But fallback gets precedence over receive when calldata does not fit a valid function signature.
*/