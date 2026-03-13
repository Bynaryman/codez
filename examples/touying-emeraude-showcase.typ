#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.4"
#import "../lib.typ": mark as codez-mark, parse as codez-parse, cetz-block as codez-cetz-block

#show: simple-theme.with(aspect-ratio: "16-9")

#set raw(
  theme: "../syntaxes/codez-light.tmTheme",
  syntaxes: ("../syntaxes/mlir.sublime-syntax",),
)

#let anno-color = rgb("#4a0f2f")
#let anno-bbox-stroke = 1.6pt + rgb("#7a1f44")
#let code-block-stroke = 1pt + anno-color

#let codez-block(..args) = codez-cetz-block(
  stroke: code-block-stroke,
  mark-inset: (x: 4pt, y: 2pt),
  badge-tag-fill: anno-color,
  badge-tag-text: white,
  badge-lang-fill: rgb("#f7f7f2"),
  badge-lang-text: anno-color,
  badge-stroke: code-block-stroke,
  badge-radius: 6pt,
  badge-size: 13pt,
  badge-offset: (6pt, 0pt),
  badge-anchor: "south-west",
  badge-pad-x: 6pt,
  badge-pad-y: 4pt,
  ..args,
)

#let py-lines = (
  "class LlamaFfnSublayer(nn.Module):",
  "    \"\"\"Llama FFN sublayer using SwiGLU.\"\"\"",
  "",
  "    def __init__(self, dim: int = 512, hidden_dim: int | None = None):",
  "        super().__init__()",
  "        if hidden_dim is None:",
  "            hidden_dim = int(2 * (4 * dim) / 3)",
  "        self.w_gate = nn.Linear(dim, hidden_dim, bias=False)",
  "        self.w_up = nn.Linear(dim, hidden_dim, bias=False)",
  "        self.w_down = nn.Linear(hidden_dim, dim, bias=False)",
  "",
  "    def forward(self, x: torch.Tensor) -> torch.Tensor:",
  "        gate = F.silu(self.w_gate(x))",
  "        up = self.w_up(x)",
  "        return self.w_down(gate * up)",
)
#let hl-lines = (
  "...",
  "%8 = linalg.generic {ins(%7: tensor<1x2x16xf32>) outs(%5: tensor<1x2x16xf32>)} {",
  "  %19 = arith.negf %in : f32",
  "  %20 = math.exp %19 : f32",
  "  %21 = arith.addf %20, %cst_1 : f32",
  "  %22 = arith.divf %cst_1, %21 : f32",
  "  linalg.yield %22 : f32",
  "} -> tensor<1x2x16xf32>",
  "",
  "%9 = linalg.generic {ins(%8, %7: tensor<1x2x16xf32>, tensor<1x2x16xf32>) outs(%5: tensor<1x2x16xf32>)} {",
  "  %19 = arith.mulf %in, %in_7 : f32",
  "  linalg.yield %19 : f32",
  "} -> tensor<1x2x16xf32>",
  "...",
)

#let comb-lines = (
  "module {",
  "  hw.module @forward(in %arg0 : !hw.array<16xi32>, in %arg1 : !hw.array<16xi32>, in %clk : !seq.clock, in %reset : i1, out arg1_out : !hw.array<16xi32>) {",
  "    ...",
  "    %111 = comb.extract %local_mem_2_rdata from 31 : (i32) -> i1",
  "    %112 = comb.extract %local_mem_3_rdata from 31 : (i32) -> i1",
  "    %113 = comb.xor %111, %112 : i1",
  "    %118 = comb.concat %c1_i25, %116 : i25, i23",
  "    %120 = comb.mul %118, %119 : i48",
  "    %123 = comb.add %114, %115, %122, %c-127_i8 : i8",
  "    ...",
  "  }",
  "}",
)
#let sv-lines = (
  "module forward(",
  "  input  [15:0][31:0] arg0,",
  "                      arg1,",
  "  input               clk,",
  "                      reset,",
  "  output [15:0][31:0] arg1_out",
  ");",
  "  wire [511:0] _GEN_57 = arg0;",
  "  reg  [31:0]  arg1_mem[0:15];",
  "  always_ff @(posedge clk) begin",
  "    if (!reset) begin",
  "      if (_GEN_5) arg1_mem[_GEN_1] <= _GEN_0;",
  "      if (_GEN_9) arg1_mem[_GEN_6] <= 32'h0;",
  "    end",
  "  end",
  "  ...",
  "endmodule",
)

#let py = codez-parse(py-lines.join("\n"))
#let hl = codez-parse(hl-lines.join("\n"))
#let comb = codez-parse(comb-lines.join("\n"))
#let sv = codez-parse(sv-lines.join("\n"))

