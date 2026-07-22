#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
	printf 'usage: %s /path/to/tuiweave\n' "$0" >&2
	exit 2
fi

tuiweave=$(cd "$1" && pwd)
[ -f "$tuiweave/AGENT-CATALOG.md" ] || { printf 'not a tuiweave checkout: %s\n' "$tuiweave" >&2; exit 1; }
[ -f "$tuiweave/COMPATIBILITY.md" ] || { printf 'missing compatibility contract: %s\n' "$tuiweave/COMPATIBILITY.md" >&2; exit 1; }

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
output="$script_dir/../skills/tuiweave-app-builder/references/tuiweave-api-compatibility.md"
revision=$(git -C "$tuiweave" rev-parse HEAD 2>/dev/null || printf unknown)
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT HUP INT TERM

{
	printf '# tuiweave API compatibility\n\n'
	printf 'Generated from tuiweave revision `%s`. Verify against the application pinned revision.\n\n' "$revision"
	printf '## Relevant package contracts\n\n'
	printf '| Package | Contract |\n|---|---|\n'
	grep -E '^\| (\[)?`(tuiweave|layout|scrollbar|focus|inspect|tabs|snaptest|dialog|autocomplete|textarea)`' "$tuiweave/AGENT-CATALOG.md" |
		sed -E \
			-e 's/^\| (\[[^]]+\]\([^)]*\)|`[^`]+`) \| [^|]+ \| ([^|]+) \|$/| \1 | \2 |/' \
			-e 's/\[`([^`]+)`\]\([^)]*\)/`\1`/'
	printf '\n## Compatibility notes\n\n'
	sed -n '/^## API compatibility notes/,/^## Validation loop/p' "$tuiweave/AGENT-CATALOG.md" | sed '1d;$d'
	printf '\n## Layout constraint compatibility\n\n'
	sed -n '/^### Constraints/,/^## Release and migration policy/p' "$tuiweave/COMPATIBILITY.md" | sed '1d;$d'
	printf '\n## Source of truth\n\n'
	printf 'Read `AGENT-CONTRACT.md`, `COMPATIBILITY.md`, `AGENT-CATALOG.md`, the matching `AGENTS.md` recipe, and the closest runnable example from the pinned tuiweave checkout before editing.\n'
} > "$tmp"

mv "$tmp" "$output"
trap - EXIT HUP INT TERM
printf 'updated %s from tuiweave %s\n' "$output" "$revision"
