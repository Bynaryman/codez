#import "@preview/cetz:0.3.4"
#import "../lib.typ": mark, cetz-block

#set page(width: 19cm, height: 9cm, margin: 8pt)

#let loop = mark("loop", start: 2, end: 4, trim-left: true)

#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  cetz-block(
    name: "panel",
    at: (0, 0),
    width: 420pt,
    wrap: true,
    code: "for i in range(n):\n    acc += x[i] * w[i]\nout = acc",
    lang: "python",
    marks: (loop,),
    stroke: 1pt + rgb("#1d154d"),
    mark-inset: (x: 4pt, y: 2pt),
    badge-tag: "kernel.py",
    badge-lang: "Python",
    badge-tag-fill: rgb("#1d154d"),
    badge-tag-text: white,
    badge-lang-fill: rgb("#f7f7f2"),
    badge-lang-text: rgb("#1d154d"),
  )
})
