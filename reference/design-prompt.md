# Design exploration prompt

Paste this into Claude Design (or any design tool) to explore alternative looks for the Blueprint page. It fixes the content and structure so the tool redesigns the *page*, not the product. Attach `examples/example-plan.html` as the current baseline if the tool accepts files.

---

Design a single-page HTML document that displays a software implementation plan. The reader is a developer who works in a terminal all day and opens this page in a browser to read a plan an AI agent just wrote, so they can approve, question, or redirect it. They read it once, decide, and close it. Reading speed and orientation matter more than delight.

**Fixed structure.** The page always has these sections in this order, numbered 01–07, with a persistent table of contents that highlights the current section: Summary (2–4 sentences plus a "Decision needed" callout), Context (prose, a list of findings each pointing to a file path, a constraints/out-of-scope key-value list), Approach (one paragraph, a diagram of how the pieces fit, an "options considered" comparison table with the chosen row marked), Steps (numbered cards, each with a verb-first title, effort/depends-on/risk facts, 1–3 sentences, file-path chips, and a "verify" line; grouped under phase headers when long), Risks & open questions (a risk table with likelihood/impact ratings and a checklist of open questions), Verification (a checklist), Next (an "on approval" callout). Above them, a header with a title, one-sentence subtitle, and a meta strip (date, repo and branch, status chip, scope chip, step count).

**Constraints.** Single HTML file, CSS inline, no web fonts (system serif and sans stacks only), no images, no icons, no emoji, no gradients. Diagrams are Mermaid rendered client-side or inline SVG, so design a "figure" container that flatters an SVG on a white or near-white ground. One accent color with a strict meaning: it marks the chosen option, the current phase, the active TOC entry, the decision callouts, and links. Nothing else. Green/amber/red appear only inside small chips and callouts for status or severity. Must read well at 1280px wide and reflow at 800px. Print stylesheet optional.

**Current direction (to depart from or refine).** Warm off-white paper, a serif for the headline and the section/step numbers only, system sans body at 15.5px, 232px sticky TOC on the left, 740px content column, sections separated by whitespace and a hairline, tables with uppercase tracked column headers, step numbers as large serif numerals in the accent color.

**Deliver** the full HTML with the CSS in a single `<style>` block using CSS custom properties for every color and font so the tokens can be lifted into the existing template. Use realistic placeholder content for a plan titled "Add rate limiting to the public API" with six steps across two phases, one flowchart, one options table with three rows, and two risks.
