# Command Safety Classification

## Safe Read-Only

Authorized for health-check collection when scoped appropriately:

- `sw_vers`, `uname -a`
- `df -h`, `vm_stat`, `memory_pressure`
- `ps`, `uptime`, `sysctl` (read)
- `launchctl list`
- `brew services list` (when brew exists)
- `scutil --dns`, `netstat`, `lsof -i` (limited)
- `fdesetup status`, `spctl --status`, `csrutil status`
- `tmutil status`
- `softwareupdate --list`

## Conditionally Safe

Require constrained scope and output limits:

- `brew doctor` (non-modifying; may be noisy)
- `log show` (time-bounded, filtered)
- `system_profiler` (specific data types only)
- `find`, `du` (depth/path limited; never system-wide unrestricted)

## Not Authorized

Never run during this skill:

- `sudo`, `kill`, `killall`
- `launchctl bootout`, `launchctl unload`
- `brew install`, `brew upgrade`, `brew cleanup`
- `softwareupdate --install`
- `rm`, `chmod`, `chown`
- `defaults write`
- Network-changing `networksetup` commands
- `diskutil erase`, `diskutil repair`

When unsure, skip and document.
