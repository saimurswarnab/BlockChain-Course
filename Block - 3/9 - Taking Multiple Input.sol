pragma solidity ^0.8.20;

contract MyContract {
    uint256 public number;
    string public text;
    address public owner;

    function setInput(uint256 _number, string memory _text, address _owner) public {
        number = _number;
        text = _text;
        owner = _owner;
    }
   
    function getInput() public view returns (uint256, string memory, address) {
        return (number, text, owner);
    }
}