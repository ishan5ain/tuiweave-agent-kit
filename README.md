# tuiweave-agent-kit

Portable workflows, templates, an Agent Skills package, and read-only audit
tooling for applications built with
[`github.com/ishan5ain/tuiweave`](https://github.com/ishan5ain/tuiweave).

tuiweave remains the source of truth for component APIs, design rules, recipes,
and runnable examples. This kit owns operational workflows for greenfield apps,
existing-TUI migrations, reviews, host installation, and repeatable audits.

## Compatibility

Release `v0.1.0` is validated against tuiweave core commit
`a647f53882652763343dd57e31175e35f182427e`. Pin applications to an explicit
tuiweave tag or commit; do not use moving `@latest` instructions. Run
`scripts/sync-tuiweave-reference.sh /path/to/tuiweave` after changing the validated
revision.

## Start here

- New app: [`playbooks/greenfield.md`](playbooks/greenfield.md)
- Existing TUI: [`playbooks/migration.md`](playbooks/migration.md)
- Review or audit: [`playbooks/review.md`](playbooks/review.md)
- Reusable skill: [`skills/tuiweave-app-builder/SKILL.md`](skills/tuiweave-app-builder/SKILL.md)
- Task shape: [`playbooks/task-contract.md`](playbooks/task-contract.md)

Run the audit without modifying the target repository:

```sh
./scripts/tuiweave-audit.sh --repo /path/to/app
./scripts/tuiweave-audit.sh --repo /path/to/app --strict
./scripts/tuiweave-audit.sh --repo /path/to/app --verify
```

`--strict` promotes advisory findings to a failing exit status. `--verify`
also runs `go build ./...`, `go vet ./...`, and `go test ./...`. The audit
never rewrites source or regenerates goldens.

## Development

```sh
./tests/tuiweave-audit_test.sh
```

See [`install/`](install/) for Codex, Pi, and other Agent Skills-compatible
hosts. The same skill package is used for every host.
