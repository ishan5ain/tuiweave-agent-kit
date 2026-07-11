# Install for Codex

Install the same standard skill package globally or per project:

```sh
mkdir -p "$CODEX_HOME/skills"
cp -R skills/gotui-app-builder "$CODEX_HOME/skills/gotui-app-builder"
```

For a project-local installation, copy or symlink the package to
`.agents/skills/gotui-app-builder`. Keep `SKILL.md` and its `references/`
together. Restart or refresh skill discovery, then request greenfield,
migration, or review mode explicitly when useful.
