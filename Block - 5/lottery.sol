// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Lottery {
    address public manager; // The manager who can start the lottery and pick a winner
    address public owner; // The owner of the contract who gets 20% of the total balance
    uint256 public ticketPrice; // The price of a single ticket in Wei
    uint256 public totalTickets; // Total number of tickets available
    uint256 public maxTickets; // Maximum number of tickets that can be sold
    uint256 public lotteryEndTime; // The timestamp when the lottery ends

    mapping(address => uint256) public ticketHolders;
    address[] public participants;

    bool public lotteryEnded;
    address public winner;

    event TicketPurchased(address indexed buyer, uint256 numOfTickets);
    event LotteryEnded(address indexed winner, uint256 prizeAmount);
    event OwnerShareWithdrawn(address indexed owner, uint256 amount);

    constructor(uint256 _ticketPrice, uint256 _maxTickets, uint256 _durationInMinutes) {
        manager = msg.sender;
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        maxTickets = _maxTickets;
        totalTickets = 0;
        lotteryEndTime = block.timestamp + _durationInMinutes * 1 minutes;
        lotteryEnded = false;
    }

    function buyTickets(uint256 numOfTickets) external payable {
        require(!lotteryEnded, "Lottery has ended");
        require(totalTickets + numOfTickets <= maxTickets, "Not enough tickets available");
        require(msg.value == ticketPrice * numOfTickets, "Incorrect payment amount");

        totalTickets += numOfTickets;
        ticketHolders[msg.sender] += numOfTickets;
        participants.push(msg.sender);

        emit TicketPurchased(msg.sender, numOfTickets);
    }

    function endLottery() external {
        require(block.timestamp >= lotteryEndTime, "Lottery end time has not been reached");
        require(!lotteryEnded, "Lottery has already ended");

        uint256 winningTicket = generateRandomNumber() % totalTickets;
        winner = participants[winningTicket];
        lotteryEnded = true;

        uint256 prizeAmount = address(this).balance * 80 / 100; // 80% for the winner
        uint256 ownerShare = address(this).balance - prizeAmount; // 20% for the owner
        payable(winner).transfer(prizeAmount);
        payable(owner).transfer(ownerShare);

        emit LotteryEnded(winner, prizeAmount);
    }

    function generateRandomNumber() internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants)));
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getParticipants() external view returns (address[] memory) {
        return participants;
    }
}
