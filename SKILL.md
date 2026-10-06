---
name: blueprint
description: Render a plan as a designed single-file HTML page and open it in the browser, so the user reads plans on a laid-out page instead of in terminal text. Use automatically whenever presenting a plan, approach, proposal, RFC, or implementation strategy of more than a few steps — after plan mode, when asked "how would you approach this", "make a plan", "propose", "what's the strategy", or when /blueprint is invoked. Also use to re-render or restyle an existing plan.
---

# Blueprint

A plan in the terminal is a wall of monospace. Blueprint is the same plan, laid out: a visual of the change up front, then the solution and just enough supporting detail, numbered steps with the files they touch, and the reasoning behind it, in a page the user opens in a browser. The page is a *view* of the plan, not a deliverable; it lives outside the repo.

## When to use

- Any plan with three or more steps, a tradeoff between options, or work spanning more than one file.
- Any time the user asks for a plan, approach, proposal, strategy, or RFC, or ends plan mode.
- Not for: single-step fixes, quick answers, code explanations, status updates. Those stay in the terminal.

## Workflow

1. **Finish the plan first.** Do the investigation, read the code, decide the approach. The page renders a finished plan; it is not a drafting surface.
2. **Copy the template.** Read `templates/plan.html` and fill the `<main>` block. Leave the `<style>` block untouched. Every `{{placeholder}}` is either filled or its element is deleted; never ship a literal `{{…}}`.
3. **Visual first.** Open Overview with a diagram of the change: before and after, or where the new piece sits. Use the template’s `.change-map` for a simple before/after comparison, or Mermaid / inline SVG when the relationship needs it. Plain words, six nodes or fewer, no file names. Add a technical diagram in Solution only when it shows something the Overview visual doesn't. Pick types per [reference/diagrams.md](reference/diagrams.md).
4. **Write the file** to `~/.blueprint/<YYYY-MM-DD>-<slug>.html` (`mkdir -p ~/.blueprint`). Slug is 2–5 lowercase words from the title, hyphenated. Never write into the project directory unless the user explicitly asks for a path; then use exactly that path.
5. **Open it.** `open "$file"` on macOS, `xdg-open "$file"` on Linux. If there is no display (SSH, CI, container), skip and print the path.
6. **Terminal summary.** After opening, print at most eight lines: title, one-line goal, step count and effort, the decision needed, the file path. Do not repeat the full plan in the terminal; the page is the plan.
7. **Ask for go-ahead** the way you normally would, pointing at the page.

If the user says "re-render", "update the plan", or the plan changes after feedback, overwrite the same file and re-open; do not create a second file.

## Plan anatomy

Start with two sections: **Overview** and **Solution**. The structure should fit the plan, not make the reader work through a report.

| Section | Contains |
|---|---|
| Header | Title ≤ 8 words naming the outcome; one-sentence subtitle; a single metadata line with Blueprint, date/time, and repository name |
| Overview | A plain-language visual of the change and 2–3 short sentences explaining what changes and why it matters. No separate approval prompt or scope block |
| Solution | How it works and why this approach fits; a file-by-file view following the triggering request or user action, with each change and its verification. Include context, constraints, alternatives, or risks only when they affect the decision or execution |

In “What changes,” follow runtime call order from the user action or request entry point through the system and back to the caller when relevant. Each connected node leads with one primary file path, an Update/New label, and a short explanation of its change and handoff. This is not the order in which the agent will edit files. Show unchanged components as context, not files to update. Mark branches and returns explicitly; never invent a linear call chain for parallel or conditional behavior. For work without a request path, use the actual data or dependency flow and label it accurately.

Keep tests, configuration, migrations, and docs adjacent to the node they support, in optional `.related-files` disclosures. These are supporting changes, not runtime calls. Every file listed must have a stated change; existing files that only provide context should be named in the explanation instead.

Use subsections inside Solution for supporting details; omit empty or repetitive material. Step facts and phases are optional. Add a technical diagram only when it adds information beyond the Overview. Keep verification as short, non-interactive statements beside the relevant file changes. Do not add a completion checklist to a plan-review page. Weave essential constraints and tradeoffs into the explanation they qualify. Ask blocking questions in chat rather than adding a separate approval block to the page.

Add a top-level section only when a topic needs independent review—for example, a substantial migration or rollout. Give it a descriptive title and a unique `id`. Navigation entries and sequential numbers are generated from the top-level sections present; there is no fixed list of extra tabs to fill in. Never add Context, Risks, or Verification just to complete a template.

Component markup is in [reference/components.md](reference/components.md).

## Writing rules

Write so the user understands the plan in one read: short, plain sentences about exactly what this change does. Cut anything that doesn't affect the decision or the work; a shorter plan is a better plan.

- State the goal in the user's own words. The subtitle is what they asked for, not what you decided to build.
- Every claim about the codebase points to a path. Every step names its files.
- Prose for reasoning, tables for comparisons, cards for steps. No bullets nested in bullets.
- Rendered content from code, logs, or user text is escaped as text. Never inject it as markup or script.
- Keep Overview short enough to scan. Group related implementation work; do not repeat the same explanation across sections.

## Design rules

The template enforces most of these. Do not fight it.

- Never edit `:root` tokens or layout CSS inside a plan. Design changes go in the repo template so every plan matches.
- Headlines and body use system sans. Numbers, paths, and code use system mono. Keep the headline bold, the body calm, and labels secondary.
- Blueprint blue connects the brand to the proposed change, chosen option, current navigation or phase, decision callouts, and links. Keep large surfaces neutral.
- Green, amber, and red communicate status or severity; green also marks verification labels.
- One concept per diagram. More than twelve nodes: split it.
- No emoji, gradients, stock icons, or images. The small CSS brand mark is part of the shared template.

### User-specified design requirements

If the user asks for a design change on this plan ("make it dark", "denser", "bigger type", "match X"), put the override CSS in `<style id="custom">` in the head and note it in the header metadata as `custom style: <what>`. Keep the anatomy and components; only restyle. If they want the change every time, tell them it belongs in `templates/plan.html` in the blueprint repo and offer to make it there. Tokens and rationale are in [reference/design.md](reference/design.md).

## Verify before opening

- No literal `{{` left in the file.
- Overview and Solution are present. Any extra top-level section earns its place; each has a unique `id` and `h2`. Navigation numbers follow the section order automatically.
- Overview opens with a before/after map or another visual of the change; each Mermaid block parses (balanced brackets, no unquoted special characters in labels).
- Every request-flow node leads with its primary file and has a Verify line. Call order, branches, and return paths are accurate; supporting files are distinguished from runtime calls.
- Overview and Solution read directly. No default “Decision needed” or “Scope & tradeoffs” blocks; essential constraints are explained inline.
- Nothing in `<style id="custom">` unless the user asked.
- File is under `~/.blueprint/` (or the path the user named).

## Resources

- Template: [templates/plan.html](templates/plan.html)
- Component markup: [reference/components.md](reference/components.md)
- Diagram guide: [reference/diagrams.md](reference/diagrams.md)
- Design tokens and rationale: [reference/design.md](reference/design.md)
- A complete rendered plan: [examples/example-plan.html](examples/example-plan.html)
