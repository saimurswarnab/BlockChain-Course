// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdfundingCampaign {
    address public creator;
    uint256 public goal;
    uint256 public deadline;
    mapping(address => uint256) public contributions;
    bool private campaignEnded;
    bool private campaignSuccessful;

    constructor(uint256 _goal, uint256 _durationInMinutes) {
        creator = msg.sender;
        goal = _goal * 1 ether; // Convert goal amount to Wei (1 ether = 1e18 Wei)
        deadline = block.timestamp + _durationInMinutes * 1 minutes;
        campaignEnded = false;
        campaignSuccessful = false;
    }

    function contribute() external payable {
        require(!campaignEnded, "Campaign has ended");
        require(block.timestamp < deadline, "Campaign deadline has passed");
        contributions[msg.sender] += msg.value;
    }

    function checkCampaignStatus() external {
        require(!campaignEnded, "Campaign has already ended");

        if (block.timestamp >= deadline) {
            campaignEnded = true;
            if (address(this).balance >= goal) {
                campaignSuccessful = true;
            }
        }
    }

    function withdrawFunds() external {
        require(campaignEnded, "Campaign is still ongoing");
        require(!campaignSuccessful, "Campaign was successful");
        uint256 amount = contributions[msg.sender];
        require(amount > 0, "No funds to withdraw");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function transferFundsToCreator() external {
        require(campaignEnded, "Campaign is still ongoing");
        require(campaignSuccessful, "Campaign was not successful");
        require(msg.sender == creator, "Only the creator can call this function");

        payable(creator).transfer(address(this).balance);
    }
}
