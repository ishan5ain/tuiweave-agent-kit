#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
audit="$root/scripts/tuiweave-audit.sh"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

fail() {
	printf 'FAIL: %s\n' "$1" >&2
	exit 1
}

expect_pass() {
	name=$1
	shift
	if ! "$audit" "$@" > "$tmp/$name.out" 2>&1; then
		sed -n '1,160p' "$tmp/$name.out" >&2
		fail "$name should pass"
	fi
}

expect_fail() {
	name=$1
	needle=$2
	shift 2
	if "$audit" "$@" > "$tmp/$name.out" 2>&1; then
		fail "$name should fail"
	fi
	grep -q "$needle" "$tmp/$name.out" || {
		sed -n '1,160p' "$tmp/$name.out" >&2
		fail "$name did not report $needle"
	}
}

before=$(find "$root/testdata/clean-app" -type f -exec cksum {} + | sort)
expect_pass clean --repo "$root/testdata/clean-app" --strict
after=$(find "$root/testdata/clean-app" -type f -exec cksum {} + | sort)
[ "$before" = "$after" ] || fail "audit rewrote the clean fixture"

expect_fail raw-color 'raw color' --repo "$root/testdata/raw-color-violation"
expect_fail ultraviolet 'Ultraviolet' --repo "$root/testdata/ultraviolet-violation"
expect_pass missing-sizing-advisory --repo "$root/testdata/missing-sizing"
expect_fail missing-sizing-strict 'WindowSizeMsg' --repo "$root/testdata/missing-sizing" --strict

printf 'PASS: tuiweave audit fixtures\n'
