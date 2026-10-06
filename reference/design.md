# Design

A calm implementation brief: an off-white canvas, crisp white diagrams and step cards, a persistent document spine, and blue reserved for the proposed change and navigation. The page helps someone understand a plan before authorizing code changes. It never submits approval or starts work.

The shared design lives in `templates/plan.html`. Each generated plan inherits it; one-off user requests belong in `style#custom`.

## Tokens

| Token | Value | Purpose |
|---|---|---|
| `--bg` | `#f5f5f2` | warm document canvas |
| `--paper` | `#fff` | diagrams, tables, step cards |
| `--surface` / `--surface-2` | `#f2f3f4` / `#e8ebef` | code, supporting panels, tracks |
| `--ink` | `#202936` | headings and primary text |
| `--ink-2` / `--ink-3` | `#526071` / `#697585` | body details / secondary labels |
| `--line` / `--line-2` | `#e1e5e9` / `#c6ced7` | borders / stronger rules |
| `--blue` | `#345bd6` | brand, links, current navigation, proposed change |
| `--blue-soft` / `--blue-line` / `--blue-ink` | `#eef2ff` / `#ccd7ff` / `#2949b0` | decisions and selected options |
| `--good` / `--warn` / `--bad` | `#277351` / `#916013` / `#ad433c` | status, verification, severity |

## Type and hierarchy

- Paragraphs and the subtitle use the full width of their content container, aligned with diagrams and cards; do not add a separate character-based width cap.
- System sans throughout, with a bold 32–47px headline and comfortable 15px body text. No downloaded fonts.
- Section headings are 19px with small outlined mono numbers; a trailing rule separates sections without enclosing everything in cards.
- Paths and code use system mono. Paths wrap rather than stretch the page. In “What changes,” the primary file is the node heading; connected nodes follow request execution order. Supporting file changes are expandable beside the relevant node.
- The before/after map uses concise labels. Short prose explains the outcome underneath. Essential constraints belong in the relevant Solution sentence; do not add separate approval or scope panels.

## Layout and behavior

- Default to Overview and Solution. Supporting details live inside Solution; extra top-level sections appear only when they need independent review. Navigation and numbering derive from the sections present.
- A fixed 248px sidebar holds the brand and generated section navigation. Main content is at most 900px wide with 48px side gutters.
- At 1100px the sidebar and gutters narrow. At 800px navigation becomes a sticky horizontal list. At 480px map row labels move above the flow, and supporting lists stack.
- Tables scroll inside their own focusable region on small screens. Step cards keep a continuous counter across phases.
- Standard plans use non-interactive verification beside each file change. Completion checklists are omitted; the checklist component is reserved for explicitly requested tracking.
- Native browser printing removes navigation and keeps figures, cards, and table rows together where possible.
- Navigation has visible focus, an active location label, and a skip link. Reduced-motion preferences disable smooth scrolling.

## Diagrams

Use `.change-map` for a simple before/after story that renders without JavaScript or a network. Use Mermaid or inline SVG for relationships the map cannot convey. Mermaid colors match the document and the source remains available if its CDN cannot load.

## Verify changes

Run `python3 scripts/build-example.py`. Inspect `examples/example-plan.html` at desktop, 800px, and phone widths; check section navigation, supporting-file disclosures, table overflow, and print layout. The example must always be generated from the shared template and its content file.
