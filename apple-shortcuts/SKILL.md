---
name: apple-shortcuts
description: >-
  Discover, run, document, and troubleshoot Apple Shortcuts on macOS via the
  shortcuts CLI, osascript/JXA fallbacks, and this machine's Stream Deck /
  Spencer / AUTOGIO shortcut library. Use when the user mentions Shortcuts,
  Atalhos, shortcuts run/list, Stream Deck shortcut buttons, Spencer layouts,
  SD-prefixed ops shortcuts, Siri shortcuts, or wants macOS automation through
  Shortcuts.app rather than raw shell-only flows.
---

# Apple Shortcuts

## Objective

Help the user **list, run, inspect, design recipes for, and troubleshoot** Apple Shortcuts on this Mac. Prefer the native `shortcuts` CLI and existing project scripts. Do **not** pretend the CLI can create or edit shortcut graphs.

## Invocation

```text
/apple-shortcuts
```

Cursor may also auto-attach when the request matches the description.

## Scope

- Inventory shortcuts (`shortcuts list`)
- Run named shortcuts (`shortcuts run "Name"`)
- Open a shortcut in the app (`shortcuts view "Name"`)
- Sign `.shortcut` files for import (`shortcuts sign`)
- Map user intent → best existing shortcut **or** underlying zsh/AppleScript
- Write setup recipes the user can build in Shortcuts.app
- Relate Stream Deck / Spencer / AUTOGIO ops shortcuts to their scripts

## Non-Goals

- Do **not** claim `shortcuts create` exists (it does not)
- Do **not** UI-automate Shortcuts.app to build graphs unless the user explicitly asks for UI automation
- Do **not** run interactive, destructive, or secret-related shortcuts without explicit confirmation
- Do **not** print or log API keys / tokens from shortcuts like **API Key Saver**
- Do **not** replace `macos-health-check` remediation policy — health reports stay read-only unless the user asks for fixes separately
- Do **not** write default dumps into `~/Reports/MacHealthOS/`

## Authorized Output

Usually **no report file** — answer in chat with commands and results.

Optional session note only if the user asks to log the run:

```text
/Users/giovannini.eduardogmail.com/Reports/WorkSessions/shortcuts_<slug>_YYYY-MM-DD_HH-MM-SS.md
```

Follow [output-policy.md](../_shared/references/output-policy.md) for folder rules.

## Safety Constraints

1. **Confirm before run** when the shortcut may change Focus, quit apps, clean files, change network/Home settings, print, or touch secrets:
   - Examples: `CLEANUP`, `Clean`, `Quit_YouTube`, `Stop Distractions`, `Home and Away Settings`, `PRINT_FACTORY_PRINT_Fulo_Filo`, `API Key Saver`, `SD-Backup-Todays-Reports`
2. **Quote names** exactly as returned by `shortcuts list` (spaces, em dashes `—`, hyphens, accents).
3. Prefer **underlying scripts** when a Shortcut is only a thin `Run Shell Script` wrapper — more reliable for agents and logs.
4. Never pass secrets on the command line in chat logs; use files/`--input-path` when the shortcut needs input.
5. On permission dialogs (Automation, Accessibility, Notes): tell the user to approve in System Settings; do not loop-spam the shortcut.

Consult [Safety Policy](../_shared/references/safety-policy.md) when overlapping with other skills.

## Required Inputs

| Input | Required? | Notes |
|---|---|---|
| Intent or shortcut name | Yes | e.g. “start my day”, `SD-Start-Workspace` |
| Confirm destructive run | When applicable | Yes/No |
| Input file path | Optional | `--input-path` for shortcuts that accept input |
| Output path | Optional | `--output-path` / `--output-type` |

## Workflow

### 1. Discover

Refresh inventory (do not trust stale memory):

```zsh
/usr/bin/shortcuts list
```

Or the helper:

```zsh
"$HOME/.cursor/skills/apple-shortcuts/scripts/list-shortcuts.zsh"
```

If the user asks what a name does, open the app view (does not run it):

```zsh
/usr/bin/shortcuts view "Exact Name"
```

Load [references/library.md](references/library.md) for known mappings on this machine. Reconcile with live `shortcuts list` — names drift (e.g. `SD-Start-Workspace` vs docs saying `SD — Start Workspace`).

### 2. Choose path

| Situation | Prefer |
|---|---|
| Exact Shortcut exists and is the user’s habit | `shortcuts run "Exact Name"` |
| Shortcut wraps a known zsh script (Stream Deck ops / Spencer) | Run the **script** directly; mention the Shortcut equivalent |
| No Shortcut; need a new automation | Provide a **recipe** for Shortcuts.app + optional zsh body; do not invent CLI create |
| Needs reliable Notes append / dialogs | AppleScript/JXA (see [references/cli.md](references/cli.md)) |
| Read-only Mac health report | `/macos-health-check` skill, not a random cleanup Shortcut |

### 3. Run

```zsh
/usr/bin/shortcuts run "Exact Name"
```

With input/output when needed:

```zsh
/usr/bin/shortcuts run "Exact Name" \
  --input-path "/absolute/path/in.txt" \
  --output-path "/absolute/path/out.txt" \
  --output-type public.plain-text
```

