#import "../lib.typ": *
#set text(lang: "zh")

#show: hwk.with(author: "张三", course: [统计力学], hwk-id: 1, stu-id: 2024001)

#let sinh = math.sinh
#let cosh = math.cosh

#problem[
  由 $N$ 个*可区分、独立*的粒子组成的系统，服从*Boltzmann 统计*。每个粒子可以占据三个非简并能级之一：$-E$、$0$ 和 $E$。系统与温度为 $T$ 的热库保持热接触。

  #sub-problem[求 $T = 0 "K"$ 时的熵]
  #sub-problem[求最大熵]
  #sub-problem[求最小能量]
  #sub-problem[求配分函数]
  #sub-problem[求平均能量]
  #sub-problem[计算积分 $ integral_0^infinity (C(T)) / T dif T $]

  ---
  == 初步：单粒子配分函数

  定义 $beta = 1 / (k_B T)$。单粒子配分函数为：

  $ z = e^(beta E) + 1 + e^(- beta E) = 1 + 2 cosh(beta E) $

  三个能级的占据概率为：

  $ P(-E) = e^(beta E) / z, quad P(0) = 1 / z, quad P(E) = e^(- beta E) / z $
]

#solution(show-title: false)[
  ---
  == (a) 求 $T = 0 "K"$ 时的熵

  当 $T -> 0$ 时，$beta -> infinity$，因此 $P(-E) -> 1$，$P(0), P(E) -> 0$。

  所有粒子都占据基态 $-E$。只有*一个微观状态*（所有 $N$ 个粒子都在 $-E$ 上），因此：

  $ S = k_B ln 1 = boxed(0) $

  这与*热力学第三定律*一致。

  ---
  == (b) 求最大熵

  最大熵对应于 $T -> infinity$（$beta -> 0$），此时三个能级*等概率*。

  对于 $N$ 个可区分粒子，占据数为 $(n_1, n_2, n_3)$（其中 $n_1 + n_2 + n_3 = N$）的构型具有多重度：

  $ W = N! / (n_1 ! thin n_2 ! thin n_3 !) $

  当 $n_1 = n_2 = n_3 = N / 3$ 时，$W$ 最大。使用 *Stirling 近似*（$ln n! approx n ln n - n$）：

  $ S_(max) &= k_B ln (N! / (N/3) !^3) \
    &approx k_B [N ln N - 3 dot N/3 dot ln(N/3)] \
    &= k_B N ln 3 $

  $ boxed(S_(max) = N k_B ln 3) $

  #rect(stroke: 0.5pt + luma(150), inset: 8pt, radius: 4pt)[
    *验证：* 当 $T -> infinity$ 时，$z -> 3$，$chevron.l epsilon chevron.r -> 0$。单粒子熵为 $s = k_B (ln z + beta chevron.l epsilon chevron.r) -> k_B ln 3$，因此 $S = N k_B ln 3$。 $checkmark$
  ]

  ---
  == (c) 求最小能量

  最小能量发生在*所有* $N$ 个粒子都在最低能级 $-E$ 时：

  $ boxed(U_(min) = -N E) $

  ---
  == (d) 求配分函数

  由于 $N$ 个粒子是*可区分且独立*的，总配分函数为：

  $ boxed(Z = z^N = [1 + 2 cosh(E / (k_B T))]^N) $

  ---
  == (e) 求平均能量

  单粒子的平均能量：

  $ chevron.l epsilon chevron.r &= (-E) dot e^(beta E) / z + (0) dot 1 / z + (E) dot e^(- beta E) / z \
    &= E (e^(- beta E) - e^(beta E)) / z \
    &= - (2 E sinh(beta E)) / (1 + 2 cosh(beta E)) $

  对于 $N$ 个粒子：

  $ boxed(chevron.l U chevron.r = - (2 N E sinh(E / (k_B T))) / (1 + 2 cosh(E / (k_B T)))) $

  #rect(stroke: 0.5pt + luma(150), inset: 8pt, radius: 4pt)[
    *物理解释：* 负号表明在有限温度下，平均能量被拉低到零以下，因为基态 $-E$ 具有最大的 Boltzmann 权重。当 $T -> infinity$ 时，$chevron.l U chevron.r -> 0$；当 $T -> 0$ 时，$chevron.l U chevron.r -> -N E$。
  ]

  ---
  == (f) 计算积分

  我们需要计算：

  $ integral_0^infinity (C(T)) / T dif T = ? $

  #rect(stroke: 0.5pt + luma(150), inset: 8pt, radius: 4pt)[
    *关键洞察：* 由于能级是固定的（没有体积自由度），熵只依赖于温度：

    $ dif S = (C(T)) / T dif T $
  ]

  因此，该积分等于*总熵变*：

  $ integral_0^infinity (C(T)) / T dif T = integral_0^infinity dif S = S(T = infinity) - S(T = 0) $

  代入第 (a) 和 (b) 部分的结果：

  $ boxed(integral_0^infinity (C(T)) / T dif T = N k_B ln 3) $

  #rect(stroke: 0.5pt + luma(150), inset: 8pt, radius: 4pt)[
    *物理意义：* $C(T) / T$ 对所有温度的积分等于系统能获得的总熵——将热容量与可访问微观状态的全部范围联系起来。
  ]

  ---
  == 结果汇总

  #set text(size: 10.5pt)
  #set table(stroke: 0.5pt, align: center, inset: 8pt)

  #table(
    columns: 3,
    [*部分*], [*物理量*], [*结果*],
    [(a)], [$T = 0$ 时的熵], [$0$],
    [(b)], [最大熵], [$N k_B ln 3$],
    [(c)], [最小能量], [$-N E$],
    [(d)], [配分函数], $[1 + 2 cosh(E / k_B T)]^N$,
    [(e)], [平均能量], $- 2 N E sinh(E / k_B T) / [1 + 2 cosh(E / k_B T)]$,
    [(f)], [$C(T)/T$ 的积分], [$N k_B ln 3$],
  )
]
