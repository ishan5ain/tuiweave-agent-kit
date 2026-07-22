# Quality gates

Before handoff:

```sh
go mod tidy -diff
go mod verify
go build ./...
go vet ./...
go test ./...
go test ./path/to/changed/package -update
git diff -- '**/testdata/**'
go test ./...
./path/to/tuiweave-agent-kit/scripts/tuiweave-audit.sh --repo . --strict --verify
```

Only run `-update` after an intentional rendering change. Read every changed
golden and explain the visual delta. Update only affected snapshot-bearing
packages; never use repository-wide regeneration as a way to silence failures.
Pair readable `Snap` and role-aware `SnapCells` goldens when rendering assigns
theme roles.

Record the pinned tuiweave revision, commands run, failures, deferred work, and
candidate library gaps in the handoff.
