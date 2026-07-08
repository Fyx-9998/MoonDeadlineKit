# Acceptance Notes

Current acceptance surface:

- deadline creation from timeout or absolute timestamp
- remaining budget and expiration checks
- child budget allocation
- split plans for multiple sub tasks
- task-start guard decisions
- deadline reports
- JSON exports
- CLI demo
- regression tests
- GitHub Actions CI

Useful commands:

```powershell
moon check --target all
moon test --target wasm
moon test --target wasm-gc
moon test --target js
moon run cmd/main
```
