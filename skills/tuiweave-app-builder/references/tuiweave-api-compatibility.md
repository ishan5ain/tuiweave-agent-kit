# tuiweave API compatibility

Generated from tuiweave revision `13834919770071a93320b009600eba72bbf9748b`. Verify against the application pinned revision.

## Relevant package contracts

| Package | Contract |
|---|---|
| `tuiweave` | `tuiweave.Presets()` + `ThemeForPreset`, or a named constructor; never raw colors |
| `layout` | `layout.Vertical(...).Apply(area, &components...)`; `SizeModeOf` for sizing exceptions |
| `focus` | `NewManager(n)`, `NewScope(n)`, or `NewStack(n)`; apply fresh addresses after changes |
| `scrollbar` | `scrollbar.For(theme, component)` in a 1-cell layout segment |
| `textarea` | Logical-rune selection, cell-aware wrapping, bounded undo/redo, word movement/deletion, bounded kill/yank, `CursorPosition`, and one-edit `ReplaceRange`; Enter inserts a newline |
| `dialog` | App owns visibility; width-bounded titles, bodies, and buttons; result arrives as `ResultMsg` |
| `autocomplete` | `SetItems`, `SetQuery`, `SelectedMsg`; app owns query and insertion, disabled candidates are skipped |

## Compatibility notes


- `dialog` and `agentic/permission` are width-bounded and answer with a typed
  `ResultMsg`; the application owns visibility and modal routing. There is no
  `dialog.Message`.
- `autocomplete` is a suggestion window beside an app-owned input. Call
  `SetItems` and `SetQuery`; accept with `SelectedMsg` and apply insertion in
  the app. It does not expose `SetSuggestions`.
- `scrollbar.For(theme, component)` is the standalone renderer for scrolling
  components. There is no `scrollbar.Model` or `scrollbar.ForViewport`.
- `focus.Manager`, `focus.Scope`, and `focus.Stack` store indices/state, not
  component pointers. Apply fresh addresses after copied model updates.
- `textarea.Position` is logical rune space. `CursorPosition` reports the
  cursor, and `ReplaceRange` clamps/normalizes a range, records one undoable
  edit, and moves the cursor to the inserted value's end.
- `layout` owns geometry through `layout.Rect`; applications call `SetSize`
  from their `WindowSizeMsg` layout pass and do not import Ultraviolet.


## Source of truth

Read `AGENT-CATALOG.md`, the matching `AGENTS.md` recipe, and the closest runnable example from the pinned tuiweave checkout before editing.
