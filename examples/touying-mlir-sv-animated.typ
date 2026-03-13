#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.4"
#import "../lib.typ": mark, parse, cetz-block

#show: simple-theme.with(aspect-ratio: "16-9")

= codez + Touying

== Animated MLIR to SystemVerilog Mapping

#let mlir-lines = (
  "module {",
  "  hw.module @forward(in %arg0 : !hw.array<16xi32>, in %arg1 : !hw.array<16xi32>, in %clk : !seq.clock, out arg1_out : !hw.array<16xi32>) {",
  "    %111 = comb.extract %local_mem_2_rdata from 31 : (i32) -> i1",
  "    %112 = comb.extract %local_mem_3_rdata from 31 : (i32) -> i1",
  "    %113 = comb.xor %111, %112 : i1",
  "    %118 = comb.concat %c1_i25, %116 : i25, i23",
  "    %120 = comb.mul %118, %119 : i48",
  "    %123 = comb.add %114, %115, %122, %c-127_i8 : i8",
  "    hw.output %result : !hw.array<16xi32>",
  "  }",
  "}",
)

#let sv-lines = (
  "module forward(",
  "  input  [15:0][31:0] arg0,",
  "                      arg1,",
  "  input               clk,",
  "  output [15:0][31:0] arg1_out",
  ");",
  "  wire [511:0] _GEN_57 = arg0;",
  "  wire [47:0]  _GEN_64 = _GEN_61 * _GEN_62;",
  "  wire [7:0]   _GEN_65 = _GEN_59 + _GEN_60 + _GEN_63 + 8'h81;",
  "  always_ff @(posedge clk) begin",
  "    if (_GEN_5) arg1_mem[_GEN_1] <= _GEN_0;",
  "  end",
  "endmodule",
)

#let mlir = parse(mlir-lines.join("\n"))
#let sv = parse(sv-lines.join("\n"))

#let mlir_mul = mark("mlir_mul", start: 7, end: 7, trim-left: true)
#let mlir_add = mark("mlir_add", start: 8, end: 8, trim-left: true)
#let sv_mul = mark("sv_mul", start: 8, end: 8, trim-left: true)
#let sv_add = mark("sv_add", start: 9, end: 9, trim-left: true)
#let sv_reg = mark("sv_reg", start: 10, end: 11, trim-left: true)

#slide(
  repeat: 4,
  self => [
    #let step = self.subslide
    #cetz.canvas(length: 1pt, {
      import cetz.draw: *

      let left-w = 500pt
      let right-w = 380pt
      let gap = 24pt
      let anno-stroke = 1.4pt + rgb("#7a1f44")
      let link-stroke = 1.2pt + rgb("#4a0f2f")

      cetz-block(
        name: "mlir",
        at: (0, 0),
        width: left-w,
        wrap: true,
        code: mlir.code,
        lang: "mlir",
        marks: (mlir_mul, mlir_add),
        badge-tag: "F",
        badge-lang: "MLIR",
        text-size: 12pt,
        line-gap: 4pt,
        mark-stroke: none,
      )

      cetz-block(
        name: "sv",
        at: (left-w + gap, 0),
        width: right-w,
        wrap: true,
        code: sv.code,
        lang: "verilog",
        marks: (sv_mul, sv_add, sv_reg),
        badge-tag: "G",
        badge-lang: "SystemVerilog",
        text-size: 12pt,
        line-gap: 4pt,
        mark-stroke: none,
      )

      content((left-w / 2, 12pt), text("Comb/Seq in MLIR", size: 14pt, weight: "bold"), anchor: "south")
      content((left-w + gap + right-w / 2, 12pt), text("Exported SystemVerilog", size: 14pt, weight: "bold"), anchor: "south")
      line("mlir.east", "sv.west", stroke: 0.9pt + gray)

      if step >= 1 {
        rect("mlir.mlir_mul.north-west", "mlir.mlir_mul.south-east", stroke: anno-stroke, radius: 2pt)
        content((rel: (8, 0), to: "mlir.mlir_mul.east"), text("Mul op", size: 11pt, weight: "bold", fill: rgb("#4a0f2f")), anchor: "west")
      }

      if step >= 2 {
        rect("sv.sv_mul.north-west", "sv.sv_mul.south-east", stroke: anno-stroke, radius: 2pt)
        line("mlir.mlir_mul.east", "sv.sv_mul.west", stroke: link-stroke, mark: (end: "stealth"))
      }

      if step >= 3 {
        rect("mlir.mlir_add.north-west", "mlir.mlir_add.south-east", stroke: anno-stroke, radius: 2pt)
        rect("sv.sv_add.north-west", "sv.sv_add.south-east", stroke: anno-stroke, radius: 2pt)
        line("mlir.mlir_add.east", "sv.sv_add.west", stroke: link-stroke, mark: (end: "stealth"))
      }

      if step >= 4 {
        rect("sv.sv_reg.north-west", "sv.sv_reg.south-east", stroke: anno-stroke, radius: 2pt)
        content(
          (left-w + gap + right-w / 2, -212pt),
          text("trim-left keeps marked boxes tight on indented lines.", size: 11pt, weight: "bold", fill: rgb("#4a0f2f")),
          anchor: "center",
        )
      }
    })
  ],
)

== Animation Controls (Pause)

- Parse source snippets into reusable code objects.
#pause
- Add semantic marks with `trim-left: true`.
#pause
- Render side-by-side with `cetz-block`.
#pause
- Animate mapping with Touying subslides.
