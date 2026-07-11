# Application agent instructions

This application uses `github.com/ishansain/gotui` at: `<PINNED_VERSION_OR_COMMIT>`.

API and design truth:

- https://github.com/ishansain/gotui/blob/main/AGENT-CATALOG.md
- https://github.com/ishansain/gotui/blob/main/AGENTS.md
- https://github.com/ishansain/gotui/blob/main/DESIGN.md

Route work to the closest runnable gotui example before implementing. Keep
layout, focus, routing, product state, persistence, and backend lifecycle in
this application. Reassign every component model returned by `Update`, collect
every command, and verify rendering with snapshots plus interaction scenarios.

A local `replace github.com/ishansain/gotui => ../gotui` directive may be used
for development only. Keep the committed dependency pinned. Changes to gotui
or a local fork require explicit authorization; report reusable API gaps with a
minimal example and acceptance test.
