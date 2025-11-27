// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {TrustedForwarder} from "../src/TrustedForwarder.sol";

contract TrustedForwarderScript is Script {
    TrustedForwarder public forwarder;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        string memory name = "Trusted Forwarder";
        forwarder = new TrustedForwarder(name);

        vm.stopBroadcast();
    }
}
