---
title: Controlling is Balancing.  Balancing is Controlling.
author: brant
date: '2026-10-30'
format:
  gfm:
    extensions:
      - tex_math_dollars
    variant: +yaml_metadata_block
    toc: false
categories:
  - Econometrics
  - Policy Evaluation
  - Unconfoundedness
comments: false
bibliography: refs.bib
math: mathjax
css: /assets/css/brant.css
permalink: /posts/controlling-is-balancing
post_type: informal
summary: >-
  Under unconfoundedness, comparing treated and untreated units with the same
  covariates and reweighting the two groups to have the same distribution of
  covariates are two ways of doing the same thing.
toc: true
toc_sticky: true
notation:
  - sym: $$p(x) := \P(D=1 \mid X=x)$$
    desc: propensity score
  - sym: $$\pi := \P(D=1)$$
    desc: fraction treated
  - sym: $$m_d(x) := \E[Y \mid X=x, D=d]$$
    desc: mean outcome in group $$d$$
  - sym: $$\delta(x) := m_1(x) - m_0(x)$$
    desc: conditional contrast
  - sym: $$\ATT(x)$$
    desc: $$\ATT$$ among units with covariates $$x$$
  - sym: $$\L(D \mid X)$$
    desc: linear projection of $$D$$ on $$X$$
---


## Introduction

In economics, we are very used to the idea of distinguishing between the
treatment and other variables that we want to *control for*. To fix
ideas, suppose we are interested in the effect of a binary treatment
variable, $$D$$, and want to control for a vector of covariates $$X$$.

When we say that we want to control for certain variables, we mean that
we would like to compare outcomes for units that are the same in terms
of those variables, while being different in terms of the treatment
variable. In other words, we want to report an average of the
*conditional contrasts*

$$\delta(x) := m_1(x) - m_0(x) = \E[Y \mid X=x, D=1] - \E[Y \mid X=x, D=0]$$

Many approaches to causal inference are based on making exactly this
kind of comparison, including matching (Heckman et al. 1997), regression
adjustment (where one estimates $$m_0(x)$$ and uses it to impute
untreated potential outcomes for treated units), and (at least to some
extent) regressions of the outcome on the treatment and covariates. And
I think it is the most natural way to think about what role we want
covariates to play in empirical applications.

Moreover, under the following unconfoundedness assumption

$$Y(0) \independent D \mid X$$

it follows that

$$\delta(x) = \ATT(x)$$

One more thing that is often under-emphasized in economics is that, for
$$\delta(x)$$ to be well defined, there need to be both treated and
untreated units with covariates $$x$$. That is, we need *overlap*,
$$0 < p(x) < 1$$. Without it, it’s infeasible to compare treated and
untreated units with the same covariates.

### Covariate Balancing

The other paradigm for using covariates in empirical work is based on
*balancing*. Balancing is less common in economics, and, for me, a bit
harder to think about.

Rather than explicitly making comparisons within values of $$X$$, the
idea is to reweight the groups so that they have the same distribution
of covariates and then compare (weighted) mean outcomes. This is the
language of the propensity score reweighting literature (Hirano et al.
2003), as well as of methods like entropy balancing (Hainmueller 2012)
and the covariate balancing propensity score (Imai and Ratkovic 2014).

### Connecting Controlling and Balancing

It’s not immediately clear what “controlling” and “balancing” have to do
with each other. We will explore this below. I’ll start with the case
where the target parameter is the $$\ATT$$ and then generalize.

## Case 1: ATT

Suppose that we are interested in the average treatment effect on the
treated, $$\ATT := \E[Y(1) - Y(0) \mid D=1]$$. By the law of iterated
expectations and unconfoundedness, it immediately follows that

$$\ATT = \E[\ATT(X) \mid D=1] = \E[\delta(X) \mid D=1]$$

In other words, the $$\ATT$$ is the average of the conditional contrasts
over the distribution of covariates for the treated group.

### Controlling is Balancing

Famously, the $$\ATT$$ can also be written in terms of propensity score
weights (Rosenbaum and Rubin 1983; Imbens and Wooldridge 2009). To see
this, split $$\E[\delta(X) \mid D=1]$$ into two terms,

$$\E[\delta(X) \mid D=1] = \E[Y \mid D=1] - \E[m_0(X) \mid D=1]$$

and then change the distribution that the second term averages over,

$$\begin{aligned}
\E[m_0(X) \mid D=1] &= \E[w_0(X) m_0(X) \mid D=0] \\
&= \E[w_0(X) Y \mid D=0]
\end{aligned}$$

where

