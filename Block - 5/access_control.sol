// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControl {
    address public owner;
    mapping(address => bool) public authorizedUsers;

    constructor() {
        owner = msg.sender;
        authorizedUsers[msg.sender] = true; // The contract owner is automatically authorized
    }

    function addAuthorizedUser(address newUser) external {
        require(msg.sender == owner, "Only the contract owner can add authorized users");
        require(newUser != address(0), "Invalid user address");
        authorizedUsers[newUser] = true;
    }

    function removeAuthorizedUser(address user) external {
        require(msg.sender == owner, "Only the contract owner can remove authorized users");
        require(user != address(0), "Invalid user address");
        authorizedUsers[user] = false;
    }

    function onlyAuthorizedFunction() external {
        require(authorizedUsers[msg.sender], "Only authorized users can call this function");

        // Example function logic for authorized users:
        // For simplicity, we're just emitting an event here, but you can have more complex logic
        emit AuthorizedFunctionCalled(msg.sender);
    }

    function onlyOwnerFunction() external {
        require(msg.sender == owner, "Only the contract owner can call this function");

        // Example function logic for the contract owner:
        // For simplicity, we're just emitting an event here, but you can have more complex logic
        emit OwnerFunctionCalled(msg.sender);
    }

    // Example events for demonstration purposes
    event AuthorizedFunctionCalled(address caller);
    event OwnerFunctionCalled(address caller);
}
