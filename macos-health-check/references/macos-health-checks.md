# macOS Health Checks

Checklist for interpreting collection output. Require evidence; do not treat every deviation as a defect.

## Hardware and OS

- [ ] Unsupported or unexpected OS state
- [ ] Architecture mismatch (e.g., unexpected Intel-only tooling on Apple Silicon)
- [ ] Insufficient free storage
- [ ] Abnormal memory pressure
- [ ] Swap pressure
- [ ] Thermal pressure (when accessible)
- [ ] Repeated unexpected shutdowns
- [ ] Battery health (when applicable)

## Processes

- [ ] Runaway CPU
- [ ] Runaway memory
- [ ] Zombie processes
- [ ] Repeated crashes
- [ ] Duplicate service instances
- [ ] Orphaned background processes

## Services / LaunchAgents / LaunchDaemons

- [ ] Failed LaunchAgents
- [ ] Repeated restarts
- [ ] Invalid plist executable references
- [ ] Missing executable paths
- [ ] User-specific hard-coded paths
- [ ] Disabled services still referenced
- [ ] Duplicate service ownership
- [ ] Persistent jobs without documentation

## Storage

- [ ] Critically low free space
- [ ] Large log growth (when evidenced)
- [ ] Failed Time Machine state
- [ ] Stale mounts / inaccessible external volumes
- [ ] Excessive local snapshots (when observable)

## Network

- [ ] Unexpected listeners
- [ ] Conflicting local ports
- [ ] Missing default route
- [ ] DNS anomalies
- [ ] Insecure service binding
- [ ] Locally exposed services without authentication

## Security Posture

- [ ] Firewall state
- [ ] FileVault state
- [ ] Gatekeeper state
- [ ] SIP state
- [ ] Broad local service exposure
- [ ] Weak permissions visible without escalation

## Apple Silicon

- [ ] Rosetta dependence
- [ ] Intel-only background processes
- [ ] Mixed architecture dependencies
- [ ] Homebrew under unexpected architecture
- [ ] Duplicated ARM and Intel package trees
