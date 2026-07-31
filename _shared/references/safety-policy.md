# Shared Safety Policy

Applies to all audit and diagnostic skills in this library unless a skill explicitly authorizes a narrower exception.

## Default Mode

- Operate **read-only** by default.
- Create or update **only** the skill’s declared report/output files.
- Do not modify application source, configuration, or infrastructure unless implementation mode is explicitly authorized by the user for that skill.

## Prohibited Actions

- No package installation or dependency updates
- No deployment commands
- No production migrations
- No destructive commands (`rm -rf`, disk erase, force-push, hard reset, etc.)
- No `sudo` or privilege escalation
- No starting, stopping, unloading, or modifying services
- No LaunchAgent / LaunchDaemon changes
- No permission, ownership, or network setting changes
- No secret disclosure in reports, chats, or logs

## Secrets

- Never print API keys, tokens, passwords, private keys, or session cookies.
- Redact with `[REDACTED]`.
- Prefer describing secret *presence* and location over quoting values.

## Command Safety

1. Inspect every command before execution.
2. Prefer the smallest scoped, read-only command that answers the question.
3. Stop when command safety is uncertain; document the skipped operation.
4. Do not retry a failing command with the same approach without a changed diagnostic strategy.
5. Record commands executed, exit statuses, and skipped commands in the report.

## Authorized Outputs

A skill may create only its declared report files under the shared Reports root (or a user-supplied absolute override), as defined in [output-policy.md](output-policy.md).

- Default root: `/Users/eduardofgiovannini/Reports`
- Do not write reports to repository root, `$HOME`, or cwd by default
- Do not create speculative infrastructure, unrelated docs, or “helpful” side files
- Implementation mode requires explicit user authorization for that skill
