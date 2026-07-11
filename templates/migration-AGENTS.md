# TUI migration agent instructions

Target gotui revision: `<PINNED_VERSION_OR_COMMIT>`

Use the gotui source documentation at https://github.com/ishansain/gotui and
the migration playbook in gotui-agent-kit. Inventory existing rendering,
input, scrolling, focus, mouse, modal, and domain behavior before editing.
Classify every concern as reusable gotui behavior, application-owned behavior,
or a candidate gotui API gap.

Work in vertical slices using `migration-plan.md`. Preserve behavior before
intentional visual changes and review every golden diff. Do not parallelize
shared model/render/update files without isolated worktrees. Gotui changes and
local forks require explicit authorization. A local `replace` directive is
development-only; committed configuration remains pinned.
