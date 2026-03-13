#import "../lib.typ": init, block, mark, bbox, dot, arc

#show: init.with()
#set page(width: 19cm, height: 9cm, margin: 8pt)

#let src = "    t = load(a, i)\n    y = t * scale\n    store(out, y)"
#let m_load = mark("load", start: 1, end: 1, trim-left: true)
#let m_mul = mark("mul", start: 2, end: 2, trim-left: true)
#let m_store = mark("store", start: 3, end: 3, trim-left: true)

#block(
  name: "demo",
  code: src,
  lang: "c",
  marks: (m_load, m_mul, m_store),
)

#bbox("demo", m_mul, stroke: 1.4pt + rgb("#7a1f44"))
#dot("demo", m_load, which: "east", color: rgb("#4a0f2f"))
#dot("demo", m_store, which: "west", color: rgb("#4a0f2f"))
#arc(
  "demo",
  m_load,
  m_store,
  from-anchor: "east",
  to-anchor: "west",
  bend: 20pt,
  stroke: 1.2pt + rgb("#4a0f2f"),
)
