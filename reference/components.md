# Components

Copy-paste markup for everything the template styles. All classes are defined in `templates/plan.html`; nothing here needs extra CSS.

## Section shell

```html
<section id="solution">
  <h2><span class="n">02</span>Solution</h2>
  …
</section>
```

The sidebar reads each top-level section’s `id` and `h2`; it generates sequential `.n` numbers. Start with Overview and Solution. Add other top-level sections only when they need independent review; use `h3` for supporting detail inside Solution.

## Callouts

Optional components for exceptional warnings or explicitly requested annotations. Do not add decision, approval, or scope callouts to a normal plan; keep Overview and Solution focused on the explanation.

```html
<div class="callout decision"><div class="k">Decision needed</div><p>Approve the Postgres route over Redis.</p></div>
<div class="callout warn"><div class="k">Caution</div><p>Migration locks the table for ~2s per 100k rows.</p></div>
<div class="callout bad"><div class="k">Blocker</div><p>No staging DB exists yet.</p></div>
<div class="callout good"><div class="k">Already done</div><p>Schema drafted in PR #212.</p></div>
<div class="callout"><div class="k">Note</div><p>Neutral aside.</p></div>
```

## Chips and paths

```html
<span class="chip">Neutral</span>
<span class="chip blue">Chosen</span>
<span class="chip good">Low</span>
<span class="chip warn">Medium</span>
<span class="chip bad">High</span>

<span class="path">src/api/limits.ts</span>
<span class="path new">src/api/limits.test.ts</span>   <!-- dashed = new file -->
```

## Key/value list

```html
<dl class="kv">
  <dt>Constraints</dt><dd>Zero downtime; Node 18 only.</dd>
  <dt>Out of scope</dt><dd>Admin UI.</dd>
</dl>
```

## Decision table (options considered)

```html
<table>
  <thead><tr><th>Option</th><th>For</th><th>Against</th><th>Verdict</th></tr></thead>
  <tbody>
    <tr class="chosen"><td>Token bucket in middleware</td><td>No new infra</td><td>Per-instance only</td><td><span class="chip blue">Chosen</span></td></tr>
    <tr><td>Redis-backed</td><td>Shared across instances</td><td>New dependency</td><td>Later, if needed</td></tr>
    <tr><td>API gateway</td><td>Zero code</td><td>Not in this stack</td><td>Rejected</td></tr>
  </tbody>
</table>
```

## Risk table

```html
<table>
  <thead><tr><th>Risk</th><th>Likelihood</th><th>Impact</th><th>Mitigation</th></tr></thead>
  <tbody>
    <tr><td>Legit bursts get throttled</td><td><span class="chip warn">Medium</span></td><td><span class="chip warn">Medium</span></td><td>Start at 2× observed p99; log-only for 48h.</td></tr>
  </tbody>
</table>
```

## Files in request order

Use `ol.steps.request-flow` in “What changes.” Each `.step` leads with `.flow-stage` (what the request does), an `h3.file-heading` containing the primary path in `code` and an Update/New chip, a short explanation, and `.verify`. The connectors show request execution order, not the order files will be edited.

Tests, config, and docs belong in an optional `details.related-files` within the node they support. Give its `summary` a descriptive label and list each file with its specific change in a `dl`. These details expand for printing and return to their previous state afterward.

The complete pattern is in `templates/plan.html`; `examples/example-main.html` shows an SDK request entering the API, passing through a new limiter, and returning to the SDK on a 429. Mark unchanged handoffs and conditional paths in the explanation. Repeated files on a return path represent the same file, not another file to edit.

Numbers are automatic and continuous within a section. Regular `ol.steps` remains available for work that follows a dependency sequence rather than a request path; label that sequence accurately.

## Timeline

```html
<div class="timeline">
  <div class="done"><div class="when">Done</div><b>Audit</b><p>Traffic sampled, p99 known.</p></div>
  <div class="now"><div class="when">Now</div><b>Proposal</b><p>This page.</p></div>
  <div><div class="when">Wk 1</div><b>Build</b><p>Middleware + tests.</p></div>
  <div><div class="when">Wk 2</div><b>Rollout</b><p>Flag on per tenant.</p></div>
</div>
```

## Checklist

Use only when the user explicitly requests completion tracking. Standard plan-review pages use non-interactive verification statements beside file changes, without a closing checklist.

