# Migration mode

Inventory rendering, sizing, key/mouse input, scrolling, focus, modals, domain
state, persistence, and tests. Classify each concern as reusable tuiweave behavior,
application-owned behavior, or a candidate tuiweave API gap.

Create vertical slices with the standard task contract and explicit file
ownership. Preserve behavior before visual changes. Do not execute parallel
slices against shared model/render/update/focus/layout files unless isolated
worktrees prevent overlap. Each slice compiles and has an acceptance test.

Review every golden diff. Escalate reusable gaps with a minimal reproducer;
never paper over them with guessed wrappers or local forks.
