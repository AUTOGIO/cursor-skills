# Severity and Priority Model

## Severity

| Severity | Definition |
|---|---|
| **Critical** | Immediate compromise, destructive data loss, arbitrary code execution, or total operational failure |
| **High** | Material correctness, security, or reliability issue likely to affect normal operation |
| **Medium** | Meaningful operational, maintenance, or architecture weakness |
| **Low** | Localized weakness with limited impact |
| **Informational** | Observation with no immediate remediation requirement |

## Priority

| Priority | Meaning |
|---|---|
| **P0** | Immediate action required |
| **P1** | Fix before further feature development |
| **P2** | Schedule after stabilization |
| **P3** | Optional cleanup or optimization |

## Relationship

```
Priority ≈ Impact × Likelihood × Exposure
```

Severity and priority are related but not identical. A High-severity issue with low exposure may be P2; a Medium issue blocking all users may be P1.

Do not inflate severity. Prefer accurate classification with clear impact statements.