$$w_0(x) := \frac{f_1(x)}{f_0(x)} = \frac{p(x)}{1-p(x)} \frac{1-\pi}{\pi}$$

The first equality reweights the untreated group’s distribution of
covariates to match the treated group’s (the second expression for the
weights comes from Bayes’ rule). The second equality uses the law of
iterated expectations, which works here because the weights only depend
on $$X$$. Putting these together,

$$\ATT = \E[Y \mid D=1] - \E[w_0(X) Y \mid D=0]$$

A key property of the weights $$w_0(x)$$ is that they balance the
distribution of covariates. For any function $$g$$,

$$\E[w_0(X) g(X) \mid D=0] = \E[g(X) \mid D=1]$$

so that, after reweighting, the untreated group has the same
distribution of covariates as the treated group.

This is the sense in which controlling is balancing. Targeting the
$$\ATT$$ by controlling for $$X$$ is *the same* as reweighting the
untreated group so that its distribution of covariates matches the
treated group and then comparing means.

### Balancing is Controlling

Now let’s go in the other direction. Suppose that we have some weights
$$\tilde{w}_0(X)$$ for the untreated group that balance the distribution
of covariates, so that

$$\E[\tilde{w}_0(X) g(X) \mid D=0] = \E[g(X) \mid D=1] \quad \text{for all functions } g$$

Then the difference between the mean outcome for the treated group and
the weighted mean outcome for the untreated group is

$$\begin{aligned}
\E[Y \mid D=1] - \E[\tilde{w}_0(X) Y \mid D=0] &= \E[Y \mid D=1] - \E[\tilde{w}_0(X) m_0(X) \mid D=0] \\
&= \E[Y \mid D=1] - \E[m_0(X) \mid D=1] \\
&= \E[\delta(X) \mid D=1] \\
&= \ATT
\end{aligned}$$

where the first equality holds by the law of iterated expectations, the
second holds by the balancing property (with $$g = m_0$$), the third
holds by the definition of $$\delta(x)$$, and the last holds by
unconfoundedness.

Thus, balancing delivers exactly the “controlling for” expression from
above.[^1] In other words, if we can balance the distribution of the
covariates to be the same for the untreated group as it is for the
treated group, then we can recover the $$\ATT$$ without ever explicitly
controlling for $$X$$.

## Case 2: More General Target Parameters

The results above are all well known, and they are what rationalize
balancing approaches like propensity score reweighting. But they do not
say much about the estimators that are most common in economics, in
particular regressions like

$$Y_i = \alpha D_i + X_i'\beta + e_i$$

Except in special cases, $$\alpha$$ is not the $$\ATT$$. However, under
some conditions and allowing for treatment effect heterogeneity,
$$\alpha$$ is a weighted average of the $$\delta(x)$$’s with weights
that differ from the ones that deliver the $$\ATT$$. For example, when
the covariates are discrete and the regression is saturated in them,
$$\alpha = \E[\omega(X) \delta(X)]$$ with
$$\omega(x) \propto p(x)(1-p(x))$$ (Angrist 1998).

Thus, the questions for this section are whether controlling is still
balancing, and whether balancing still delivers a “controlling for”
parameter.

Along these lines, consider any target parameter of the form

$$\theta_\omega := \E[\omega(X) \delta(X)]$$

where $$\omega(x) \geq 0$$ and $$\E[\omega(X)] = 1$$. $$\theta_\omega$$
is harder to interpret than the $$\ATT$$, but it still has some merit as
a causal parameter because it is a weighted average of the conditional
contrasts $$\delta(x)$$. In other words, it is a weighted average where
we “control for” $$X$$.

### Controlling is Balancing

Following the same steps as for the $$\ATT$$, we can write
$$\theta_\omega$$ as a difference in weighted means,

$$\theta_\omega = \E[w_1(X) Y \mid D=1] - \E[w_0(X) Y \mid D=0]$$

where

$$w_1(x) := \omega(x) \frac{\pi}{p(x)} \quad \text{and} \quad w_0(x) := \omega(x) \frac{1-\pi}{1-p(x)}$$

which are well defined because of overlap. These weights have three
properties.

1.  They are non-negative.

2.  They have mean one within each group,
    $$\E[w_1(X) \mid D=1] = \E[w_0(X) \mid D=0] = 1$$.

3.  They balance the two groups to a common distribution of covariates.
    For any function $$g$$,

    $$\E[w_1(X) g(X) \mid D=1] = \E[\omega(X) g(X)] = \E[w_0(X) g(X) \mid D=0]$$

