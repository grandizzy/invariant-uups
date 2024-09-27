# Invariant sample with UUPS

forge build && forge test

```bash
Ran 1 test for test/Counter.t.sol:CounterTest
[FAIL: `vm.assume` rejected too many inputs (65536 allowed)] invariant_assume() (runs: 0, calls: 0, reverts: 0)
Suite result: FAILED. 0 passed; 1 failed; 0 skipped; finished in 18.04s (18.04s CPU time)

Ran 1 test suite in 18.04s (18.04s CPU time): 0 tests passed, 1 failed, 0 skipped (1 total tests)
```

Uncomenting following lines in fuzzed selector

```Solidity
        vm.assume(_amount > 400_000 && _amount < 600_000);
        amount = _amount;
```

results in traces below:

```bash
[FAIL: revert: amount lt than 500k]
        [Sequence]
                sender=0xc79aa6Ef044FEC80914657d50B708B440FEE4c9e addr=0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=0xee863b5600000000000000000000000000000000000000000000000000000000000635bb args=[]
 invariant_assume() (runs: 0, calls: 0, reverts: 0)
Traces:
  [1663144] CounterTest::setUp()
    ├─ [1170686] → new TestHandler@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   └─ ← [Return] 5626 bytes of code
    ├─ [105559] → new ERC1967Proxy@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit Upgraded(implementation: TestHandler: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [46390] TestHandler::initialize(600000 [6e5]) [delegatecall]
    │   │   ├─ emit Initialized(version: 1)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 170 bytes of code
    └─ ← [Stop] 

  [13120] ERC1967Proxy::fuzzHandler(406971 [4.069e5])
    ├─ [8230] TestHandler::fuzzHandler(406971 [4.069e5]) [delegatecall]
    │   ├─ [0] VM::assume(true) [staticcall]
    │   │   └─ ← [Return] 
    │   └─ ← [Stop] 
    └─ ← [Return] 

  [12563] CounterTest::invariant_assume()
    ├─ [7208] ERC1967Proxy::amount() [staticcall]
    │   ├─ [2318] TestHandler::amount() [delegatecall]
    │   │   └─ ← [Return] 406971 [4.069e5]
    │   └─ ← [Return] 406971 [4.069e5]
    └─ ← [Revert] revert: amount lt than 500k
```
