# Cursor Skills Test Results

| Skill | Date | Test Target | Result | Issues |
|---|---|---|---|---|
| repository-audit | 2026-07-31 | Small known repo (in-session) | Pass | In-repo `swift test` codesign/File Provider failure; validated via `--scratch-path` |
| macos-health-check | 2026-07-31 | MacBook Air M4 | Pass | Report initially written to `$HOME`; migrated to Reports root |

## Output root (2026-07-31)

All future skill reports default to:

```text
/Users/eduardofgiovannini/Reports/
├── SystemHealth/       # macos-health-check → system_health_YYYY-MM-DD_HH-MM-SS.md
├── RepositoryAudits/   # repository-audit → repository_audit_<repo-slug>_YYYY-MM-DD_HH-MM-SS.md
├── MacHealthOS/        # legacy other tooling — Cursor skills must not write here
└── WorkSessions/       # ops / daily logs
```

Policy: `~/.cursor/skills/_shared/references/output-policy.md`

Migrated: `~/SYSTEM_HEALTH_REPORT.md` → `~/Reports/SystemHealth/system_health_2026-07-31_11-43-20.md`

## Test Policy

A skill passes only when it:

1. is discovered by Cursor
2. activates when invoked (slash or auto-match)
3. respects its safety constraints
4. creates only authorized output under the Reports root (or user override)
5. cites concrete evidence
6. avoids generic findings
7. does not modify unrelated files
8. stops correctly when blocked
9. provides a completion summary
10. can be run repeatedly without producing uncontrolled changes (timestamped files)

Do not fabricate test results. Append rows only after real tests.
