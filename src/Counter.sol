// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";

contract Counter is ERC2771Context {

    constructor(address _trustedForwarder) ERC2771Context(_trustedForwarder) { }

    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
