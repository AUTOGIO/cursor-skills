# Shared Output Policy

All Cursor audit and diagnostic skills write reports under a single root unless the user overrides with an absolute path.

## Reports Root

```text
/Users/giovannini.eduardogmail.com/Reports
```

## Folder Map

| Skill | Folder | Filename pattern |
|---|---|---|
| `macos-health-check` | `SystemHealth/` | `system_health_YYYY-MM-DD_HH-MM-SS.md` |
| `repository-audit` | `RepositoryAudits/` | `repository_audit_<repo-slug>_YYYY-MM-DD_HH-MM-SS.md` |
| `apple-shortcuts` (optional session note) | `WorkSessions/` | `shortcuts_<slug>_YYYY-MM-DD_HH-MM-SS.md` only if user asks to log |
| Session / ops notes (optional) | `WorkSessions/` | leave existing naming; do not invent unrelated dumps |
| Legacy other tooling | `MacHealthOS/` | **do not write Cursor skill reports here** |

## Rules

1. **Default:** write only under the mapped folder for that skill.
2. **Timestamp:** use local time `YYYY-MM-DD_HH-MM-SS`. Always create a **new** timestamped file — never overwrite a previous report silently.
3. **Create folders** if missing (`mkdir -p` on the target folder only).
4. **Override:** if the user provides an absolute path, use it; still prefer a timestamped filename unless they name a specific file.
5. **Do not** write default reports to repository root, `$HOME`, or the workspace cwd.
6. **Do not** write into `MacHealthOS/` from Cursor skills (reserved for other tooling).
7. Put the **absolute report path** in the report header and in the completion summary.
8. Collector scripts remain stdout-only unless the user asks to persist raw collection separately under the same Reports folder.

## Repo slug

For `repository-audit`, `<repo-slug>` is the sanitized basename of the audited repository directory (alphanumeric, hyphen, underscore). Example: `/Users/…/ItaliaOS` → `ItaliaOS`.

## Examples

```text
/Users/giovannini.eduardogmail.com/Reports/SystemHealth/system_health_2026-07-31_11-43-00.md
/Users/giovannini.eduardogmail.com/Reports/RepositoryAudits/repository_audit_ItaliaOS_2026-07-31_11-20-00.md
```
