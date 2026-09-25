# Blueprint

A skill for terminal AI agents (Claude Code, Cursor CLI, anything that reads `SKILL.md`) that turns the plan an agent just wrote into a designed HTML page and opens it in your browser.

You still work in the terminal. But when the agent says "here's my plan," instead of reading 200 lines of monospace you get a page: summary and the decision you're being asked for at the top, context with file references, a diagram of how the pieces fit, numbered steps with the files each one touches, risks, verification, and what happens on approval. Same layout every time, so you always know where to look.

## Install

```sh
git clone https://github.com/dannyhamam/blueprint.git
cd blueprint && ./install.sh
```

That symlinks the clone into `~/.claude/skills/blueprint` and `~/.cursor/skills/blueprint`, so keep it where you cloned it. `git pull` updates both. To put it in a single project instead, copy or symlink the repo to `.claude/skills/blueprint` or `.cursor/skills/blueprint` inside that project.

## Use

Nothing to invoke. The skill's description tells the agent to use it whenever it presents a plan of more than a few steps. You can also force it:

```
/blueprint
```

or "blueprint this", "re-render the plan", "show me that as a blueprint".

Pages are written to `~/.blueprint/<date>-<slug>.html` and opened. They live outside your repo, so nothing shows up in `git status`. If you want a plan checked in, say so and give a path.

### Design requests

Per plan: "make this one dark", "denser", "bigger type". The agent puts the override in the page's `<style id="custom">` block and notes it in the footer; the structure stays the same.

Permanently: edit `templates/plan.html`. Every future plan follows. Then run `python3 scripts/build-example.py` and open `examples/example-plan.html` to check the change didn't make things worse.

## Layout

```
SKILL.md                      the skill: when to trigger, workflow, plan anatomy, writing and design rules
templates/plan.html           the single-file template with the design system baked in
reference/components.md       markup for every component the template styles
reference/diagrams.md         which Mermaid diagram for which kind of plan, and how not to break it
reference/design.md           tokens, type, layout, and where the accent colour is allowed
reference/design-prompt.md    a prompt for exploring alternative designs in a design tool
examples/example-main.html    the content of a complete plan
examples/example-plan.html    that content rendered with the current template (visual reference)
scripts/build-example.py      rebuilds the example from template + content
install.sh                    symlinks into ~/.claude/skills and ~/.cursor/skills
```

## Diagrams

Mermaid, loaded from CDN when the page opens and themed to match the page. Offline, the page shows the Mermaid source in a code block instead of a broken box. For diagrams that must work offline, or when Mermaid's auto-layout tells the wrong story, `reference/components.md` has a hand-drawn SVG pattern that uses the same colours.

## License

MIT
