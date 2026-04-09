// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {CleanERC20} from "../src/CleanERC20.sol";

contract CleanERC20Script is Script {
    CleanERC20 public cleanERC20;

    function setUp() public {}

    function run() public {
        address owner = vm.envAddress("TOKEN_OWNER");
        address iATokenPolicy = vm.envAddress("CLEANVERSE_ATOKEN_POLICY");

        vm.startBroadcast();

        cleanERC20 = new CleanERC20(owner, iATokenPolicy);
        vm.stopBroadcast();
    }
}
