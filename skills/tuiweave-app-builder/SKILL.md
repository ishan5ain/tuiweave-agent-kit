---
name: tuiweave-app-builder
description: Build, migrate, or review Go terminal applications that use tuiweave, with explicit layout, focus, ownership, compatibility, snapshot, scenario, and audit workflows.
---

# tuiweave app builder

Use this skill in one of three modes: greenfield, migration, or review. Determine
the requested mode from the task; if it is ambiguous, inspect the repository and
choose migration when an existing TUI is present, otherwise greenfield.

Before editing, inspect the repository and `go.mod`, record the exact tuiweave
version or commit, and read the pinned tuiweave repository's `AGENT-CATALOG.md`,
matching `AGENTS.md` recipes, closest runnable example, and `DESIGN.md` only
when package ownership is unclear. Gotui is API/design truth; this skill owns
workflow, not a duplicate component rulebook.

Read the matching reference completely:

- greenfield: `references/greenfield.md`
- migration: `references/migration.md`
- review: `references/review.md`

Always read `references/tuiweave-api-compatibility.md` before proposing APIs.

## Required task contract

Use this shape for every implementation task or migration slice:

```text
Goal:
Reference tuiweave example:
Components:
Application-owned state:
Files allowed:
Behavior to preserve:
Acceptance tests:
Verification commands:
Out of scope:
```

## Universal constraints

- Pin or identify the tuiweave version. A local `replace` is development-only.
- Keep product routing, persistence, backends, and lifecycle in the app.
- Report reusable API gaps with a minimal example and acceptance test. Do not
  create a local tuiweave fork or modify tuiweave without explicit authorization.
- Reassign every component model returned by `Update` and collect every command.
- Review every intentional golden diff; never regenerate goldens during review.
- Run build, vet, tests, and `tuiweave-audit.sh`; use `--strict --verify` at handoff.

Do not assume APIs from other libraries. In particular, prohibit:

- `autocomplete.SetSuggestions`;
- `dialog.Message`;
- `scrollbar.Model`;
- `scrollbar.ForViewport`;
- delegating `/` to `tabs.Update` as though tabs owned global search/focus keys;
- synchronizing textarea completion from `Value()` alone without cursor/range
  information.
