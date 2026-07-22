#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

mkdir -p "$tmp/kit/scripts" "$tmp/kit/skills/tuiweave-app-builder/references" "$tmp/core"
cp "$root/scripts/sync-tuiweave-reference.sh" "$tmp/kit/scripts/"

cat > "$tmp/core/AGENT-CATALOG.md" <<'EOF'
| Package | Use when | First API / contract |
|---|---|---|
| `tuiweave` | Choosing themes | `Presets()` |
| [`snaptest`](snaptest/README.md) | Testing | `Snap`, `SnapCells`, `RunScenario` |
| `inspect` | Inspection | `BindAt` and qualified actions |
| `tabs` | Navigation | `IndexAt` accepts local coordinates |

## API compatibility notes

- Compatibility sentinel.

## Validation loop
EOF

cat > "$tmp/core/COMPATIBILITY.md" <<'EOF'
### Constraints

Use tuiweave-owned constraint constructors.

## Release and migration policy
EOF

"$tmp/kit/scripts/sync-tuiweave-reference.sh" "$tmp/core" > "$tmp/run.out"
output="$tmp/kit/skills/tuiweave-app-builder/references/tuiweave-api-compatibility.md"

grep -q '| `snaptest` | `Snap`, `SnapCells`, `RunScenario` |' "$output"
grep -q '| `inspect` | `BindAt` and qualified actions |' "$output"
grep -q '| `tabs` | `IndexAt` accepts local coordinates |' "$output"
grep -q 'Compatibility sentinel' "$output"
grep -q 'Use tuiweave-owned constraint constructors' "$output"

before=$(cksum "$output")
"$tmp/kit/scripts/sync-tuiweave-reference.sh" "$tmp/core" > "$tmp/rerun.out"
after=$(cksum "$output")
[ "$before" = "$after" ]

printf 'PASS: tuiweave reference sync\n'
