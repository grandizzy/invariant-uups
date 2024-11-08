// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {UnsafeUpgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ERC1967Utils} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";

import "forge-std/Test.sol";

contract CheapDeposit is Initializable, UUPSUpgradeable {
    uint256 public amount;

    function initialize(uint256 _amount) public initializer {
        amount = _amount;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}

    function deposit(uint256 amount) external {
        amount = amount * 2;
    }
}

contract ExpensiveDeposit is Initializable, UUPSUpgradeable {
    uint256 public amount;

    function initialize(uint256 _amount) public initializer {
        amount = _amount;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}

    function deposit(uint256 amount) external {
        amount = amount * 10;
    }
}

contract GasReportTest is Test {
    function test_gas_report() public {
        CheapDeposit cheap = CheapDeposit(
            UnsafeUpgrades.deployUUPSProxy(
                address(new CheapDeposit()),
                abi.encodeCall(CheapDeposit.initialize, (600_000))
            )
        );
        ExpensiveDeposit expensive = ExpensiveDeposit(
            UnsafeUpgrades.deployUUPSProxy(
                address(new ExpensiveDeposit()),
                abi.encodeCall(ExpensiveDeposit.initialize, (600_000))
            )
        );
        cheap.deposit(1);
        expensive.deposit(1);
    }
}
