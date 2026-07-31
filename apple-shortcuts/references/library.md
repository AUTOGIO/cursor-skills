# Shortcut library map (this Mac)

> Snapshot aid only. **Always** re-run `shortcuts list` before executing.  
> Last curated: 2026-07-31

## Naming drift

Documented / generated names sometimes use an em dash (`SD — Start Workspace`) while the live library uses hyphens (`SD-Start-Workspace`). **Trust live `list`.**

Related project roots:

| Project | Path |
|---|---|
| Stream Deck operations | `/Users/eduardofgiovannini/Automation/stream-deck-operations/` |
| iPad Stream Deck console (Spencer) | `/Users/eduardofgiovannini/Documents/GitHub/ipad-stream-deck-console/` |
| Reports root | `/Users/eduardofgiovannini/Reports/` |

## Live inventory (2026-07-31)

Grouped from `shortcuts list` (39 names).

### Stream Deck / AUTOGIO ops

| Live name | Likely script | Risk |
|---|---|---|
| `SD-Backup-Todays-Reports` | `Automation/stream-deck-operations/scripts/backup-todays-reports.zsh` | Confirm (writes archives) |
| `SD-Open-Finance-Project` | `…/open-finance-project.zsh` | Low |
| `SD-Start-Workspace` | `…/start-workspace.zsh` | Low |

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
2. If Stream Deck ops: prefer `Automation/stream-deck-operations/scripts/*.zsh` for logging.
3. If Spencer layout: prefer Spencer CLI when Shortcut is missing or stubbed (`Hello World`).
4. If health report for Cursor skills: use `/macos-health-check` → `~/Reports/SystemHealth/`.

## Refreshing this file

When the library changes materially, re-run:

```zsh
"$HOME/.cursor/skills/apple-shortcuts/scripts/list-shortcuts.zsh"
```

Update the inventory section; bump the curated date.
