# Evidence Standard

Every material finding must be supported by concrete evidence. Unsupported conclusions are not allowed.

## Required Evidence

- Concrete file paths (relative preferred when in a repository)
- Symbol, function, section, command, or line-range references where possible
- Relevant command output (trimmed; secrets redacted)
- Clear separation between **evidence** and **inference**
- Explicit assumptions when evidence is incomplete

## Prohibited Patterns

- Generic claims (“should use best practices”)
- Severity inflation without impact justification
- Duplicate findings for the same root cause
- Treating documentation as truth without comparing to implementation
- Hiding uncertainty

## Confidence Levels

| Level | Meaning |
|---|---|
| **Confirmed** | Directly observed in code, config, or command output with no material ambiguity |
| **High confidence** | Strong evidence; remaining ambiguity is minor |
| **Probable** | Evidence points to the issue, but one or more gaps remain |
| **Needs verification** | Plausible concern; insufficient evidence to treat as established |

Record uncertainty rather than inventing certainty. Prefer fewer well-supported findings over many weak ones.
