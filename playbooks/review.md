# Review playbook

Audit the pinned gotui version and actual contracts before reviewing behavior.
Check:

- all colors use `gotui.Theme` roles;
- app code does not import Ultraviolet;
- layout rectangles are app-owned and bounded components receive `SetSize`;
- each component `Update` return model is reassigned and each command collected;
- fresh component addresses are applied after copied focus-model updates;
- wheel messages reach scrollables even while blurred and use layout bounds
  when multiple panes exist;
- modal command results are delivered and visibility remains app-owned;
- narrow, empty, focused, and scrolled states behave intentionally;
- snapshots cover rendering and scenarios cover transitions/results;
- referenced gotui API names exist at the pinned revision.

Classify findings as blocking correctness defects, advisory coverage/design
risks, or candidate gotui API gaps. Never regenerate goldens during an audit.
