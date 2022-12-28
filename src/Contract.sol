// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SimpleStorage {
    uint public storedData; //Do not set 0 manually it wastes gas!

    event setEvent();

    function set(uint x) public {
        require(storedData != x, "CANNOT_BE_SAME_VALUE");
        storedData = x;
        emit setEvent();
    }

}