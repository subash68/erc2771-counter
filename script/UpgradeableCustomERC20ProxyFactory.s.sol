// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/UpgradeableCustomERC20.sol";
import "../src/UpgradeableCustomERC20ProxyFactory.sol";

contract UpgradeableCustomERC20ProxyFactoryScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        UpgradeableCustomERC20 implementation = new UpgradeableCustomERC20();
        console2.log("implementation deployed:", address(implementation));

        UpgradeableCustomERC20ProxyFactory factory = new UpgradeableCustomERC20ProxyFactory(
                address(implementation)
            );

        console2.log("factory deploy:", address(factory));

        // TODO: Verify existing factory contract - Amoy
        // Call deploy function with deployedForwarder var!!

        vm.stopBroadcast();
    }
}
