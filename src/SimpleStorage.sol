// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

error sameStorageValue();
error notOwner();
error msgValueZero();
error etherNotSent();

contract SimpleStorage {

    uint256 public storedData;  //Do not set 0 manually it wastes gas!
    uint256 public ownerUnixTimeContract; 
    address public immutable OWNER;

    constructor() {
        OWNER = msg.sender;
    }

    event setOpenDataEvent(address indexed user, uint256 newValue); //Topics and other event arguments used for Foundry testing. Event arguments like this use gas in production so be careful.
    event setOwnerDataEvent(uint256 newOwnerUnixTime);
    event etherSentEvent();

    function set(uint256 x) public {
        if(storedData == x) revert sameStorageValue();       
        storedData = x;
        emit setOpenDataEvent(msg.sender, x); //Topic 1 (user) and other argument not indexed (newValue) for Foundry.
    }

    function setOwnerData() public {
        if(msg.sender != OWNER) revert notOwner();       
        ownerUnixTimeContract = block.timestamp;
        emit setOwnerDataEvent(block.timestamp);
    }

    function sendEther(address sendTo) public payable {
        if(msg.value == 0) revert msgValueZero();        
        (bool sent, ) = sendTo.call{value: msg.value}("");
        if(sent == false) revert etherNotSent();
        emit etherSentEvent();
    }

}