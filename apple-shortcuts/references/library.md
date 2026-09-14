# Shortcut library map (this Mac)

> Snapshot aid only. **Always** re-run `shortcuts list` before executing.  
> Last curated: 2026-09-05 (paths updated for this Mac account)

## Naming drift

Documented / generated names sometimes use an em dash (`SD — Start Workspace`) while the live library uses hyphens (`SD-Start-Workspace`). **Trust live `list`.**

Related project roots (this Mac):

| Project | Path | Status |
|---|---|---|
| Reports root | `/Users/giovannini.eduardogmail.com/Reports/` | Present |
| Spencer desk restores (local) | `/Users/giovannini.eduardogmail.com/Automation/spencer/` | Present (`restore_*.sh`) |
| Stream Deck operations | `/Users/giovannini.eduardogmail.com/Automation/stream-deck-operations/` | **Missing** on this account — do not invent scripts; use live Shortcuts or ask before recreating |
| iPad Stream Deck console | `/Users/giovannini.eduardogmail.com/Documents/GitHub/ipad-stream-deck-console/` | **Missing** on this account — legacy docs may still mention it |

When a referenced project folder is missing, prefer `shortcuts list` / `shortcuts run` and the local Spencer restores above. Do not assume `/Users/eduardofgiovannini/...` paths exist.

## Live inventory (2026-07-31)

Grouped from `shortcuts list` (39 names).

### Stream Deck / AUTOGIO ops

| Live name | Likely script | Risk |
|---|---|---|
| `SD-Backup-Todays-Reports` | Prefer live Shortcut; underlying zsh only if `Automation/stream-deck-operations/` is restored | Confirm (writes archives) |
| `SD-Open-Finance-Project` | Prefer live Shortcut | Low |
| `SD-Start-Workspace` | Prefer live Shortcut | Low |

Docs also mention (create if missing): `SD — Capture Idea`, `SD — System Health Check` (or hyphen variants).

### Spencer / day layouts

| Live name | Layout / role | Risk |
|---|---|---|
| `Start My Day` | Primary day start (existing habit) | Low–med (launches apps) |
| `START_MY_DAY` | Same layout family | Low–med |
| `SMD` | Likely alias / short start | Low–med |
| `CLEANUP` | Spencer `CLEANUP` | Confirm |
| `DESKTOP_COMMANDER` | Spencer Desktop Commander | Low–med |
| `NOTEBOOKLM` | Spencer NotebookLM | Low–med |
| `NOTEBOOK` | Related notebook flow | Low |
| `PRINT_FACTORY_PRINT_Fulo_Filo` | Print Factory / FulôFiló | Confirm (may print) |
| `THINKING_WORKSPACE` | Thinking layout | Low–med |
| `SPENCER - Thinking` | Thinking variant | Low–med |
| `Open Spencer This Desktop` | Open Spencer | Low |

Spencer restore pattern (from project docs):

```zsh
open -a Spencer
# wait for CLI, then:
/Applications/Spencer.app/Contents/MacOS/SpencerCLI --restore "<LAYOUT>" --launch-apps=true
```

### Cursor / AI / thinking

| Live name | Notes | Risk |
|---|---|---|
| `Open_Cursor_A.tlas` | Open Cursor Atlas | Low |
| `hello from cursor` | Test / demo | Low |
| `Apple_Intelligence` | Apple Intelligence entry | Low |
| `Grok AI Chat 2` | Grok chat | Low |
| `Get Started with Models` | Models onboarding | Low |
| `Sip The Mead of Knowledge` | Custom knowledge flow | Low |
| `DESKTOP_COMMANDER` | Also listed under Spencer | Low–med |

### Focus, windows, media

| Live name | Risk |
|---|---|
| `Start Pomodoro` | Low |
| `Stop Distractions` | Confirm (Focus / blocks) |
| `Quit_YouTube` | Confirm (quits app) |
| `Tile Last 2 Windows` | Low |
| `Tile Last 4 Windows` | Low |
| `Split Screen 2 Apps` | Low |
| `Split_Finder` | Low |
| `Play Playlist` | Low |
| `Read Later` | Low |
| `Translate Selection` | Low |

### System / network / home

| Live name | Risk |
|---|---|
| `Bluetooth` | Confirm |
| `WiFiman` | Low–med |
| `Home and Away Settings` | Confirm (home automation) |
| `PIOS UniFi Daily Health.signed 1` | Low (health-style) |
| `CLEANUP` / `Clean` | Confirm |
| `Download File` | Med (network/filesystem) |
| `Open URLs` | Med |
| `New Note` | Low |
| `API Key Saver` | **Secrets — never run unless user explicitly requests; never log output** |

### Print / business

| Live name | Risk |
|---|---|
| `PRINT_FACTORY_PRINT_Fulo_Filo` | Confirm before print |

## Preferred agent strategy

1. Match user phrase → table above → **live** name.
2. If Stream Deck ops: run the live Shortcut; only call `Automation/stream-deck-operations/scripts/*.zsh` when that folder exists.
3. If Spencer layout: prefer Spencer CLI or `/Users/giovannini.eduardogmail.com/Automation/spencer/restore_*.sh` when Shortcut is missing or stubbed.
4. If health report for Cursor skills: use `/macos-health-check` → `/Users/giovannini.eduardogmail.com/Reports/SystemHealth/`.

## Refreshing this file

When the library changes materially, re-run:

```zsh
"$HOME/.cursor/skills/apple-shortcuts/scripts/list-shortcuts.zsh"
```

Update the inventory section; bump the curated date.
