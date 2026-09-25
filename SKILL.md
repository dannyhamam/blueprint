---
name: blueprint
description: Render a plan as a designed single-file HTML page and open it in the browser, so the user reads plans on a laid-out page instead of in terminal text. Use automatically whenever presenting a plan, approach, proposal, RFC, or implementation strategy of more than a few steps — after plan mode, when asked "how would you approach this", "make a plan", "propose", "what's the strategy", or when /blueprint is invoked. Also use to re-render or restyle an existing plan.
---

# Blueprint

A plan in the terminal is a wall of monospace. Blueprint is the same plan, laid out: a fixed set of sections, a diagram of how the pieces fit, numbered steps with the files they touch, and the decision being asked for, in a page the user opens in a browser. The page is a *view* of the plan, not a deliverable; it lives outside the repo.

## When to use

- Any plan with three or more steps, a tradeoff between options, or work spanning more than one file.
- Any time the user asks for a plan, approach, proposal, strategy, or RFC, or ends plan mode.
- Not for: single-step fixes, quick answers, code explanations, status updates. Those stay in the terminal.

## Workflow

1. **Finish the plan first.** Do the investigation, read the code, decide the approach. The page renders a finished plan; it is not a drafting surface.
2. **Copy the template.** Read `templates/plan.html` and fill the `<main>` block. Leave the `<style>` block untouched. Every `{{placeholder}}` is either filled or its element is deleted; never ship a literal `{{…}}`.
3. **Diagram.** At least one diagram in Approach showing how the pieces fit. Pick the type per [reference/diagrams.md](reference/diagrams.md).
4. **Write the file** to `~/.blueprint/<YYYY-MM-DD>-<slug>.html` (`mkdir -p ~/.blueprint`). Slug is 2–5 lowercase words from the title, hyphenated. Never write into the project directory unless the user explicitly asks for a path; then use exactly that path.
5. **Open it.** `open "$file"` on macOS, `xdg-open "$file"` on Linux. If there is no display (SSH, CI, container), skip and print the path.
6. **Terminal summary.** After opening, print at most eight lines: title, one-line goal, step count and effort, the decision needed, the file path. Do not repeat the full plan in the terminal; the page is the plan.
7. **Ask for go-ahead** the way you normally would, pointing at the page.

If the user says "re-render", "update the plan", or the plan changes after feedback, overwrite the same file and re-open; do not create a second file.

## Plan anatomy

Fixed order, fixed names, numbered `01`–`07`. Omit a section only when it is genuinely empty (delete the whole `<section>`); never rename, reorder, or add sections. The table of contents builds itself from what's present.

| # | Section | Contains |
|---|---------|----------|
| 00 | Header | Title ≤ 8 words naming the outcome; one-sentence subtitle; meta strip: date, repo · branch, status chip (`Proposal` / `Approved` / `In progress`), scope chip (S/M/L), step count and rough effort |
| 01 | Summary | 2–4 sentences the user could stop after and still decide. `Decision needed` callout if there is one |
| 02 | Context | Current state in prose; "What I found" as a list with a `.path` per finding; constraints and out-of-scope as a `.kv` list |
| 03 | Approach | The idea in one paragraph; the diagram; "Options considered" table when alternatives existed, with the chosen row marked `tr.chosen` |
| 04 | Steps | Numbered `.step` cards. Each: verb-first title; facts (effort S/M/L, depends on, risk); 1–3 sentences of what changes; files touched as `.path` chips (`.path.new` for new files); a `Verify` line. Group under `.phase` headers when more than six steps |
| 05 | Risks & open questions | Risk table (risk, likelihood, impact, mitigation) using chips for the two ratings; open questions as a `.checks` list |
| 06 | Verification | How we know the whole thing is done, as a `.checks` list |
| 07 | Next | `On approval` callout: what happens first once the user says go |

Component markup is in [reference/components.md](reference/components.md).

## Writing rules

- State the goal in the user's own words. The subtitle is what they asked for, not what you decided to build.
- Every claim about the codebase points to a path. Every step names its files.
- Prose for reasoning, tables for comparisons, cards for steps. No bullets nested in bullets.
- No filler, no hedging, no "this plan will…". Say what changes.
- Rendered content from code, logs, or user text is escaped as text. Never inject it as markup or script.
- Keep it to one screen per section where possible. If Context runs long, the plan is probably two plans.

## Design rules

The template enforces most of these. Do not fight it.

- Never edit `:root` tokens or layout CSS inside a plan. Design changes go in the repo template so every plan matches.
- Serif is for the `h1` and section numbers only. Body is system sans. Paths and code are mono.
- Blueprint blue marks exactly four things: the chosen option, the current phase, the decision callouts, and links. It is never decorative.
- Green, amber, and red appear only inside chips and callouts, only for status or severity.
- One concept per diagram. More than twelve nodes: split it.
- No emoji, no gradients, no icons, no images.

### User-specified design requirements

If the user asks for a design change on this plan ("make it dark", "denser", "bigger type", "match X"), put the override CSS in `<style id="custom">` in the head and note it in the footer as `custom style: <what>`. Keep the anatomy and components; only restyle. If they want the change every time, tell them it belongs in `templates/plan.html` in the blueprint repo and offer to make it there. Tokens and rationale are in [reference/design.md](reference/design.md).

## Verify before opening

- No literal `{{` left in the file.
- Sections present are numbered in order with no gaps in what remains.
- At least one diagram in Approach; each Mermaid block parses (balanced brackets, no unquoted special characters in labels).
- Every step has files and a Verify line.
- Decision callout in Summary matches the ask in Next.
- Nothing in `<style id="custom">` unless the user asked.
- File is under `~/.blueprint/` (or the path the user named).

## Resources

- Template: [templates/plan.html](templates/plan.html)
- Component markup: [reference/components.md](reference/components.md)
- Diagram guide: [reference/diagrams.md](reference/diagrams.md)
- Design tokens and rationale: [reference/design.md](reference/design.md)
- A complete rendered plan: [examples/example-plan.html](examples/example-plan.html)
