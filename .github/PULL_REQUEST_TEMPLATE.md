## Scope

- [ ] New immutable submission
- [ ] Versioned suite/schema/tool change
- [ ] Documentation or reference correction

Describe what changed and what stayed unchanged.

## Reproducibility

- [ ] New results are under `submissions/<submitter>/<run-id>/submission.json`.
- [ ] Hardware, model asset, quantization, runtime, context and output budget are recorded.
- [ ] PASS/FAIL uses an external parser/compiler/test/tool gate.
- [ ] Shared reference arrays and other submissions were not overwritten.

## Public safety and rights

- [ ] No weights, binaries, credentials, private paths/account identifiers or unreviewed raw logs.
- [ ] I have the right to publish this material.
- [ ] I accept CC BY 4.0 for data/docs and MIT for code/tools.

## Validation

Paste the final output from `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1`.
