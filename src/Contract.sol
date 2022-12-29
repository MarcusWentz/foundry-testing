// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage {

    uint  public storedData;  //Do not set 0 manually it wastes gas!
    uint  public ownerUnixTimeContract; 
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    event setOpenDataEvent(address indexed user, uint newValue); //Topics and other event arguments used for Foundry testing. Event arguments like this use gas in production so be careful.
    event setOwnerDataEvent(uint newOwnerUnixTime);
    event donateToOwnerEvent();


    function set(uint x) public {
        require(storedData != x, "CANNOT_BE_SAME_VALUE"); //WRITE AS CUSTOM ERROR!
        storedData = x;
        emit setOpenDataEvent(msg.sender, x); //Topic 1 (user) and other argument not indexed (newValue) for Foundry.
    }

    function setOwnerData() public {
        require(msg.sender == owner, "YOU_ARE_NOT_THE_OWNER!"); //WRITE AS CUSTOM ERROR!
        ownerUnixTimeContract = block.timestamp;
        emit setOwnerDataEvent(block.timestamp);
    }

    // function donateToOwner() public payable {
    //     require(msg.value > 0, "MSG.VALUE_IS_ZERO!"); //WRITE AS CUSTOM ERROR!
    //     payable(owner).transfer(address(this).balance);
    //     emit donateToOwnerEvent();
    // }

}