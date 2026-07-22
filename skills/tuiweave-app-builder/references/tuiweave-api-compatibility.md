# tuiweave API compatibility

Generated from tuiweave revision `a7980f9968c58ea1bf8f417045b24e4ab68a71cb`. Verify against the application pinned revision.

## Relevant package contracts

| Package | Contract |
|---|---|
| `tuiweave` | `tuiweave.Presets()` + `ThemeForPreset`, or a named constructor; never raw colors |
| `layout` | `layout.Vertical(...).Apply(area, &components...)`; `SizeModeOf` for sizing exceptions |
| `snaptest` | `Snap`, grapheme-preserving `SnapCells`, `RunScenario`, `SnapScenario`; follow the compile-checked tutorial |
| `inspect` | `Inspect()`, `Bind`, `BindAt`, `Group`, `Marshal`; follow the field/action contract in `inspect/README.md` |
| `focus` | `NewManager(n)`, `NewScope(n)`, or `NewStack(n)`; apply fresh addresses after changes |
| `scrollbar` | `scrollbar.For(theme, component)` in a 1-cell layout segment |
| `textarea` | Logical-rune selection, cell-aware wrapping, bounded undo/redo, word movement/deletion, bounded kill/yank, `CursorPosition`, and one-edit `ReplaceRange`; Enter inserts a newline |
| `dialog` | App owns visibility; width-bounded titles, bodies, and buttons; result arrives as `ResultMsg` |
| `tabs` | `SetTabs`, `Focus`, `SelectedID`; `IndexAt` maps a local cell x-coordinate to a rendered tab |
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


## Layout constraint compatibility


The stable application API is the `layout.Constraint` name plus the `Len`,
`Min`, `Max`, `Percent`, `Ratio`, and `Fill` constructors. tuiweave owns the
sealed constraint representation and translates it to the Ultraviolet solver
only when constructing a `Vertical` or `Horizontal` layout. Ultraviolet
constraint identity is not part of the v1 contract.

Applications following the documented API require no migration:

```go
parts := []layout.Constraint{
	layout.Len(3),
	layout.Fill(1),
}
view := layout.Vertical(parts...)
```

Direct construction of, conversion to, or storage as
`github.com/charmbracelet/ultraviolet/layout.Constraint` is unsupported and no
longer type-compatible. An application that used that pre-v1 implementation
detail must replace Ultraviolet constraint values with tuiweave's constructors.
This boundary was completed in
[Issue #28](https://github.com/ishan5ain/tuiweave/issues/28).


## Source of truth

Read `AGENT-CONTRACT.md`, `COMPATIBILITY.md`, `AGENT-CATALOG.md`, the matching `AGENTS.md` recipe, and the closest runnable example from the pinned tuiweave checkout before editing.