The third property says that, even if we are willing to settle for a
parameter like $$\theta_\omega$$, controlling for $$X$$ still amounts to
balancing the covariates. After reweighting, both groups have the
distribution of covariates whose density is $$\omega(x) f(x)$$.[^2]

### Balancing is Controlling

Conversely, consider any weights $$w_1(X)$$ and $$w_0(X)$$ that are
non-negative, have mean one in the treated group, and balance the two
groups to some common distribution of covariates,

$$\E[w_1(X) g(X) \mid D=1] = \E[w_0(X) g(X) \mid D=0] \quad \text{for all functions } g$$

Then,

$$\begin{aligned}
& \E[w_1(X) Y \mid D=1] - \E[w_0(X) Y \mid D=0] \\
& \quad = \E[w_1(X) m_1(X) \mid D=1] - \E[w_0(X) m_0(X) \mid D=0] \\
& \quad = \E[w_1(X) m_1(X) \mid D=1] - \E[w_1(X) m_0(X) \mid D=1] \\
& \quad = \E[w_1(X) \delta(X) \mid D=1]
\end{aligned}$$

where the second equality uses the balancing property with $$g = m_0$$.
Since the weights are non-negative and have mean one, this is a weighted
average of the conditional contrasts. In fact, it is exactly
$$\theta_\omega$$ with $$\omega(x) = w_1(x) p(x) / \pi$$.

This shows that, just as for the $$\ATT$$, when we compare weighted
means of the treated and untreated groups, balancing the covariates (to
any common distribution) implies that we are implicitly controlling for
$$X$$.

### Does “Not Balancing” Imply “Not Controlling”?

The final question is whether a set of weights that does not balance the
distribution of covariates could still be “controlling for” $$X$$.

The answer is no. Consider any weights $$w_1(X)$$ and $$w_0(X)$$. By the
law of iterated expectations,

$$\begin{aligned}
& \E[w_1(X) Y \mid D=1] - \E[w_0(X) Y \mid D=0] \\
& \quad = \E[w_1(X) m_1(X) \mid D=1] - \E[w_0(X) m_0(X) \mid D=0]
\end{aligned}$$

For this to be a “controlling for” parameter, it needs to be equal to
$$\theta_\omega$$ for some $$\omega$$, and it needs to be equal to it
whatever $$m_1(x)$$ and $$m_0(x)$$ happen to be (unconfoundedness does
not restrict them). Since this has to hold for every $$m_1$$ and
$$m_0$$, it has to hold separately for the treated and untreated terms,
so that

$$\E[w_1(X) m_1(X) \mid D=1] = \E[\omega(X) m_1(X)] \quad \text{for all functions } m_1$$

and

$$\E[w_0(X) m_0(X) \mid D=0] = \E[\omega(X) m_0(X)] \quad \text{for all functions } m_0$$

The first condition says that reweighting the treated group by $$w_1$$
gives it the distribution of covariates with density $$\omega(x) f(x)$$,
and the second condition says the same thing for the untreated group
reweighted by $$w_0$$. Together, they say that

$$\E[w_1(X) g(X) \mid D=1] = \E[w_0(X) g(X) \mid D=0] \quad \text{for all functions } g$$

which is exactly the balancing condition.

In other words, without balance there is no “controlling for”.[^3]

## Implications

The discussion above shows the equivalence between controlling for and
balancing covariates. This is interesting to me, but I think there are
also some important implications, and it is related to some of my
ongoing research.

For many estimators that involve modeling the outcome (e.g., a
regression), it is possible to reformulate them as a weighting
estimator. The discussion above highlights that we could potentially
assess how well they control for covariates by exploring how well they
balance covariates. There are several papers that do this in the
cross-sectional setting (e.g., Chattopadhyay and Zubizarreta 2023), and
I will explore this in my next post. This is also exactly the type of
approach that we take in Caetano and Callaway (2026), where we consider
how well different estimators for difference-in-differences (TWFE
regressions, Callaway and Sant’Anna (2021), and imputation estimators as
in Borusyak et al. (2024)) control for time-varying covariates by
assessing how well they balance the covariates.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-angrist-1998" class="csl-entry">

Angrist, Joshua. 1998. “Estimating the Labor Market Impact of Voluntary
Military Service Using Social Security Data on Military Applicants.”
*Econometrica* 66 (2): 249–88.

</div>

<div id="ref-borusyak-jaravel-spiess-2024" class="csl-entry">

Borusyak, Kirill, Xavier Jaravel, and Jann Spiess. 2024. “Revisiting
Event-Study Designs: Robust and Efficient Estimation.” *Review of
Economic Studies*, rdae007.

