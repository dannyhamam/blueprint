# Design

Editorial page with a consulting deck's spine. Warm off-white paper, one serif for the headline and the section numbers, system sans for everything else, and a single blue that only ever means "this is the thing." Tables carry comparisons; cards carry steps; prose carries reasoning.

The design lives in `templates/plan.html`. Change it there, once, and every future plan follows. A plan never restyles itself unless the user asked for that plan to look different.

## Tokens

| Token | Value | Used for |
|---|---|---|
| `--bg` | `#FBFBF9` | page |
| `--surface` | `#F4F3EE` | callouts, code, chips, table row highlight |
| `--surface-2` | `#ECEAE2` | neutral chips, bar tracks |
| `--paper` | `#FFFFFF` | figure background so diagrams sit on white |
| `--ink` | `#1E1D1A` | headings, first table column, body emphasis |
| `--ink-2` | `#55534C` | body text in tables and cards, subtitle |
| `--ink-3` | `#8E8C83` | labels, meta, numerals, captions |
| `--line` / `--line-2` | `#E2E0D8` / `#CFCDC3` | hairlines / stronger rules |
| `--blue` | `#2451D6` | chosen row, current phase dot, active TOC, links, step numbers, section numbers |
| `--blue-soft` / `--blue-line` / `--blue-ink` | `#E8EDFB` / `#C9D5F5` / `#1A3CA8` | decision callouts and blue chips |
| `--good` / `--warn` / `--bad` | `#2C7A4B` / `#A86B12` / `#B23A32` | chips and callouts only, for status or severity |

## Type

- Headline: `Charter, Iowan Old Style, Palatino, Georgia, serif` at 40px. Charter and Iowan ship with macOS; Georgia is on everything else. No web fonts, no network.
- Section numbers (`01`…`07`) and step numbers: same serif, 20px and 26px, in blue. This is the one flourish.
- Everything else: system sans at 15.5px / 1.6. Section titles are 13px uppercase tracked, so the eye reads the number first and the title second.
- Paths, code, timeline dates: system mono.

## Layout

- Two columns: 232px sticky table of contents, 740px content, 56px gutter. The TOC is generated from the section `h2`s and highlights on scroll.
- Sections are separated by 56px of air and a hairline under the title, never by boxes.
- Content max-width 70ch for prose so lines stay readable; tables and figures use the full 740px.
- Below 900px the TOC moves above the content and timelines stack. Print drops the TOC and avoids breaking inside steps, figures, and tables.

## Where blue is allowed

Exactly: chosen option row, current timeline dot, active TOC entry, decision/on-approval callouts, links, step and section numbers, the `Proposal` status chip. If you find yourself adding blue anywhere else, you're decorating.

## Changing the design

Edit `templates/plan.html`, then re-render `examples/example-plan.html` from it and look at it in a browser at 1280px and at 800px. Keep `examples/example-plan.html` as the visual regression reference: if a change makes it worse, the change is wrong.

## Exploring alternatives

To try a different direction in a design tool before committing, paste the prompt in [`design-prompt.md`](design-prompt.md). It describes the anatomy and constraints so the tool designs the same page, not a different product.
