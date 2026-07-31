# Shared Execution Policy

## Workflow

1. **Inspect** — discover scope and existing state
2. **Map** — identify structure, entry points, and critical paths
3. **Understand** — infer intended purpose from evidence
4. **Validate safely** — run only authorized, scoped commands
5. **Analyze** — form findings with evidence and confidence
6. **Consolidate** — merge duplicate root causes
7. **Produce output** — write only authorized report files
8. **Verify final state** — confirm no unauthorized file changes

## Command Rules

- Inspect commands before execution
- Prefer deterministic collection before model inference
- Keep command scope minimal
- Do not run broad filesystem scans outside declared scope
- Exclude large generated directories when scanning repositories (`.git`, `node_modules`, `Pods`, `DerivedData`, `.build`, `build`, `dist`, `vendor`, `.venv`, `venv`, `__pycache__`, `.cache`)
- Record commands and exit statuses
- Report skipped commands with reasons
- Do not repeat a failing command without changing the diagnostic approach

## Final Verification

Before completion, verify:

- Only authorized output files were created or modified
- No application/source files changed (unless implementation mode was authorized)
- Secrets were redacted
- Stop conditions were respected
