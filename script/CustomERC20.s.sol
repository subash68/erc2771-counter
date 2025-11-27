// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {CustomERC20} from "../src/CustomERC20.sol";

contract CustomERC20Script is Script {
    CustomERC20 public token;

    function setUp() public {}

    function run() public {

        vm.startBroadcast();
        address trustedForwarder = address(0x40101A97126FF862d0BcfA708619055aaAe2fAE8);
        token = new CustomERC20(trustedForwarder);
        vm.stopBroadcast();
    }
}
