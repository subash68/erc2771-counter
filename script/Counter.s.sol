// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {}

    function run() public {

        // uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast();
        address trustedForwarder = address(0x40101A97126FF862d0BcfA708619055aaAe2fAE8);
        counter = new Counter(trustedForwarder);
        vm.stopBroadcast();
    }
}
