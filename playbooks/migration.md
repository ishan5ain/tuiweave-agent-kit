# Migration playbook

## Inventory first

Inventory current rendering, terminal sizing, input handling, scrolling,
selection, focus, modals, mouse routing, domain state, persistence, and tests.
For each concern classify it as:

- reusable tuiweave behavior;
- application-owned behavior;
- candidate tuiweave API gap.

Map actual APIs against the pinned tuiweave revision before planning. Preserve
current behavior and snapshot it before intentionally changing visuals.

## Slice the migration

Create vertically usable tasks with the standard contract and explicit file
ownership. Each slice should compile, preserve behavior, and include its own
acceptance test. Do not run slices in parallel when they edit shared model,
render, update, focus, or layout files; use isolated worktrees when parallel
execution is required.

Recommended order: shell/layout, theme roles, focus/routing, scrolling/mouse,
modals/results, inputs/completion, then domain views. Keep backend and session
logic application-owned.

Review every golden diff. Report reusable gaps with a minimal reproducer and
acceptance contract; do not add guessed wrappers or local tuiweave forks.
