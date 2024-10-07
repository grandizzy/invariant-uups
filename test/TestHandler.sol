// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import {Test, console} from "forge-std/Test.sol";

contract TestHandler is Test, Initializable, UUPSUpgradeable {
    address public ref = address(1412323);

    uint256 public amount;
    address public test;

    function initialize(uint256 _amount) public initializer {
        amount = _amount;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}

    function fuzzHandler(address addr, uint256 amount_) external {
        amount_ = _bound(amount_, 500001, type(uint256).max);
        vm.startPrank(msg.sender);
        this.otherExternalFunction(amount_, _boundAddress(addr));
        vm.stopPrank();
        console.log("finished execution");
    }

    function _boundAddress(address addr) internal view returns (address) {
        assumeNotPrecompile(addr);
        assumeNotForgeAddress(addr);
        if (uint160(addr) % 2 == 0) {
            return ref;
        }
        return addr;
    }

    function otherExternalFunction(uint256 amount_, address addr) external {
        amount = amount_;
        test = addr;
    }
}
