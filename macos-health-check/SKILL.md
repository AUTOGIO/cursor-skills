---
name: macos-health-check
description: Perform a comprehensive, read-only macOS health assessment covering hardware, storage, memory, processes, services, networking, security posture, Apple Silicon compatibility, Homebrew, LaunchAgents, LaunchDaemons, logs, and operational risks.
---

# macOS Health Check

## Objective

Perform a read-only health assessment of the local Mac and write a timestamped report under `~/Reports/SystemHealth/`.

## Invocation

Cursor may auto-invoke this skill when the request matches the description. Slash command also works:

```text
/macos-health-check
```

## Scope

Hardware, OS, storage, memory, processes, LaunchAgents/Daemons, Homebrew, networking, security posture, Apple Silicon compatibility, crashes/logs, backups, and available software updates (list only).

## Non-Goals

Do **not**:

- Remediate problems
- Kill processes or restart services
- Unload LaunchAgents / modify plists
- Delete caches or run cleanup tools
- Install updates or packages
- Modify permissions, network, or security settings
- Use `sudo`
- Expose secret values

## Authorized Output

Create **only** a new timestamped report per [output-policy.md](../_shared/references/output-policy.md):

```text
/Users/eduardofgiovannini/Reports/SystemHealth/system_health_YYYY-MM-DD_HH-MM-SS.md
```

Do not write to cwd, `$HOME`, or `MacHealthOS/` by default. User may override with an absolute path.

## Required Inputs

- Optional: absolute output path override
- Optional: focus areas (storage, security, LaunchAgents, etc.)

## Safety Constraints

Consult:

- [Safety Policy](../_shared/references/safety-policy.md)
- [Output Policy](../_shared/references/output-policy.md)
- [Evidence Standard](../_shared/references/evidence-standard.md)
- [Finding Format](../_shared/references/finding-format.md)
- [Severity Model](../_shared/references/severity-model.md)
- [Execution Policy](../_shared/references/execution-policy.md)
- [Report Guidelines](../_shared/references/report-guidelines.md)
- [Command Safety](references/command-safety.md)
- [macOS Health Checks](references/macos-health-checks.md)

If a check requires administrative access, report the limitation and skip that check.

Finding IDs use prefix `MACOS-`.

## Workflow

1. Resolve output path (default under `~/Reports/SystemHealth/`; create folder if needed)
2. Run deterministic collection via [collect-system-state.zsh](scripts/collect-system-state.zsh)
3. Map system identity, hardware, and OS
4. Review storage, memory, processes, services
5. Review LaunchAgents/Daemons, Homebrew, networking
6. Review security posture and Apple Silicon compatibility
7. Review crashes/logs, backups, updates (read-only)
8. Analyze with evidence; consolidate findings
9. Write the timestamped report from [system-health-report.md](templates/system-health-report.md); include absolute path in the header
10. Confirm no system modifications occurred

Prefer script output before inference. Do not implement the remediation plan.

## System Discovery

Run:

```zsh
"$HOME/.cursor/skills/macos-health-check/scripts/collect-system-state.zsh"
```

Capture stdout for analysis. Do not persist script output as a second report file unless the user asks.

## Hardware and OS Review

macOS version, kernel, architecture, model, chip, uptime, boot time.

## Storage Review

Free space, volume health signals, Time Machine status, snapshot pressure when observable without escalation.

## Memory and Process Review

Memory pressure, swap, load averages, top CPU/memory processes. Limit sample size.

## Service Review

User/system service failures visible without `sudo`.

## LaunchAgent and LaunchDaemon Review

Summarize loaded jobs; flag failed/repeatedly restarting user services and invalid paths when evidenced. Do not unload anything.

## Homebrew Review

Detect brew at `/opt/homebrew/bin/brew` or `/usr/local/bin/brew`. Version, services list; `brew doctor` only if safe/non-modifying and scoped.

## Networking Review

Interfaces, default route, DNS summary, listening TCP ports. Flag unexpected listeners with evidence — not every listener is a defect.

## Security Posture Review

Firewall, FileVault, Gatekeeper, SIP — status only.

## Apple Silicon Compatibility Review

Rosetta presence, Intel-only processes when reasonably detectable, Homebrew architecture mismatches.

## Logging and Crash Review

Recent system/application crashes and shutdown causes when accessible. Limit output volume.

## Operational Stability Review

Cross-cutting signals: storage + memory pressure, crash loops, failed agents, update backlog.

## Required Report Structure

Use [templates/system-health-report.md](templates/system-health-report.md).

## Stop Conditions

Stop a check (not necessarily the whole skill) when:

- Administrative access would be required
- Command safety is uncertain
- A command appears to modify state
- Output would expose secrets

Document skipped checks.

## Completion Response

Use [completion-summary.md](../_shared/templates/completion-summary.md):

- Status and report path
- Findings by severity
- Skipped/failed commands
- Highest-priority next action (advisory only)
- Confirmation that no remediation or system changes were performed
