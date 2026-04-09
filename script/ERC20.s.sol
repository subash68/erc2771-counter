// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {CustomToken} from "../src/ERC20.sol";

contract CustomTokenScript is Script {
    CustomToken public token;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address owner = vm.envAddress("PROXY_OWNER");
        token = new CustomToken(owner);
        vm.stopBroadcast();
    }
}
