# Related Work

MoonDeadlineKit focuses on deterministic timeout budget and deadline
propagation for MoonBit.

## Difference from retry and resilience packages

Retry libraries decide what to do after a failure. MoonDeadlineKit decides how
much time remains before work starts or before a child task receives a budget.
It can be used together with a retry library, but it owns a different concern.

## Difference from scheduling libraries

Schedulers decide when tasks run. MoonDeadlineKit does not own queues, workers,
or timers. It only models budget math and propagation boundaries.

## Difference from SLO or monitoring projects

SLO packages evaluate service quality after metrics are collected. This project
provides per-request time-budget decisions during execution.
