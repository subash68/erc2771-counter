//SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";

contract CustomERC20 is ERC20, ERC2771Context {
    constructor(address _trustedForwarder) 
        ERC20("USDC", "USDC") 
        ERC2771Context(_trustedForwarder) {
            // Mint to sender 
            // transfer to some accounts 
            _mint(_msgSender(), 1000000000000000000 * 10 ** decimals());
        }

     function _contextSuffixLength()
        internal
        view
        virtual
        override(Context, ERC2771Context)
        returns (uint256)
    {
        return ERC2771Context._contextSuffixLength();
    }

    function _msgSender()
        internal
        view
        virtual
        override(Context, ERC2771Context)
        returns (address sender)
    {
        return ERC2771Context._msgSender();
    }

    function _msgData()
        internal
        view
        virtual
        override(Context, ERC2771Context)
        returns (bytes calldata)
    {
        return ERC2771Context._msgData();
    }

}