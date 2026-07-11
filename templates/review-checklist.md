# gotui review checklist

- [ ] Gotui dependency is pinned and API names match that revision.
- [ ] Colors come from semantic theme roles.
- [ ] App code has no Ultraviolet imports.
- [ ] `WindowSizeMsg` owns layout and all bounded components receive `SetSize`.
- [ ] Returned models are reassigned and commands collected.
- [ ] Focus managers receive fresh addresses after value-model updates.
- [ ] Wheel events are routed by bounds and are not focus-gated.
- [ ] Modal results are delivered and modal visibility is app-owned.
- [ ] Narrow, empty, focus, selection, and scroll states are covered.
- [ ] Rendering has snapshots and transitions have named scenarios.
- [ ] Golden changes were intentional and reviewed.
- [ ] Reusable gaps are reported instead of implemented as local forks.
