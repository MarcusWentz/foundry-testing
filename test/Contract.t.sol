// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {
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
        vm.expectRevert();    
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
        // vm.stopPrank(); //Stop prank as contract address. We are already the owner address.
        assertEq(simpleStorageInstance.ownerUnixTimeContract(),10);
    }

    function testSetOwnerDataRevertPath() public {
        vm.startPrank(address(0)); //Change the address to not be the owner. The owner is address(this) in this context.
        assertEq(simpleStorageInstance.ownerUnixTimeContract(),0);
        vm.expectRevert();    
        simpleStorageInstance.setOwnerData();
        // vm.stopPrank(); //Stop prank as contract address. We revert before hitting this line so we don't need to stop the prank.
    }

    //Define events here for from other contracts since Foundry has trouble importing events from other contracts still.
    event setOpenDataEvent(address indexed user, uint newValue);
    event setOwnerDataEvent(uint newOwnerUnixTime);
    
}

