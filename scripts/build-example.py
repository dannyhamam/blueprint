#!/usr/bin/env python3
"""Rebuild examples/example-plan.html from templates/plan.html + examples/example-main.html.

Run after changing the template so the example (the visual regression reference)
always carries the current CSS:

    python3 scripts/build-example.py
"""
import re
from pathlib import Path

root = Path(__file__).resolve().parent.parent
template = (root / "templates" / "plan.html").read_text()
main = (root / "examples" / "example-main.html").read_text().strip()

title = re.search(r"<h1>(.*?)</h1>", main, re.S).group(1).strip()
out = re.sub(r"<main>.*?</main>", lambda _: main, template, count=1, flags=re.S)
out = out.replace("<title>{{TITLE}} · Blueprint</title>", f"<title>{title} · Blueprint</title>")

dest = root / "examples" / "example-plan.html"
dest.write_text(out)
leftover = re.findall(r"\{\{.*?\}\}", out)
print(f"wrote {dest.relative_to(root)}" + (f"  WARNING leftover placeholders: {leftover}" if leftover else ""))
