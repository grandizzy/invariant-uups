// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "forge-std/Test.sol";

contract TestHandler is Test, Initializable, UUPSUpgradeable {
    uint256 public amount;

    function initialize(uint256 _amount) public initializer {
        amount = _amount;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}

    function fuzzHandler(uint256 _amount) public {
        // Make sure we only fuzz through proxy.
        require(address(this) == 0x2e234DAe75C793f67A35089C9d99245E1C58470b, "bad address");
        vm.assume(false);
        // vm.assume(_amount > 400_000 && _amount < 600_000);
        // amount = _amount;
    }
}
