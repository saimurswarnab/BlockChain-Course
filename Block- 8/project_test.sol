// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Insurance {
    address[] public policyholders;
    mapping(address => uint) public policies;
    mapping(address => uint) public claims;
    address owner;
    uint public totalPremium;
    
    string message = "Congratulations! You have purchased a policy";

    constructor() {
        owner = msg.sender;
    }

    // Function to purchase a policy
    function purchasePolicy() public payable {
        require(msg.sender != owner, "You are the owner");
        require(msg.value == 5 ether, "You must send exactly 5 ether to purchase a policy");
        
        // Update policy information
        policyholders.push(msg.sender);
        policies[msg.sender] += msg.value;
        totalPremium += msg.value;
    }

    // Function to file a claim
    function fileClaim(uint amount) public {
        require(policies[msg.sender] > 0, "Must have a policy");
        require(amount > 0 && amount <= policies[msg.sender], "Invalid claim amount");
        
        // Update claim information
        claims[msg.sender] += amount;
    }
    
    // Function to approve a claim and transfer funds to the policyholder
    function approveClaim(address payable policyholder) public {
        require(msg.sender == owner, "Only the owner can approve claims");
        require(claims[policyholder] > 0, "No pending claims for this policyholder");
        
        uint claimAmount = claims[policyholder];
        claims[policyholder] = 0;  // Reset the claim amount
        
        // Transfer the approved claim amount to the policyholder
        require(policyholder.send(claimAmount), "Transfer failed");
    }
}