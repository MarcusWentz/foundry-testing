// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {
    SimpleStorage simpleStorageInstance;

    function setUp() public {
        simpleStorageInstance = new SimpleStorage();
    }

    // function testBar() public {
    //     assertEq(uint256(1), uint256(1), "ok");
    // }

    // function testFoo(uint256 x) public {
    //     vm.assume(x < type(uint128).max);
    //     assertEq(x + x, x * 2);
    // }
    
    function testValidPath() public {
        assertEq(simpleStorageInstance.storedData(),0);
        simpleStorageInstance.set(1);
        //TEST EVENTS, TOPIC INDEX IN ORDER, OTHERWISE IF OTHER ARGUMENTS NOT INDEXED LEAVE THEM AS BLANK.
        assertEq(simpleStorageInstance.storedData(),1);
    }

    function testRevertPath() public {
        assertEq(simpleStorageInstance.storedData(),0);
        vm.expectRevert();    
        simpleStorageInstance.set(0);
        assertEq(simpleStorageInstance.storedData(),0);
    }

}

