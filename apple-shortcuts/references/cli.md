# Apple Shortcuts CLI & fallbacks

Binary: `/usr/bin/shortcuts`

## Subcommands

| Command | Purpose |
|---|---|
| `shortcuts list` | Print shortcut names (one per line) |
| `shortcuts list --folders` | List folders (when supported) |
| `shortcuts run "<name>"` | Execute a shortcut |
| `shortcuts view "<name>"` | Open shortcut in Shortcuts.app (no run) |
| `shortcuts sign` | Sign a `.shortcut` file for import/share |

There is **no** `create`, `edit`, or `delete` subcommand.

## Run options

```zsh
shortcuts run "<name-or-identifier>" \
  [-i|--input-path <path>]... \
  [-o|--output-path <path>] \
  [--output-type <uti>]
```

Common `--output-type` UTI values:

- `public.plain-text`
- `public.json`
- `public.data`

## Quoting rules

- Always double-quote names with spaces: `"Start My Day"`
- Em dash `—` (U+2014) ≠ hyphen `-`. Match `shortcuts list` bytes exactly.
- Prefer copying the name from `list` output rather than retyping.

## Exit handling

- Non-zero exit: report stderr, confirm name via `list`, then permissions/apps.
- Timeout: assume UI prompt; ask user to complete dialog or switch to script path.

## AppleScript / JXA fallbacks

Use when Shortcuts Notes/UI actions are flaky or when you need a one-shot without a Shortcut.

**Notify:**

```zsh
osascript -e 'display notification "Done" with title "Cursor"'
```

**Open app:**

```zsh
open -a "Shortcuts"
```

**Run Shortcut via AppleScript (alternate):**

```applescript
tell application "Shortcuts Events"
  run shortcut "Start My Day"
end tell
```

Prefer `/usr/bin/shortcuts run` over AppleScript unless Events bridge fails.

## Signing

```zsh
shortcuts sign --mode people-who-know-me \
  --input "/path/unsigned.shortcut" \
  --output "/path/signed.shortcut"

# broader share (use sparingly)
shortcuts sign --mode anyone \
  --input "/path/unsigned.shortcut" \
  --output "/path/signed.shortcut"
```

Open for import:

```zsh
open "/path/signed.shortcut"
```

## Helper

```zsh
"$HOME/.cursor/skills/apple-shortcuts/scripts/list-shortcuts.zsh"
"$HOME/.cursor/skills/apple-shortcuts/scripts/list-shortcuts.zsh" --json
```
