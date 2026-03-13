## codez

Mark and annotate code blocks with geometry-friendly anchors for slides and posters.

`codez` is built for cases where code is a visual object: you mark semantic ranges once, then reuse them for bboxes, dots, arcs, or custom Cetz overlays.

### Install

```typ
#import "@preview/codez:0.1.0": *
#show: init.with()
```

### Public API

- `init`
- `mark`, `bbox-mark`, `mark-char`
- `parse`, `pick`
- `block`, `cetz-block`
- `bbox-info`, `anchor`, `bbox`
- `canvas`, `overlay`, `dot`, `arc`

### Reference Examples

- [MLIR SwiGLU + MatMul (Touying)](examples/mlir-swiglu-matmul.typ)
- [MLIR to SystemVerilog (Poster)](examples/mlir-to-systemverilog-poster.typ)

### Preview Gallery

[![MLIR SwiGLU + MatMul preview](docs/previews/mlir-swiglu-matmul.png)](docs/previews/mlir-swiglu-matmul.pdf)
[![MLIR to SystemVerilog preview](docs/previews/mlir-to-systemverilog-poster.png)](docs/previews/mlir-to-systemverilog-poster.pdf)

### Syntax Theme

MLIR color style used in these examples is bundled in:
- [`syntaxes/codez-light.tmTheme`](syntaxes/codez-light.tmTheme)
- [`syntaxes/mlir.sublime-syntax`](syntaxes/mlir.sublime-syntax)

### Publish Workflow

- [Publishing checklist](docs/PUBLISHING.md)
- Local validation: `./scripts/check.sh`

### Credits

`codez` vendors and extends parts of `codly` (MIT), adapted for geometry-aware overlays.
See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
