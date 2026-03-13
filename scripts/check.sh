#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

mkdir -p /tmp/codez-check

printf 'Compiling curated examples...\n'
typst compile --root . examples/touying-emeraude-mlir.typ /tmp/codez-check/touying-emeraude-mlir.pdf
typst compile --root . examples/holigrail-pop-excerpt.typ /tmp/codez-check/holigrail-pop-excerpt.pdf

printf 'Curated example compiles succeeded.\n'
