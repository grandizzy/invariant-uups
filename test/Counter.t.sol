// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {UnsafeUpgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

import {Test} from "forge-std/Test.sol";
import "./TestHandler.sol";

contract CounterTest is Test {
    address proxy;

    function setUp() public {
        TestHandler handler = new TestHandler();
        proxy = UnsafeUpgrades.deployUUPSProxy(address(handler), abi.encodeCall(TestHandler.initialize, (600_000)));

        string[] memory artifacts = new string[](1);
        artifacts[0] = "test/TestHandler.sol:TestHandler";
        targetInterface(FuzzInterface({addr: proxy, artifacts: artifacts}));

        bytes4[] memory selectors = new bytes4[](1);
        selectors[0] = TestHandler.fuzzHandler.selector;
        targetSelector(FuzzSelector({addr: proxy, selectors: selectors}));

        targetContract(address(proxy));

        address alice = makeAddr("alice");
        address bob = makeAddr("bob");
        vm.deal(alice, 100 ether);
        vm.deal(bob, 100 ether);

        targetSender(alice);
        targetSender(bob);
    }

    function invariant_assume() public view {
        assertGt(TestHandler(proxy).amount(), 500_000, "amount lt than 500k");
    }
}
