// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.25;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@cleanverse/contracts/interface/IATokenPolicy.sol";

contract CleanERC20 is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    IATokenPolicy public immutable policy;

    constructor(
        address initialOwner,
        address _policy
    ) ERC20("CustomToken", "oUSD") Ownable(initialOwner) {
        require(_policy != address(0), "policy=0x");
        policy = IATokenPolicy(_policy);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, ERC20Pausable) {
        if (!policy.canTransfer(address(this), from, to, value)) {
            revert IATokenPolicy.TransferNotAllowed();
        }
        super._update(from, to, value);
    }

    function setRule(IATokenPolicy.Rule calldata rule) external onlyOwner {
        policy.setRuleFromToken(rule);
    }
}
