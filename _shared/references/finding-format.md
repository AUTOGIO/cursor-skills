# Finding Format

Use unique IDs with a skill-specific prefix (examples: `REPO-001`, `MACOS-001`). Do not report the same root cause under multiple IDs.

```markdown
### [PREFIX-001] Finding title

- Severity: Critical | High | Medium | Low | Informational
- Priority: P0 | P1 | P2 | P3
- Confidence: Confirmed | High confidence | Probable | Needs verification
- Category: Domain-specific category
- File: `relative/or/absolute/path`
- Location: `symbol, section, command, or line range`
- Evidence:
  - Concrete evidence.
- Impact:
  - Practical consequence.
- Recommendation:
  - Smallest safe remediation.
- Validation:
  - Exact method to confirm the remediation.
```

## Rules

- One finding = one root cause
- Evidence before recommendation
- Recommendation must be the smallest safe fix, not a redesign by default
- Validation must be concrete and checkable
- Severity and priority follow [severity-model.md](severity-model.md)
