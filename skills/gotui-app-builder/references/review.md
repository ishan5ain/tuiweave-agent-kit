# Review mode

Audit:

- theme-role usage and raw colors;
- forbidden Ultraviolet imports;
- `SetSize` and application-owned layout;
- MVU model reassignment and command collection;
- fresh focus application after copied model updates;
- mouse-wheel routing by layout bounds without focus gating;
- modal result delivery and app-owned visibility;
- narrow, empty, focus, selection, and scrolling behavior;
- snapshot and scenario coverage;
- actual API names/contracts at the pinned gotui revision.

Report blocking findings, advisories, and candidate gotui gaps separately. Run
the audit read-only and do not regenerate goldens or implement fixes unless the
user requested changes.