#let py-linear-all = codez-mark("py_linear_all", start: 8, end: 10, trim-left: true)
#let py-swiglu = codez-mark("py_swiglu", start: 13, end: 15, trim-left: true)
#let hl-math = codez-mark("hl_math", start: 3, end: 7, trim-left: true)
#let hl-mul = codez-mark("hl_mul", start: 11, end: 11, trim-left: true)
#let comb-mul = codez-mark("comb_mul", start: 8, end: 8, trim-left: true)
#let comb-add = codez-mark("comb_add", start: 9, end: 9, trim-left: true)
#let sv-always = codez-mark("sv_always", start: 10, end: 15, trim-left: true)

= Emeraude-style Codez Showcase

== Python to MLIR (animated)

#slide(
  repeat: 4,
  self => [
    #let step = self.subslide
    #cetz.canvas(length: 1pt, {
      import cetz.draw: *

      let py-w = 430pt
      let ir-w = 460pt
      let gap = 20pt

      codez-block(
        name: "py",
        at: (0, 0),
        width: py-w,
        wrap: true,
        code: py.code,
        lang: "python",
        badge-tag: "Llama.py",
        badge-lang: "Python",
        marks: (py-linear-all, py-swiglu),
        inline-marks: false,
        text-size: 11pt,
        line-gap: 4pt,
        mark-stroke: none,
      )

      codez-block(
        name: "hl",
        at: (py-w + gap, 0),
        width: ir-w,
        wrap: true,
        code: hl.code,
        lang: "mlir",
        badge-tag: "F",
        badge-lang: "MLIR",
        marks: (hl-math, hl-mul),
        inline-marks: false,
        text-size: 11pt,
        line-gap: 4pt,
        mark-stroke: none,
      )

      line("py.east", "hl.west", stroke: 1pt + gray, mark: (end: "stealth"))

      if step >= 1 {
        rect("py.py_linear_all.north-west", "py.py_linear_all.south-east", stroke: anno-bbox-stroke, radius: 2pt)
      }
      if step >= 2 {
        rect("py.py_swiglu.north-west", "py.py_swiglu.south-east", stroke: anno-bbox-stroke, radius: 2pt)
      }
      if step >= 3 {
        rect("hl.hl_math.north-west", "hl.hl_math.south-east", stroke: anno-bbox-stroke, radius: 2pt)
        line("py.py_swiglu.east", "hl.hl_math.west", stroke: 1.2pt + anno-color, mark: (end: "stealth"))
      }
      if step >= 4 {
        rect("hl.hl_mul.north-west", "hl.hl_mul.south-east", stroke: anno-bbox-stroke, radius: 2pt)
        line("py.py_linear_all.east", "hl.hl_mul.west", stroke: 1.2pt + anno-color, mark: (end: "stealth"))
      }
    })
  ],
)

== Comb/Seq to SystemVerilog (animated)

#slide(
  repeat: 3,
  self => [
    #let step = self.subslide
    #cetz.canvas(length: 1pt, {
      import cetz.draw: *
      let comb-w = 520pt
      let sv-w = 360pt
      let gap = 20pt

      codez-block(
        name: "comb",
        at: (0, 0),
        width: comb-w,
        wrap: true,
        code: comb.code,
        lang: "mlir",
        badge-tag: "F",
        badge-lang: "MLIR",
        marks: (comb-mul, comb-add),
        inline-marks: false,
        text-size: 11pt,
        line-gap: 4pt,
        mark-stroke: none,
      )

      codez-block(
        name: "sv",
        at: (comb-w + gap, 0),
        width: sv-w,
        wrap: true,
        code: sv.code,
        lang: "verilog",
        badge-tag: "G",
        badge-lang: "SystemVerilog",
        marks: (sv-always,),
        inline-marks: false,
        text-size: 11pt,
        line-gap: 4pt,
        mark-stroke: none,
      )

      if step >= 1 {
        rect("comb.comb_mul.north-west", "comb.comb_mul.south-east", stroke: anno-bbox-stroke, radius: 2pt)
      }
      if step >= 2 {
        rect("comb.comb_add.north-west", "comb.comb_add.south-east", stroke: anno-bbox-stroke, radius: 2pt)
      }
      if step >= 3 {
        rect("sv.sv_always.north-west", "sv.sv_always.south-east", stroke: anno-bbox-stroke, radius: 2pt)
        line("comb.comb_add.east", "sv.sv_always.west", stroke: 1.2pt + anno-color, mark: (end: "stealth"))
      }
    })
  ],
)