</div>

<div id="ref-caetano-callaway-2026" class="csl-entry">

Caetano, Carolina, and Brantly Callaway. 2026.
“Difference-in-Differences When Parallel Trends Holds Conditional on
Covariates.” Unpublished manuscript.

</div>

<div id="ref-callaway-santanna-2021" class="csl-entry">

Callaway, Brantly, and Pedro HC Sant’Anna. 2021.
“Difference-in-Differences with Multiple Time Periods.” *Journal of
Econometrics* 225 (2): 200–230.

</div>

<div id="ref-chattopadhyay-zubizarreta-2023" class="csl-entry">

Chattopadhyay, Ambarish, and José R Zubizarreta. 2023. “On the Implied
Weights of Linear Regression for Causal Inference.” *Biometrika* 110
(3): 615–29.

</div>

<div id="ref-hainmueller-2012" class="csl-entry">

Hainmueller, Jens. 2012. “Entropy Balancing for Causal Effects: A
Multivariate Reweighting Method to Produce Balanced Samples in
Observational Studies.” *Political Analysis*, 25–46.

</div>

<div id="ref-heckman-ichimura-todd-1997" class="csl-entry">

Heckman, James, Hidehiko Ichimura, and Petra Todd. 1997. “Matching as an
Econometric Evaluation Estimator: Evidence from Evaluating a Job
Training Programme.” *The Review of Economic Studies* 64 (4): 605–54.

</div>

<div id="ref-hirano-imbens-ridder-2003" class="csl-entry">

Hirano, Keisuke, Guido Imbens, and Geert Ridder. 2003. “Efficient
Estimation of Average Treatment Effects Using the Estimated Propensity
Score.” *Econometrica* 71 (4): 1161–89.

</div>

<div id="ref-imai-ratkovic-2014" class="csl-entry">

Imai, Kosuke, and Marc Ratkovic. 2014. “Covariate Balancing Propensity
Score.” *Journal of the Royal Statistical Society: Series B (Statistical
Methodology)* 76 (1): 243–63.

</div>

<div id="ref-imbens-wooldridge-2009" class="csl-entry">

Imbens, Guido, and Jeffrey Wooldridge. 2009. “Recent Developments in the
Econometrics of Program Evaluation.” *Journal of Economic Literature* 47
(1): 5–86.

</div>

<div id="ref-rosenbaum-rubin-1983" class="csl-entry">

Rosenbaum, Paul, and Donald Rubin. 1983. “The Central Role of the
Propensity Score in Observational Studies for Causal Effects.”
*Biometrika* 70 (1): 41–55.

</div>

</div>

## Citation

> <pre>
> @online{callaway-controlling-balancing-2026,
>   author       = {Callaway, Brantly},
>   title        = {Controlling is Balancing. Balancing is Controlling.},
>   year         = {2026},
>   month        = {10},
>   url          = {https://bcallaway11.github.io/posts/controlling-is-balancing},
>   urldate      = {\today},
> }
> </pre>

[^1]: Strictly speaking, this direction already follows from the
    previous one. Taking $$g$$ to be indicator functions in the
    balancing condition implies that $$\tilde{w}_0(x) f_0(x) = f_1(x)$$,
    so the only weights that balance the entire distribution of
    covariates are the propensity score weights $$w_0(x)$$. The direct
    argument is still useful, though, because it only uses the balancing
    property and not the particular form of the weights, and that is the
    argument that generalizes below.

[^2]: Relative to the $$\ATT$$, the difference is that both groups are
    balanced to the distribution of covariates with density
    $$\omega(x) f(x)$$ (the population distribution of covariates
    reweighted by $$\omega$$) rather than to the distribution of
    covariates for the treated group. For the $$\ATT$$,
    $$\omega(x) = p(x)/\pi$$, so $$\omega(x) f(x) = f_1(x)$$ and
    $$w_1(x) = 1$$, which is why only the untreated group needed to be
    reweighted. For the saturated regression above, the target
    distribution has density proportional to $$p(x)(1-p(x)) f(x)$$,
    which puts the most weight on values of the covariates where treated
    and untreated units are both common.

[^3]: This does not mean that an estimator that does not balance the
    covariates can never give the right answer. A regression could still
    work in a particular application, for example if $$m_0(x)$$ is
    linear in $$x$$ and treatment effects do not vary across $$x$$. But
    it would get there by extrapolation, which is not the notion of
    “controlling for” that we started with. It is not doing the thing
    that we wanted it to do originally, and instead relies on functional
    form assumptions that are generally not the type of assumptions that
    we want to make.
