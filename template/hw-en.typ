#import "../lib.typ": *
#set text(lang: "en")

#show: hwk.with(title: [Thermodynamics and Statistical Mechanics --- Practice Set 1], author: "Student", course: none, hwk-id: 0, stu-id: 2024001)

#let sinh = math.sinh
#let cosh = math.cosh

#problem[
  A system consists of $N$ *distinguishable, independent particles* obeying *Boltzmann statistics*. Each particle can occupy one of three non-degenerate energy levels: $-E$, $0$, and $E$. The system is in thermal contact with a heat reservoir at temperature $T$.

  Define $beta = 1 / (k_B T)$. The single-particle partition function is:

  $ z = e^(beta E) + 1 + e^(- beta E) = 1 + 2 cosh(beta E) $

  The occupation probabilities for the three levels are:

  $ P(-E) = e^(beta E) / z, quad P(0) = 1 / z, quad P(E) = e^(- beta E) / z $

  #sub-problem[Find the entropy at $T = 0 "K"$.]
  #sub-problem[Find the maximum entropy.]
  #sub-problem[Find the minimum energy of the system.]
  #sub-problem[Find the total partition function $Z$ for the $N$-particle system.]
  #sub-problem[Find the average energy $chevron.l U chevron.r$ of the system.]
  #sub-problem[Evaluate the integral $ integral_0^infinity (C(T)) / T dif T $.]
]

#solution(show-title: false)[
  == (a) Entropy at $T = 0 "K"$

  As $T -> 0$, we have $beta -> infinity$, so $P(-E) -> 1$ and $P(0), P(E) -> 0$.

  Every particle occupies the ground state $-E$. There is only *one microstate* (all $N$ particles on $-E$), so:

  $ S = k_B ln 1 = boxed(0) $

  This is consistent with the *Third Law of Thermodynamics*.

  == (b) Maximum Entropy

  Maximum entropy corresponds to $T -> infinity$ ($beta -> 0$), where all three levels are *equally probable*.

  For $N$ distinguishable particles, a configuration with occupation numbers $(n_1, n_2, n_3)$ where $n_1 + n_2 + n_3 = N$ has a multiplicity:

  $ W = N! / (n_1 ! thin n_2 ! thin n_3 !) $

  $W$ is maximized when $n_1 = n_2 = n_3 = N / 3$. Using *Stirling's approximation* ($ln n! approx n ln n - n$):

  $ S_(max) &= k_B ln (N! / (N/3) !^3) \
    &approx k_B [N ln N - 3 dot N/3 dot ln(N/3)] \
    &= k_B N ln 3 $

  $ boxed(S_(max) = N k_B ln 3) $

  == (c) Minimum Energy

  The minimum energy occurs when *all* $N$ particles are in the lowest level $-E$:

  $ boxed(U_(min) = -N E) $

  == (d) Partition Function

  Since the $N$ particles are *distinguishable and independent*, the total partition function is:

  $ boxed(Z = z^N = [1 + 2 cosh(E / (k_B T))]^N) $

  == (e) Average Energy

  The average energy of a single particle:

  $ chevron.l epsilon chevron.r &= (-E) dot e^(beta E) / z + (0) dot 1 / z + (E) dot e^(- beta E) / z \
    &= E (e^(- beta E) - e^(beta E)) / z \
    &= - (2 E sinh(beta E)) / (1 + 2 cosh(beta E)) $

  For $N$ particles:

  $ boxed(chevron.l U chevron.r = - (2 N E sinh(E / (k_B T))) / (1 + 2 cosh(E / (k_B T)))) $

  == (f) Integral of $C(T)/T$

  We need to evaluate:

  $ integral_0^infinity (C(T)) / T dif T = ? $

  Since the energy levels are fixed (no volume degree of freedom), entropy depends only on temperature:

  $ dif S = (C(T)) / T dif T $

  Therefore, the integral equals the *total entropy change*:

  $ integral_0^infinity (C(T)) / T dif T = integral_0^infinity dif S = S(T = infinity) - S(T = 0) $

  Substituting results from parts (a) and (b):

  $ boxed(integral_0^infinity (C(T)) / T dif T = N k_B ln 3) $
]

== Summary of Results

#set text(size: 10.5pt)
#set table(stroke: 0.5pt, align: center, inset: 8pt)

#table(
  columns: 3,
  [*Part*], [*Quantity*], [*Result*],
  [(a)], [Entropy at $T = 0$], [$0$],
  [(b)], [Maximum entropy], [$N k_B ln 3$],
  [(c)], [Minimum energy], [$-N E$],
  [(d)], [Partition function], $[1 + 2 cosh(E / k_B T)]^N$,
  [(e)], [Average energy], $- 2 N E sinh(E / k_B T) / [1 + 2 cosh(E / k_B T)]$,
  [(f)], [Integral of $C(T)/T$], [$N k_B ln 3$],
)
