# macOS Repository Checks

Apply when the repository contains Apple/macOS artifacts (Swift, Xcode, SPM, plists, LaunchAgents, AppleScript, etc.).

## Platform

- [ ] Apple Silicon compatibility (no Rosetta-only assumption without evidence)
- [ ] Architecture-specific binaries or scripts
- [ ] Deprecated Apple APIs

## Swift / UI

- [ ] Swift / SwiftUI / AppKit usage and interoperability
- [ ] Swift concurrency correctness (actors, isolation, MainActor)
- [ ] Xcode project / SPM settings sanity

## Security and Sandbox

- [ ] Sandboxing and entitlements
- [ ] Hardened runtime
- [ ] Code signing configuration (as present in repo)
- [ ] Keychain usage patterns

## Paths and Persistence

- [ ] Application Support / Preferences / temporary file usage
- [ ] Hard-coded `/Users/<name>/` paths
- [ ] Homebrew dependency assumptions

## Automation and Permissions

- [ ] LaunchAgents / LaunchDaemons definitions in repo
- [ ] Login items references
- [ ] Shortcuts / AppleScript / JXA integrations
- [ ] Accessibility, Automation, Full Disk Access requirements documented vs used
