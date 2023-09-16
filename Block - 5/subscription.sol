// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SubscriptionContract {
    address public owner;
    uint public subscriptionFee;
    mapping(address => bool) public subscribers;
    
    event NewSubscription(address subscriber);
    
    constructor(uint fee) {
        owner = msg.sender;
        subscriptionFee = fee;
    }
    
    function subscribe() external payable {
        require(msg.value >= subscriptionFee, "Insufficient payment for subscription");
        require(!subscribers[msg.sender], "Already subscribed");
        
        subscribers[msg.sender] = true;
        
        emit NewSubscription(msg.sender);
    }
    
    function unsubscribe() external {
        require(subscribers[msg.sender], "Not subscribed");
        
        subscribers[msg.sender] = false;
    }
    
    function updateSubscriptionFee(uint newFee) external {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        
        subscriptionFee = newFee;
    }
    
    function withdrawFunds() external {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        
        uint balance = address(this).balance;
        require(balance > 0, "No funds available for withdrawal");
        
        payable(owner).transfer(balance);
    }
}
