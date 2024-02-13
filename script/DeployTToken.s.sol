// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {TToken} from "../src/TToken.sol";

contract DeployTToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns(TToken) {
        vm.startBroadcast();
        TToken tToken = new TToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return tToken;
    }
}
