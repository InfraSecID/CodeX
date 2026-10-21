#!/usr/bin/env python3
"""
CodeX — split a combined `codex-complete.md` into individual project files.

Usage:
    python3 split.py [source.md]

The source markdown is expected to contain sections in either of these forms:

    📄 FILE: NAME
    ```<lang>
    <contents>
    ```

    ## 📄 FILE: NAME
    ```<lang>
    <contents>
    ```

Each section's fenced code block is written verbatim to ./NAME.
Everything before the first "FILE:" marker is ignored (it is the prose/README body).

If no source file is given, it defaults to `codex-complete.md` in the current directory.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

# Matches a heading line that declares a file to emit.
FILE_MARKER = re.compile(r"^\s*(?:#{1,6}\s*)?📄\s*FILE:\s*(?P<name>\S+)\s*$")
# Matches the opening or closing fence of a fenced code block.
FENCE = re.compile(r"^```")

# Names that must never be written outside the current directory.
UNSAFE = re.compile(r"(^/|(^|/)\.\.(/|$))")


def split(source: Path, out_dir: Path) -> list[str]:
    lines = source.read_text(encoding="utf-8").splitlines()
    written: list[str] = []

    i = 0
    while i < len(lines):
        match = FILE_MARKER.match(lines[i])
        if not match:
            i += 1
            continue

        name = match.group("name").strip().strip("`")
        i += 1

        # Skip blank lines between the marker and the opening fence.
        while i < len(lines) and not lines[i].strip():
            i += 1

        if i >= len(lines) or not FENCE.match(lines[i]):
            print(f"  ! no code block after 'FILE: {name}', skipping")
            continue

        i += 1  # consume opening fence
        body: list[str] = []
        while i < len(lines) and not FENCE.match(lines[i]):
            body.append(lines[i])
            i += 1
        i += 1  # consume closing fence

        if UNSAFE.search(name):
            print(f"  ! refusing unsafe path: {name}")
            continue

        target = out_dir / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text("\n".join(body) + "\n", encoding="utf-8")
        written.append(name)
        print(f"  + {name}")

    return written


def main() -> int:
    source = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("codex-complete.md")

    if not source.is_file():
        print(f"error: source not found: {source}", file=sys.stderr)
        print("hint: save the combined guide as codex-complete.md first", file=sys.stderr)
        return 1

    out_dir = Path(".").resolve()
    print(f"splitting {source} -> {out_dir}")
    written = split(source, out_dir)
    print(f"done: {len(written)} file(s) written")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())