// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import "forge-std/console2.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {UpgradeableCustomERC20} from "../src/UpgradeableCustomERC20.sol";

contract UpgradeableCustomERC20Script is Script {
    function setUp() public {}

    function run() public {
        // Read env for forwarder
        // string memory name = "Trusted Forwarder";
        address deployedForwarder = vm.envAddress("DEPLOYED_FORWARDER");
        address owner = vm.envAddress("PROXY_OWNER");

        vm.startBroadcast();

        // Should deploy proxy smart contract
        UpgradeableCustomERC20 impl = new UpgradeableCustomERC20();

        ProxyAdmin proxyAdmin = new ProxyAdmin(owner);
        bytes memory initData = abi.encodeCall(
            UpgradeableCustomERC20.initialize,
            (deployedForwarder)
        );

        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(impl),
            address(proxyAdmin),
            initData
        );

        UpgradeableCustomERC20 token = UpgradeableCustomERC20(address(proxy));

        vm.stopBroadcast();

        console2.log("Implementation:", address(impl));
        console2.log("ProxyAdmin:", address(proxyAdmin));
        console2.log("Proxy:", address(proxy));
        console2.log("Token via proxy:", address(token));
    }
}
