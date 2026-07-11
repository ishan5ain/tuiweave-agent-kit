#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
	printf 'usage: %s /path/to/gotui\n' "$0" >&2
	exit 2
fi

gotui=$(cd "$1" && pwd)
[ -f "$gotui/AGENT-CATALOG.md" ] || { printf 'not a gotui checkout: %s\n' "$gotui" >&2; exit 1; }

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
output="$script_dir/../skills/gotui-app-builder/references/gotui-api-compatibility.md"
revision=$(git -C "$gotui" rev-parse HEAD 2>/dev/null || printf unknown)
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT HUP INT TERM

{
	printf '# gotui API compatibility\n\n'
	printf 'Generated from gotui revision `%s`. Verify against the application pinned revision.\n\n' "$revision"
	printf '## Relevant package contracts\n\n'
	printf '| Package | Contract |\n|---|---|\n'
	grep -E '^\| `(layout|scrollbar|focus|dialog|autocomplete|textarea)`' "$gotui/AGENT-CATALOG.md" |
		sed -E 's/^\| (`[^`]+`) \| [^|]+ \| ([^|]+) \|$/| \1 | \2 |/'
	printf '\n## Compatibility notes\n\n'
	sed -n '/^## API compatibility notes/,/^## Validation loop/p' "$gotui/AGENT-CATALOG.md" | sed '1d;$d'
	printf '\n## Source of truth\n\n'
	printf 'Read `AGENT-CATALOG.md`, the matching `AGENTS.md` recipe, and the closest runnable example from the pinned gotui checkout before editing.\n'
} > "$tmp"

mv "$tmp" "$output"
trap - EXIT HUP INT TERM
printf 'updated %s from gotui %s\n' "$output" "$revision"
