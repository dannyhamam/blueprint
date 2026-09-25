# AGENTS.md

## Commits

Every commit message is exactly one line in Conventional Commits form:

```
<type>: <summary>
```

- **Types:** `feat`, `fix`, `docs`, `refactor`, `style`, `chore`
- **Summary:** lowercase, imperative mood ("add", not "added"), no trailing period
- **Length:** the whole line is 72 characters or fewer
- **No body.** No blank line, no description, no bullet list. The only allowed extra line is a required co-author trailer.

Good:

```
feat: add dark theme tokens to plan template
fix: escape brackets in mermaid labels
docs: drop personal clone path from readme
```

Bad:

```
Updated stuff.                  # no type, past tense, period
feat: Add dark theme tokens     # capitalized summary
fix: escape brackets            # followed by a body paragraph
```

## Pull requests

Use `.github/pull_request_template.md`. Fill both sections, Description and Testing, in **1–3 sentences each**, and add nothing else.
