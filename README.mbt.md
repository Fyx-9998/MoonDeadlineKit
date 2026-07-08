# MoonDeadlineKit

MoonDeadlineKit provides deterministic deadline and timeout-budget primitives
for MoonBit services, CLI tasks, queues, crawlers, and RPC-style workflows.

The core package does not call system clocks. Users pass integer timestamps and
durations, so the same API remains portable across Wasm, JavaScript, and native
MoonBit targets.

Initial features:

- deadline creation from start time and timeout budget
- remaining-time calculation
- expiration checks
- child budget allocation
- budget splitting across sub tasks
- deadline report and JSON export
- CLI demo and regression tests
