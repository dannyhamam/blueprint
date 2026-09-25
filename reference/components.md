# Components

Copy-paste markup for everything the template styles. All classes are defined in `templates/plan.html`; nothing here needs extra CSS.

## Section shell

```html
<section id="approach">
  <h2><span class="n">03</span>Approach</h2>
  …
</section>
```

The `id` and `.n` number are what the sidebar reads. Keep them matching the anatomy table in SKILL.md.

## Callouts

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

## Steps

```html
<div class="phase"><b>Phase 1</b><span>Land behind a flag</span></div>
<ol class="steps">
  <li class="step">
    <div>
      <h3>Add limiter middleware</h3>
      <div class="facts"><span><b>Effort</b> M</span><span><b>Depends on</b> —</span><span><b>Risk</b> low</span></div>
      <p>Token bucket keyed by API key, 60 req/min default, configurable per route.</p>
      <div class="files"><span class="path new">src/api/middleware/limit.ts</span><span class="path">src/api/app.ts</span></div>
      <div class="verify"><b>Verify</b>Unit test: 61st request in a minute returns 429 with Retry-After.</div>
    </div>
  </li>
</ol>
```

Numbers are automatic (CSS counter) and run continuously across phases: a second `<ol class="steps">` after another `.phase` continues from where the first left off. The counter resets per `<section>`.

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

```html
<ul class="checks">
  <li class="done">Sampling in place</li>
  <li>Confirm the 60/min default with the API owner</li>
</ul>
```

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
