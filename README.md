# Cursor Skills (personal)

Personal Cursor Agent skills for **AUTOGIO** machines. Cursor loads these from:

```text
~/.cursor/skills/
```

Available in **all workspaces** on this Mac.

## Skills

| Skill | Invoke | Notes |
|---|---|---|
| `repository-audit` | `/repository-audit` | Read-only repo audit → `~/Reports/RepositoryAudits/` |
| `macos-health-check` | `/macos-health-check` | Read-only Mac health → `~/Reports/SystemHealth/` |
| `apple-shortcuts` | `/apple-shortcuts` | List/run/troubleshoot Apple Shortcuts + library map |

Shared policies/templates live in `_shared/` (not invokable).

## Reports

Default report root: `/Users/giovannini.eduardogmail.com/Reports` (see `_shared/references/output-policy.md`).

Folder map: `SystemHealth/`, `RepositoryAudits/`, `WorkSessions/` (plus legacy `MacHealthOS/` — Cursor skills must not write there).

## Sync

This repository is the source of truth. After edits, sync into the live Cursor load path:

```text
~/.cursor/skills/
```

Keep this repository **private**.
