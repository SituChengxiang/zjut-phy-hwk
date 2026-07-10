#import "@preview/itemize:0.2.0" as _itemize

#let boxed(body) = {
  rect(stroke: 0.5pt + black, inset: 5pt, radius: 2pt)[#body]
}

#let cn-font-serif = "LXGW WenKai"
#let en-font-serif = "New Computer Modern"
#let cn-font-sans = "Source Han Serif SC"
#let en-font-sans = "New Computer Modern"

#let translation = (
  problem: (
    zh: "问题",
    en: "Problem",
  ),
  proof: (
    zh: "证明",
    en: "Proof.",
  ),
  solution: (
    zh: "解答",
    en: "Solution.",
  ),
)

#let problem-counter = counter("problem")
#let sub-problem-state = state("sub-problem", 0)

#let thmtitle(t, color: luma(0)) = {
  underline(
    text(font: (en-font-sans, cn-font-sans), weight: 600)[#t],
    stroke: color + 2pt,
    offset: 1pt,
    evade: false,
  )
}

#let problem(body, show-title: true) = {
  context {
    problem-counter.step()
    counter(math.equation).update(0)
  }
  sub-problem-state.update(0)

  if show-title {
    context thmtitle(color: red.transparentize(30%))[#translation.problem.at(
        text.lang,
      ) #problem-counter.display()]
  }
  body
}

#let sub-problem(body) = {
  sub-problem-state.update(it => it + 1)
  context {
    let current = sub-problem-state.get()
    let labels = "abcdefghijklmnopqrstuvwxyz"
    let idx = current - 1
    let label = if idx < labels.len() { labels.at(idx) } else { str(idx + 1) }
    block(inset: (left: 1.5em))[
      #text(font: (en-font-sans, cn-font-sans), weight: 600)[(#label)]
      #h(0.3em)
      #body
    ]
  }
}

#let proof(body, show-title: true) = context {
  if show-title {
    thmtitle(color: rgb("#614de4").transparentize(30%), translation.proof.at(text.lang))
  }
  body
  h(1fr)
  $square.filled$
}

#let solution(body, show-title: true) = context {
  if show-title {
    thmtitle(color: rgb("#614de4").transparentize(30%), translation.solution.at(text.lang))
  }
  body
  h(1fr)
}


#let show-math-format(body) = {
  show math.equation: it => {
    show regex("\p{script=Han}"): set text(font: cn-font-serif, weight: "light")
    it
  }

  // 默认矩阵是方
  set math.mat(delim: "[")
  set math.vec(delim: "[")
  // 增加大括号和文字的间距
  set math.cases(gap: 0.5em)

  // 给带有 label 的公式编号
  show math.equation: it => {
    if it.fields().keys().contains("label") and it.label != _itemize.adv.native-format-label{
      math.equation(
        block: true,
        numbering: n => {
          numbering("(1.1)", counter("problem").get().first(), n)
        },
        it,
      )
    } else {
      it
    }
  }

  show ref: it => context {
    let el = it.element
    if el != none and el.func() == math.equation {
      let fmt = "Eq"
      if text.lang == "zh" { fmt = "式" }
      link(el.location(), numbering(
        fmt + " (1.1)",
        counter("problem").get().first(),
        counter(math.equation).at(el.location()).at(0) + 1,
      ))
    } else {
      it
    }
  }
  body
}

#let show-common-format(body) = {
  show "。": ". "
  show raw: set text(font: ("Source Han Sans", cn-font-sans), weight: 400)

  show ref: _itemize.ref-enum
  show: _itemize.default-enum-list
  set enum(numbering: "(a)", full: true)

  // 表格默认居中
  set table(align: center)

  // quote 样式：支持数学公式的精美引用框
  show quote.where(block: true): it => {
    let body = it.body
    let attr = it.attribution
    block(
      width: 100%,
      inset: (left: 1.2em, right: 0.8em, y: 0.8em),
      stroke: (
        left: 3pt + rgb("#614de4"),
      ),
      radius: (left: 0pt, right: 4pt),
      fill: rgb("#f8f5ff"),
    )[
      #set text(style: "italic")
      #body
      #if attr != none [
        #h(1fr)
        #text(style: "normal", size: 0.9em)[--- #attr]
      ]
    ]
  }

  // 内联 quote 样式
  show quote.where(block: false): it => {
    ["] + h(0pt, weak: true) + it.body + h(0pt, weak: true) + ["]
    if it.attribution != none {
      text(style: "italic")[--- #it.attribution]
    }
  }

  body
}
