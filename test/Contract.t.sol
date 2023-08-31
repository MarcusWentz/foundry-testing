// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.18;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {

    //Functions fallback and receive used when the test contract is sent msg.value to prevent the test from reverting.
    fallback() external payable {}     // Fallback function is called when msg.data is not empty
    receive() external payable {}      // Function to receive Ether. msg.data must be empty

    //Define events here from other contracts since Foundry has trouble importing events from other contracts still.
    event setOpenDataEvent(address indexed user, uint newValue);
    event setOwnerDataEvent(uint newOwnerUnixTime);
    event donateToOwnerEvent();

    SimpleStorage simpleStorageInstance;

    function setUp() public {
        simpleStorageInstance = new SimpleStorage();
    }

    function testInitialStorage() public {
        assertEq(simpleStorageInstance.storedData(),0);
        assertEq(simpleStorageInstance.ownerUnixTimeContract(),0);
        assertEq(simpleStorageInstance.owner(),address(this));
    }

    function testSetValidPath() public {
        assertEq(simpleStorageInstance.storedData(),0);
        vm.expectEmit(true,false,false,true); // Events have bool flags for indexed topic parameters in order (3 topics possible) along with arguments that might not be indexed (last flag). You can also check which address sent the event.
        emit setOpenDataEvent(address(this),1); 
        simpleStorageInstance.set(1);
        assertEq(simpleStorageInstance.storedData(),1);
    }

    function testSetRevertPath() public {
        assertEq(simpleStorageInstance.storedData(),0);
        vm.expectRevert(sameStorageValue.selector);    //Revert if the new value matches the current storage value. Custom error from SimpleStorage. 
        simpleStorageInstance.set(0);
        assertEq(simpleStorageInstance.storedData(),0);
    }

    function testSetOwnerDataValidPath() public {
        assertEq(address(this),simpleStorageInstance.owner());
        assertEq(simpleStorageInstance.ownerUnixTimeContract(),0);
        vm.expectEmit(false,false,false,true); // Events have bool flags for indexed topic parameters in order (3 topics possible) along with arguments that might not be indexed (last flag). You can also check which address sent the event.
        emit setOwnerDataEvent(10);
        vm.warp(10);   //Increase block.timestamp by 10 seconds.
        simpleStorageInstance.setOwnerData();
        assertEq(simpleStorageInstance.ownerUnixTimeContract(),10);
    }

    function testSetOwnerDataRevertPath() public {
        vm.startPrank(address(0)); //Change the address to not be the owner. The owner is address(this) in this context.
        assertEq(simpleStorageInstance.ownerUnixTimeContract(),0);
        vm.expectRevert(notOwner.selector);    //Revert if not the owner. Custom error from SimpleStorage.
        simpleStorageInstance.setOwnerData();
    }
    
    function testDonateToOwnerValidPath() public {
        uint256 ownerBalanceStart = address(this).balance;
        assertEq(ownerBalanceStart,79228162514264337593543950335);
        vm.deal(address(0),ownerBalanceStart);
        uint256 prankBalanceStart = address(this).balance;
        assertEq(ownerBalanceStart,79228162514264337593543950335);
        assertEq(address(simpleStorageInstance).balance, 0); 
        vm.startPrank(address(0)); //Change the address to not be the owner. The owner is address(this) in this context.
        uint256 msgValueWei = 1;
        vm.expectEmit(false,false,false,false); // Events have bool flags for indexed topic parameters in order (3 topics possible) along with arguments that might not be indexed (last flag). You can also check which address sent the event.
        emit donateToOwnerEvent();
        assertEq(address(simpleStorageInstance).balance, 0);        
        simpleStorageInstance.donateToOwner{value: msgValueWei}();
        vm.stopPrank(); //Stop prank since we don't need to be another address anymore for increasing the owner balance from a transfer.
        assertEq(address(simpleStorageInstance).balance, 0); 
        assertEq(address(this).balance, ownerBalanceStart+1); 
        assertEq(address(0).balance, prankBalanceStart-1); 
    }

    function testDonateToOwnerRevertPath() public {
        vm.expectRevert(msgValueZero.selector);  //Revert if MSG.VALUE is 0. Custom error from SimpleStorage.
        simpleStorageInstance.donateToOwner();   //MSG.VALUE is not set for call, so it is 0. 
    }
}