//SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import "@openzeppelin/contracts/metatx/ERC2771Forwarder.sol";

// solc --optimize --combined-json abi,bin contracts/TrustedForwarder.sol > artifacts/TrustedForwarder.json

contract TrustedForwarder is ERC2771Forwarder {
    constructor(string memory _name) ERC2771Forwarder(_name) {}
}