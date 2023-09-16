//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract ExampleMsgSender {
    address public someAddress; // Public variable to store an Ethereum address.

    // Function to update the value of 'someAddress' with the address of the sender.
    // The address of the sender is provided by the 'msg.sender' keyword in Solidity.
    function updateSomeAddress() public {
        someAddress = msg.sender; // Assign the address of the sender to 'someAddress'.
    }
}
