# Repository Checks Checklist

Use as a checklist during audit. Not every item applies to every repo — skip with a brief note when irrelevant.

## Purpose and Entry Points

- [ ] Project purpose inferred from code (not only README)
- [ ] Primary entry points identified (CLI, app, server, library)
- [ ] Languages and frameworks detected
- [ ] Package managers and build systems identified

## Dependencies and Config

- [ ] Dependency manifests present and consistent
- [ ] Lock files present and committed when expected
- [ ] Configuration sources mapped (env, files, secrets managers)
- [ ] Environment variables documented vs used
- [ ] Multiple package managers / conflicting tooling

## Persistence and APIs

- [ ] Persistence layer and migrations
- [ ] API surfaces and contracts
- [ ] Authentication and authorization paths
- [ ] Error handling, timeouts, retries
- [ ] Concurrency and state management

## Operations

- [ ] Logging and monitoring hooks
- [ ] Backup / recovery assumptions
- [ ] CI/CD presence and relevance
- [ ] Tests: unit, integration, e2e; critical-path coverage

## Documentation and Hygiene

- [ ] Documentation matches implementation
- [ ] Generated files tracked or ignored correctly
- [ ] Architecture drift from stated design
- [ ] Duplicate abstractions
- [ ] Multiple sources of truth
- [ ] Ambition–Capacity Mismatch (docs/process claim more than the repo can sustain)

## Architecture Signals

- [ ] Unnecessary indirection or premature abstraction
- [ ] God modules / circular dependencies
- [ ] Feature flags or dead code paths without ownership
