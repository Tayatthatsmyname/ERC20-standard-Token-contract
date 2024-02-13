// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {TToken} from "../src/TToken.sol";
import {DeployTToken} from "../script/DeployTToken.s.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract TTokenTes is Test {
    TToken public tToken;
    DeployTToken public deployer;

    address bob;
    address alice;

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployTToken();
        tToken = deployer.run();

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        vm.prank(msg.sender);
        tToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, tToken.balanceOf(bob));
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;
        uint256 transferAmount = 500;

        vm.prank(bob);
        tToken.approve(alice, initialAllowance);

        vm.prank(alice);
        tToken.transferFrom(bob, alice, transferAmount);

        assertEq(tToken.balanceOf(alice), transferAmount);
        assertEq(tToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
}
