---
name: repository-audit
description: Perform a comprehensive, evidence-based, read-only audit of a software repository. Use when assessing architecture, security, correctness, reliability, dependencies, tests, documentation, macOS integration, shell scripts, or repository hygiene.
---

# Repository Audit

## Objective

Produce an evidence-based, read-only audit of the currently selected repository and write a timestamped report under `~/Reports/RepositoryAudits/`.

## Invocation

Cursor may auto-invoke this skill when the request matches the description. Slash command also works:

```text
/repository-audit
```

## Scope

Architecture, security, correctness, reliability, dependencies, tests, documentation, macOS/Apple integration (when present), shell scripts (when present), and repository hygiene.

## Non-Goals

- No remediation or code changes
- No package installs, dependency updates, deployments, or migrations
- No speculative rewrites or unrelated documentation

## Authorized Output

Create **only** a new timestamped report per [output-policy.md](../_shared/references/output-policy.md):

```text
/Users/eduardofgiovannini/Reports/RepositoryAudits/repository_audit_<repo-slug>_YYYY-MM-DD_HH-MM-SS.md
```

Do not write to the repository root, `$HOME`, or cwd by default. User may override with an absolute path.

## Required Inputs

- Current working directory / selected repository
- Optional: absolute output path override
- Optional: user focus areas (security-only, macOS-only, etc.)

## Operating Rules

Consult shared framework (do not duplicate):

- [Safety Policy](../_shared/references/safety-policy.md)
- [Output Policy](../_shared/references/output-policy.md)
- [Evidence Standard](../_shared/references/evidence-standard.md)
- [Finding Format](../_shared/references/finding-format.md)
- [Severity Model](../_shared/references/severity-model.md)
- [Execution Policy](../_shared/references/execution-policy.md)
- [Report Guidelines](../_shared/references/report-guidelines.md)

Domain references:

- [Repository Checks](references/repository-checks.md)
- [macOS Repository Checks](references/macos-repository-checks.md)
- [Shell Script Checks](references/shell-script-checks.md)

Report template: [repository-audit-report.md](templates/repository-audit-report.md)

Finding IDs use prefix `REPO-`.

## Workflow

1. Resolve output path (default under `~/Reports/RepositoryAudits/`; create folder if needed)
2. Discover repository state and map structure
3. Infer purpose from implementation (docs are claims)
4. Identify build, test, and run procedures
5. Inspect critical paths, security-sensitive code, dependencies, and tests
6. Compare documentation with implementation
7. Assess architecture, operational stability, hygiene
8. When present: macOS components and shell scripts
9. Consolidate findings; write the timestamped report (absolute path in header)
10. Confirm no application files were changed
## Repository Discovery

Safe example commands (filter/exclude large generated dirs):

```text
pwd
git status --short
git branch --show-current
git remote -v
git log -10 --oneline --decorate
git submodule status
du -sh .
find . -maxdepth 3 -type f
find . -maxdepth 3 -type d
git diff --check
```

Exclude from broad scans: `.git`, `node_modules`, `Pods`, `DerivedData`, `.build`, `build`, `dist`, `vendor`, `.venv`, `venv`, `__pycache__`, `.cache`.

Tests or builds may run only when clearly non-destructive and dependencies already exist.

## Build and Runtime Analysis

Identify how the project builds, tests, and runs. Record entry points, scripts, CI config, and whether documented commands match reality.

## Correctness Review

Inspect critical execution paths, error handling, state management, and mismatches between intended and actual behavior.

## Security Review

Authn/authz, secrets handling, input validation, unsafe shell/network patterns, and exposure surfaces. Redact secrets as `[REDACTED]`.

## Dependency Review

Manifests, lock files, outdated or unused deps, multiple package managers, and supply-chain risk indicators. Do not update dependencies.

## Testing Review

Coverage of critical paths, missing tests, flaky or non-runnable suites, and CI gaps.

## Documentation Review

README and docs vs implementation. Flag ambition–capacity mismatch and stale instructions.

## Operational Stability Review

Logging, monitoring, retries/timeouts, backups, migrations, and failure modes.

## Architecture Review

Duplicate abstractions, multiple sources of truth, unnecessary complexity, and architecture drift.

## macOS Review

When Apple/macOS artifacts exist, follow [macos-repository-checks.md](references/macos-repository-checks.md).

## Shell Script Review

When shell scripts exist, follow [shell-script-checks.md](references/shell-script-checks.md). Risky commands need contextual analysis — do not auto-classify as vulnerabilities.

## Repository Hygiene

Git status, ignored vs tracked generated files, submodule health, and repo clutter.

## Required Report Structure

Use [templates/repository-audit-report.md](templates/repository-audit-report.md). Include the absolute report path in the header.

## Stop Conditions

Stop and report clearly if:

- Repository is inaccessible or not a meaningful project root
- Required inspection would need unauthorized modification or `sudo`
- Command safety is uncertain
- Secrets would be exposed by continuing a check

Document what was completed, blocked, remaining, and the smallest next action.

## Completion Response

Use [completion-summary.md](../_shared/templates/completion-summary.md):

- Status, report path
- Findings counts by severity
- Commands skipped or failed
- Highest-priority next action
- Confirmation that application files were not modified
