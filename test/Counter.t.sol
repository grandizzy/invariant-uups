// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

import "forge-std/Test.sol";

contract TestHandler is Test, UUPSUpgradeable {
    function _authorizeUpgrade(address newImplementation) internal override {}

    function fuzzHandler(address precompile) public {
        vm.assume(precompile == address(0));
    }
}

contract CounterTest is Test {
    TestHandler public handler;

    function setUp() public {
        address proxy = Upgrades.deployUUPSProxy(
            "TestHandler.sol",
            abi.encodeCall(TestHandler.initialize, (address(0)))
        );
        handler = TestHandler(proxy);
    }

    function invariant_assume() public {}
}
