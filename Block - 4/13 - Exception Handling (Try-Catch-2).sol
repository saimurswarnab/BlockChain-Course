// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract ErrorHandling {
    event ErrorLogging(string reason);
   
    function divide(uint numerator, uint denominator) public {
        uint result;
        try this.divideNumbers(numerator, denominator) returns (uint quotient) {
            result = quotient;
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
       
        // Process the result or handle errors further if needed
    }
   
    function divideNumbers(uint numerator, uint denominator) public pure returns (uint) {
        require(denominator != 0, "Divisor cannot be zero");
        return numerator / denominator;
    }
}
