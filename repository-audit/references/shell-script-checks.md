# Shell Script Checks

Apply when `.sh`, `.zsh`, `.bash`, or other shell scripts are present.

## Structure and Safety

- [ ] Shebang present and appropriate
- [ ] Strict mode (`set -euo pipefail` or documented exception)
- [ ] Quoting of variables and paths
- [ ] Word-splitting / glob-expansion hazards
- [ ] Path resolution (absolute vs relative; `cd` usage)
- [ ] Command existence checks before use
- [ ] Temporary files and cleanup traps
- [ ] Exit codes and error messages
- [ ] Idempotency where expected
- [ ] Silent failure patterns

## High-Risk Patterns (contextual — not automatic vulnerabilities)

Analyze context before classifying as a finding:

- Privilege use (`sudo`)
- Destructive operations
- `rm -rf`
- `eval`
- `curl | sh` / `wget | sh`
- Dynamic `source`
- `find -exec` / unbounded `xargs`
- Pipefail / pipe exit propagation gaps

## Clarification

Risky commands require contextual analysis. Do **not** automatically classify every occurrence as a vulnerability. Document evidence, impact, and whether the risk is mitigated by guards, interactive confirmation, or scoped paths.
