#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

mkdir -p /tmp/codez-check

printf 'Compiling examples...\n'
typst compile --root . examples/quickstart.typ /tmp/codez-check/quickstart.pdf
typst compile --root . examples/slide-overlay.typ /tmp/codez-check/slide-overlay.pdf
typst compile --root . examples/poster-panel.typ /tmp/codez-check/poster-panel.pdf

printf 'All example compiles succeeded.\n'
