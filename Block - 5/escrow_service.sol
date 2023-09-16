// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public buyer;
    address public seller;
    address public arbiter;
    uint256 public amount;
    bool public buyerConfirmed;
    bool public sellerConfirmed;
    bool public fundsReleased;

    constructor(address _buyer, address _seller, address _arbiter) {
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
    }

    function confirmTrade() external {
        require(msg.sender == buyer || msg.sender == seller, "Only buyer or seller can confirm the trade");
        
        if (msg.sender == buyer) {
            require(!buyerConfirmed, "Buyer has already confirmed the trade");
            buyerConfirmed = true;
        } else {
            require(!sellerConfirmed, "Seller has already confirmed the trade");
            sellerConfirmed = true;
        }
    }

    function releaseFunds() external {
        require(buyerConfirmed && sellerConfirmed, "Both buyer and seller must confirm the trade before releasing funds");
        require(!fundsReleased, "Funds have already been released");

        fundsReleased = true;
        payable(seller).transfer(amount);
    }

    function deposit() external payable {
        require(msg.sender == buyer, "Only buyer can deposit funds");
        require(msg.value > 0, "Funds should be greater than zero");
        require(!buyerConfirmed && !sellerConfirmed, "Trade has already been confirmed");
        amount = msg.value;
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
