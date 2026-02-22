// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "./UpgradeableCustomERC20.sol";

contract UpgradeableCustomERC20ProxyFactory {
    address public immutable implementation;

    event ProxyDeployed(
        address indexed proxy,
        address indexed deployer,
        address indexed forwarder
    );

    constructor(address _implementation) {
        require(_implementation != address(0), "impl=0");
        implementation = _implementation;
    }

    function deploy(address forwarder) external returns (address proxyAddr) {
        require(forwarder != address(0), "forwarder=0");

        bytes memory initData = abi.encodeCall(
            UpgradeableCustomERC20.initialize,
            (forwarder, msg.sender)
        );

        ERC1967Proxy proxy = new ERC1967Proxy(implementation, initData);
        proxyAddr = address(proxy);

        emit ProxyDeployed(proxyAddr, msg.sender, forwarder);
    }

    //@notice: Include any convenience. @Subash
}
