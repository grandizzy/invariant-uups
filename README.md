# Invariant sample with UUPS

forge build && forge test

```
Ran 1 test for test/Counter.t.sol:CounterTest
[FAIL: `vm.assume` rejected too many inputs (65536 allowed)] invariant_assume() (runs: 0, calls: 0, reverts: 0)
Suite result: FAILED. 0 passed; 1 failed; 0 skipped; finished in 18.04s (18.04s CPU time)

Ran 1 test suite in 18.04s (18.04s CPU time): 0 tests passed, 1 failed, 0 skipped (1 total tests)
```