Capture exit code. On failure: check name spelling via `list`, permissions, and whether the underlying app/CLI is installed (Spencer, Stream Deck scripts, etc.).

### 4. Report back

Short completion summary:

- Shortcut or script used (exact name/path)
- Exit status
- Side effects observed
- Next action (permissions, rename drift, recipe to create missing Shortcut)

## Decision Guide (this machine)

### Daily / workspace

| Intent | Try first (verify with `list`) | Fallback script / notes |
|---|---|---|
| Start day / Spencer home layout | `Start My Day` or `START_MY_DAY` | Spencer CLI restore `START_MY_DAY` |
| Thinking workspace | `THINKING_WORKSPACE` / `SPENCER - Thinking` | Spencer layout restore |
| Desktop Commander layout | `DESKTOP_COMMANDER` | Spencer layout |
| Cleanup layout | `CLEANUP` (**confirm**) | Spencer layout |
| Open Cursor Atlas | `Open_Cursor_A.tlas` | — |
| Stream Deck start workspace | `SD-Start-Workspace` | Live Shortcut first; zsh only if `Automation/stream-deck-operations/` exists |
| Open finance project | `SD-Open-Finance-Project` | Live Shortcut first |
| Backup today’s reports | `SD-Backup-Todays-Reports` (**confirm**) | Live Shortcut first; confirm before archives |
| Local Spencer desk restore | — | `/Users/giovannini.eduardogmail.com/Automation/spencer/restore_*.sh` |

### Ops / network

| Intent | Shortcut | Notes |
|---|---|---|
| UniFi daily health | `PIOS UniFi Daily Health.signed 1` | Prefer documented `shortcuts run` name from list |
| WiFiman | `WiFiman` | |

### Focus / productivity

| Intent | Shortcut | Confirm? |
|---|---|---|
| Pomodoro | `Start Pomodoro` | No |
| Stop distractions | `Stop Distractions` | Yes |
| Quit YouTube | `Quit_YouTube` | Yes |
| Tile windows | `Tile Last 2 Windows` / `Tile Last 4 Windows` / `Split Screen 2 Apps` | No |

See full catalog notes in [references/library.md](references/library.md).

## Creating or fixing Shortcuts (manual)

The agent **cannot** compile a new shortcut graph via CLI. When the user needs a new one:

1. Write a clear recipe: name, actions, shell body with **absolute paths**
2. Point to generators only when those projects exist on this Mac:
   - `$HOME/Automation/stream-deck-operations/scripts/install-shortcuts.zsh` (currently missing)
   - `$HOME/Documents/GitHub/ipad-stream-deck-console` Spencer install/paste scripts (currently missing)
   - Local desk restores: `$HOME/Automation/spencer/restore_*.sh`
3. After the user clicks **Add Shortcut**, verify:

```zsh
/usr/bin/shortcuts list | grep -F 'expected-name'
/usr/bin/shortcuts run "expected-name"
```

4. Prefer `SD-` or `SD —` prefix for Stream Deck ops; never overwrite unrelated library shortcuts.

Signing an exported file:

```zsh
/usr/bin/shortcuts sign --mode people-who-know-me \
  --input "/path/in.shortcut" \
  --output "/path/out.shortcut"
```

## Troubleshooting

| Symptom | Check |
|---|---|
| `Could not run` / not found | `shortcuts list`; quoting; em dash vs hyphen |
| Hangs / waits | Shortcut may show a dialog — user must click; or run underlying zsh with `SD_SKIP_DIALOGS=1` when supported |
| Permission errors | System Settings → Privacy & Security → Automation / Accessibility / Documents |
| Spencer layouts fail | Spencer.app installed; CLI ready loop in [library.md](references/library.md) |
| Stream Deck button no-op | Prefer live `shortcuts run`; if ops repo is restored, use its `launchers/` `.command` files |

## Examples

**User:** “Run my start workspace shortcut”

1. `shortcuts list` → confirm `SD-Start-Workspace` (or documented alias)
2. Confirm it is non-destructive
3. `shortcuts run "SD-Start-Workspace"` **or** run `start-workspace.zsh`
4. Report exit status

**User:** “Add a Shortcut that opens Reports”

1. Provide Shortcuts.app recipe (Open Folder → `/Users/giovannini.eduardogmail.com/Reports`)
2. Suggest name `Open-Reports-Root`
3. After user creates it, verify with `list` + `run`

**User:** “What Shortcuts do I have for Spencer?”

1. Run list helper
2. Filter CLEANUP / DESKTOP_COMMANDER / NOTEBOOKLM / START_MY_DAY / THINKING_WORKSPACE / PRINT_FACTORY…
3. Summarize table; do not run them unless asked

## References

- [CLI reference](references/cli.md)
- [Library map (this Mac)](references/library.md)
- Spencer local restores: `/Users/giovannini.eduardogmail.com/Automation/spencer/`
- Stream Deck ops (if restored): `/Users/giovannini.eduardogmail.com/Automation/stream-deck-operations/`
- iPad Stream Deck console (if restored): `/Users/giovannini.eduardogmail.com/Documents/GitHub/ipad-stream-deck-console/`
