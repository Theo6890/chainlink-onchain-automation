// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import {Automation} from "../../src/Automation.sol";

contract Automation_test is Test {
    Automation public instance;

    function setUp() public {
        instance = new Automation(1);
    }

    function test_truthy() public {
        assertTrue(true);
    }
}
