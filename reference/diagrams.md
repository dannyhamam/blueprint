# Diagrams

Every plan gets at least one diagram in Approach: the "how the pieces fit" picture. Add more only where a second concept needs one (a rollout timeline, a request flow). One concept per diagram, twelve nodes maximum; past that, split.

Mermaid is the default. It loads from CDN when the page opens; the template already themes it to match the page, so write plain Mermaid with no `style` or `classDef` lines. Offline, the page shows the source in a mono block instead of a broken box, so a plan is still readable without network. When the diagram must render offline or Mermaid's layout fights you (three boxes in a row, a simple before/after), draw an inline SVG using the `.diagram` classes in `components.md`.

## Which type

| Plan is about | Use | Example |
|---|---|---|
| Architecture, data flow, "where does the new thing sit" | `flowchart LR` (or `TB` when it's a stack) | new service, new module, new middleware |
| Requests, agents, or services talking in order | `sequenceDiagram` | auth flow, webhook handling, agent orchestration |
| Something with modes or lifecycle | `stateDiagram-v2` | job status, feature flag rollout, connection handling |
| Phased rollout over time | `gantt`, or the template's `.timeline` component when there are ≤ 5 phases | migrations, multi-week work |
| Data model change | `erDiagram` | new tables, changed relations |
| Before/after of a small structure | inline SVG | a config split, a file move |

## Rules that keep Mermaid from breaking

- Quote any label with punctuation: `A["Retry-After: 30s"]`, not `A[Retry-After: 30s]`.
- No `(`, `)`, `[`, `]`, `{`, `}`, `|`, `;` unquoted inside labels.
- Node ids are plain identifiers: `limiter`, not `rate-limiter`.
- Use `<br/>` for a line break inside a label, nothing else.
- Keep edge labels short: `-->|429|`, not a sentence.
- `subgraph` blocks need an `end`. Give them a title: `subgraph api["API layer"]`.
- Sequence diagrams: declare participants up front so the order is intentional.

## Examples

### Flowchart: where the new piece sits

```
flowchart LR
  C[Client] --> L["Rate limiter<br/>(new)"]
  L -->|allowed| H[Handlers]
  L -->|429| C
  H --> D[(Postgres)]
  subgraph api["API process"]
    L
    H
  end
```

### Sequence: who talks to whom

```
sequenceDiagram
  participant U as User
  participant A as Agent
  participant B as Blueprint
  participant W as Browser
  U->>A: "plan this"
  A->>A: investigate, decide
  A->>B: fill template
  B->>W: open file
  A-->>U: 8-line summary + path
```

### State: lifecycle

```
stateDiagram-v2
  [*] --> Proposal
  Proposal --> Approved: user says go
  Proposal --> Revised: feedback
  Revised --> Proposal
  Approved --> InProgress
  InProgress --> Done
```

### Gantt: phased rollout

```
gantt
  dateFormat YYYY-MM-DD
  axisFormat %b %d
  section Build
    Middleware + tests      :a1, 2026-10-01, 3d
    Config per route        :a2, after a1, 2d
  section Rollout
    Log-only mode           :b1, after a2, 2d
    Enforce, tenant by tenant :b2, after b1, 5d
```

### ER: data model

```
erDiagram
  API_KEY ||--o{ RATE_LIMIT : has
  API_KEY { string id PK  string tenant_id }
  RATE_LIMIT { string route  int per_minute }
```

## When the flowchart tells the wrong story

Mermaid lays out by dependency, not by importance. If the "new" node lands in a corner, or the eye has nothing to land on, use inline SVG and put the new piece in the middle with `class="box hot"`. Three to five boxes with arrows is usually enough; the point is orientation, not precision.