```html
<ul class="checks">
  <li class="done">Sampling in place</li>
  <li>Confirm the 60/min default with the API owner</li>
</ul>
```

Items are clickable checkboxes in the rendered page (click, Space or Enter). `class="done"` sets the initial state; after that the reader's ticks persist per file in `localStorage`, so re-rendering a plan at the same path keeps them as long as item order is unchanged. Inline `<code>` and links inside an item are fine. Use checklists only for things that get ticked off; questions go in `.questions`.

## Open questions

```html
<ol class="questions">
  <li>Is 60/min the right default for the public API?</li>
  <li>Who owns the rollout comms?</li>
</ol>
```

Numbered Q1, Q2… so the user can answer by number. Not clickable.

## Bars (pure CSS comparison)

```html
<div class="bars">
  <div><span>Middleware</span><div class="bar"><i style="--w:25%"></i></div><span class="val">2 d</span></div>
  <div><span>Redis</span><div class="bar"><i style="--w:60%"></i></div><span class="val">1 wk</span></div>
  <div><span>Gateway</span><div class="bar"><i style="--w:100%"></i></div><span class="val">3 wk</span></div>
</div>
```

## Figure with a Mermaid diagram

```html
<figure>
  <pre class="mermaid">
flowchart LR
  C[Client] --> M[Limiter]
  M -->|allowed| H[Handler]
  M -->|429| C
  </pre>
  <figcaption>Requests pass through the limiter before any handler.</figcaption>
</figure>
```

## Figure with a hand-drawn SVG (no network needed)

```html
<figure>
  <svg class="diagram" viewBox="0 0 720 140" role="img" aria-label="Three-box flow">
    <defs><marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
    <rect class="box" x="10" y="40" width="180" height="60" rx="6"/><text x="100" y="75" text-anchor="middle">Client</text>
    <path class="edge" d="M190,70 L270,70"/>
    <rect class="box hot" x="270" y="40" width="180" height="60" rx="6"/><text x="360" y="75" text-anchor="middle">Limiter</text>
    <path class="edge" d="M450,70 L530,70"/>
    <rect class="box" x="530" y="40" width="180" height="60" rx="6"/><text x="620" y="75" text-anchor="middle">Handler</text>
  </svg>
  <figcaption>Same flow, offline.</figcaption>
</figure>
```

## Code

```html
<pre><code>npm run migrate -- --dry-run</code></pre>
```

Inline: `<code>Retry-After</code>`.

## Before/after map

Use the template’s `.change-map` figure when the change can be explained in two rows of three nodes. Each `.change-row` contains a `.row-label`, three `.flow-node` elements, and two `.flow-arrow` spans with `aria-hidden="true"`. Highlight only the proposed change with `.flow-node.hot`. Optional `<small>` text explains each node. Keep labels short; the rows reflow on phones without losing the comparison.

The full pattern is in `templates/plan.html` and the rate-limiter example is in `examples/example-main.html`. It renders offline without JavaScript. Mermaid and inline SVG remain available when a simple map cannot express the plan.

## Carousel (more than one visual in one place)

Optional. Use it only when a second visual genuinely helps the reader, for example a request flow or class relationships beside the change map. Never add visuals to fill it. One visual needs no carousel.

```html
<div class="carousel" aria-label="Overview visuals">
  <div class="slides">
    <figure class="change-map" aria-label="Before and after">…</figure>
    <figure>
      <pre class="mermaid">
flowchart LR
  C[Client] --> L["Rate limiter<br/>(new)"]
  L -->|allowed| H[Handlers]
      </pre>
      <figcaption>Where the limiter sits in the request path.</figcaption>
    </figure>
  </div>
</div>
```

The template's script shows one figure at a time and adds previous and next buttons with a `1 / 2` counter. The left and right arrow keys work when the carousel has focus. Each slide is a complete `figure` with its own caption; in Overview the change map comes first. Without JavaScript the figures stack, and print shows every slide. Inactive slides stay laid out but hidden, so Mermaid diagrams render at the correct size.

## Document shell

Keep `<main id="main">` and the header’s `.eyebrow` when filling a plan. The sidebar, skip link, and local table-scroll wrappers come from the template. These controls navigate the document; they do not approve the proposal or run code.
