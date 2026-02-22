// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";

contract UpgradeableCustomERC20 is
    Initializable,
    OwnableUpgradeable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    ERC20PausableUpgradeable,
    AccessControlUpgradeable,
    ERC20PermitUpgradeable
{
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    address private _trustedForwarder;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    // address pauser,
    // address minter,
    // address burner

    function initialize(address forwarder, address owner_) public initializer {
        require(forwarder != address(0), "forwarder=0");
        require(owner_ != address(0), "owner=0");
        __ERC20_init("USDC", "USDC");
        __ERC20Burnable_init();
        __ERC20Pausable_init();
        __AccessControl_init();

        _trustedForwarder = forwarder;

        __Ownable_init(owner_);
        __ERC20Permit_init("USDC");

        _grantRole(DEFAULT_ADMIN_ROLE, owner_);
        _grantRole(PAUSER_ROLE, owner_);
        _grantRole(MINTER_ROLE, owner_);
        _grantRole(BURNER_ROLE, owner_);

        // Transfer ownership of smart contract to designated
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(uint256 value) public override onlyRole(BURNER_ROLE) {
        // from sender only
        _burn(_msgSender(), value);
    }

    // custom helper function to perform ownership transfer after all initialization
    function transferOwnership(address newOwner) public override onlyOwner {
        super.transferOwnership(newOwner);
    }

    function trustedForwarder() public view returns (address) {
        return _trustedForwarder;
    }

    // The following functions are overrides required by Solidity.
    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20Upgradeable, ERC20PausableUpgradeable) {
        super._update(from, to, value);
    }

    function setTrustedForwarder(
        address newForwarder
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(newForwarder != address(0), "forwarder=0");
        _trustedForwarder = newForwarder;
    }

    function isTrustedForwarder(address forwarder) public view returns (bool) {
        return forwarder == _trustedForwarder;
    }

    function _msgSender()
        internal
        view
        virtual
        override(ContextUpgradeable)
        returns (address sender)
    {
        if (isTrustedForwarder(msg.sender)) {
            assembly {
                sender := shr(96, calldataload(sub(calldatasize(), 20)))
            }
        } else {
            sender = super._msgSender();
        }
    }

    function _msgData()
        internal
        view
        virtual
        override(ContextUpgradeable)
        returns (bytes calldata)
    {
        if (isTrustedForwarder(msg.sender) && msg.data.length >= 20) {
            return msg.data[:msg.data.length - 20];
        }

        return super._msgData();
    }

    uint256[50] private __gap;
}
