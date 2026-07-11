# gotui-agent-kit

Portable workflows, templates, an Agent Skills package, and read-only audit
tooling for applications built with
[`github.com/ishansain/gotui`](https://github.com/ishansain/gotui).

Gotui remains the source of truth for component APIs, design rules, recipes,
and runnable examples. This kit owns operational workflows for greenfield apps,
existing-TUI migrations, reviews, host installation, and repeatable audits.

## Compatibility

Release `v0.1.0-gotui-286ea01` was validated against gotui base revision
`286ea01c0c8b8100c284e7b726ae6f9e921781cb` and the textarea completion API
introduced in the same rollout. Pin applications to an explicit gotui tag or
commit; do not use moving `@latest` instructions. Run
`scripts/sync-gotui-reference.sh /path/to/gotui` after changing the validated
revision.

## Start here

- New app: [`playbooks/greenfield.md`](playbooks/greenfield.md)
- Existing TUI: [`playbooks/migration.md`](playbooks/migration.md)
- Review or audit: [`playbooks/review.md`](playbooks/review.md)
- Reusable skill: [`skills/gotui-app-builder/SKILL.md`](skills/gotui-app-builder/SKILL.md)
- Task shape: [`playbooks/task-contract.md`](playbooks/task-contract.md)

Run the audit without modifying the target repository:

```sh
./scripts/gotui-audit.sh --repo /path/to/app
./scripts/gotui-audit.sh --repo /path/to/app --strict
./scripts/gotui-audit.sh --repo /path/to/app --verify
```

`--strict` promotes advisory findings to a failing exit status. `--verify`
also runs `go build ./...`, `go vet ./...`, and `go test ./...`. The audit
never rewrites source or regenerates goldens.

## Development

```sh
./tests/gotui-audit_test.sh
```

See [`install/`](install/) for Codex, Pi, and other Agent Skills-compatible
hosts. The same skill package is used for every host.
