#import "../lib.typ": init, block, mark, overlay

#show: init.with()
#set page(width: 25cm, height: 9cm, margin: 10pt)

#let hl_src = "%0 = arith.mulf %x, %y : f32\n%1 = arith.addf %0, %b : f32"
#let ll_src = "%0 = comb.mul %x, %y : i24\n%1 = comb.add %0, %b : i24"

#let hl_mul = mark("hl_mul", 1, 1, trim-left: true)
#let ll_mul = mark("ll_mul", 1, 1, trim-left: true)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  [
    #block(
      name: "hl",
      code: hl_src,
      lang: "mlir",
      marks: (hl_mul,),
      stroke: 1pt + rgb("#1d154d"),
    )
  ],
  [
    #block(
      name: "ll",
      code: ll_src,
      lang: "mlir",
      marks: (ll_mul,),
      stroke: 1pt + rgb("#1d154d"),
    )
  ],
)

#overlay(
  anchors: (
    "from": ("hl", hl_mul, "east"),
    "to": ("ll", ll_mul, "west"),
  ),
  (at, shift, pts, d) => {
    (d.line)(at("from"), at("to"), stroke: 1.3pt + rgb("#7a1f44"))
    (d.circle)(at("from"), radius: 2.0, fill: rgb("#7a1f44"), stroke: none)
    (d.circle)(at("to"), radius: 2.0, fill: rgb("#7a1f44"), stroke: none)
  },
)
