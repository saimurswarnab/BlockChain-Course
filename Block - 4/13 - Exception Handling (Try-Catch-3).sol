// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ExternalContract {
    function divideByTwo(uint number) external pure returns (uint) {
        require(number > 0, "Number should be greater than zero");
        return number / 2;
    }
}

contract ExampleTryCatch {
    event ValueReceived(uint value);
    event ErrorOccurred(string error);

    ExternalContract externalContract;

    constructor(address _externalContract) {
        externalContract = ExternalContract(_externalContract);
    }

    function tryCatchExample(uint input) public {
        try externalContract.divideByTwo(input) returns (uint result) {
            emit ValueReceived(result);
        } catch Error(string memory errorMessage) {
            emit ErrorOccurred(errorMessage);
        }
    }
}



