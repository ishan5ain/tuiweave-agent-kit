# Quality gates

Before handoff:

```sh
go build ./...
go vet ./...
go test ./...
go test ./... -update
git diff -- '**/testdata/**'
./path/to/gotui-agent-kit/scripts/gotui-audit.sh --repo . --strict --verify
```

Only run `-update` after an intentional rendering change. Read every changed
golden and explain the visual delta. The repository-wide gotui update command
may reach packages without snaptest's `-update` flag; evaluate snapshot-bearing
packages and the resulting diffs rather than treating regeneration as a fix.

Record the pinned gotui revision, commands run, failures, deferred work, and
candidate library gaps in the handoff.
