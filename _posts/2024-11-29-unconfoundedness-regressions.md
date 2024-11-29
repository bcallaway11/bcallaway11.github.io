---
title: "Interpreting Regressions under the Assumption of Unconfoundedness"
author: "brant"
date: '2024-11-29'
categories:
  - Econometrics
  - Policy Evaluation
  - Unconfoundedness
comments: true
layout: single
math: mathjax
permalink: /posts/unconfoundedness-regressions
---

# Interpreting Regressions under the Assumption of Unconfoundedness

$$\newcommand{\E}{\mathbb{E}}
\newcommand{\indicator}[1]{ \mathbf{1}\{#1\} }
\newcommand{\L}{\mathrm{L}}
\renewcommand{\P}{\mathrm{P}}
\newcommand{\independent}{{\perp\!\!\!\perp}}$$

<div class="citation">

<span class="citation">Citation:</span>

<pre>
@online{callaway-unconfoundedness-regressions-2024,
  author       = {Callaway, Brantly},
  title        = {Interpreting Regressions under the Assumption of Unconfoundedness},
  year         = {2024},
  month        = {11},
  url          = {https://bcallaway11.github.io/posts/unconfoundedness-regressions},
  urldate      = {\today},
}
</pre>

</div>

<div class="notation">

<span class="notation">Notation:</span>

- $ATT(X) := \E[Y(1) - Y(0) | X]$ - the $$ATT$$ for a given value of the
  covariates $X$.

- $\L(D|X)$ - a (possibly misspecified) linear probability model for the
  propensity score. The notation stands for the linear projection of $D$
  on $X$.

- $\L_0(Y|X)$ - a (possibly misspecified) linear model for
  $\E[Y|X,D=0]$.

</div>

I have been working recently on a project that is partially about how to
interpret TWFE regressions that include covariates: Caetano and Callaway
(2023). That project builds on a fairly large literature on interpreting
cross-sectional regressions under the assumption of unconfoundedness.
There are a number of interesting papers that take on this question from
different perspectives: Angrist (1998), Aronow and Samii (2016),
Słoczyński (2022), Chattopadhyay and Zubizarreta (2023), Blandhol et al.
(2022), Hahn (2023). This is my attempt to summarize some of the key
insights from these papers.

I’ll set this up in a way that targets the $ATT$ (rather than $ATE$),
but I think you could make analogous arguments if you were targeting the
$ATE$ instead. Let’s suppose that we have cross sectional data and that
we assume unconfoundedness. That is, $$Y_(0) \independent D | X$$ and
consider what happens when we try to estimate causal effects of the
treatment using the following regression:
$$Y_i = \alpha D_i + X_i'\beta + e_i$$ There are a couple of different
ways we could view this regression.

<span class="alert">View \#1:</span> The regression model is correctly
specified in the sense that $$\E[Y|X,D] = \alpha D + X'\beta$$. In this
case, $\alpha=ATT$, and you can just run the regression and interpret
the coefficient on $D$ as the $ATT$.

My sense is that this is not the view of most modern empirical work,
where it seems uncommon to take linearity as a key assumption. And, for
example, if the model is correctly specified, it would rule out certain
forms of systematic treatment effect heterogeneity. In particular,
notice that, for any value of the covariates $X$,
$ATT(X) = \E[Y|X,D=1] - \E[Y|X,D=0] = \alpha$. That is, average
treatment effects do not vary with $X$. This type of strong auxiliary
assumption/condition is what much recent work in econometrics has tried
to avoid and is probably implausible in most applications.

<span class="alert">View \#2:</span> The regression model is a linear
approximation to a possibly more complicated, nonlinear conditional
expectation. This view allows for systematic treatment effect
heterogeneity, i.e., that $ATT(X)$ can vary across different values of
$X$. However, this setting begs the question: how exactly should we
interpret $\alpha$?

This is the question that the papers mentioned above have tried to
answer. To proceed, let’s start with a decomposition of $\alpha$:
$$ \alpha = \underbrace{\E\Big[w_1(X) ATT(X) \Big| G=1\Big]}_{\textrm{weighted avg. of $ATT(X)$}} + \underbrace{\E\Big[w_1(X)\Big(\E[Y|X,G=0] - \L_0(Y|X)\Big) \Big| G=1\Big]}_{\textrm{misspecification bias}} $$
where
$$ w_1(X) := \frac{\big(1-\L(D|X)\big) \pi}{\E\big[(D-\L(D|X))^2\big]}~~~~\textrm{and}~~~~w_0(X) := \frac{\L(D|X)(1-\pi)}{\E\big[(D-\L(D|X))^2\big]} $$
Let’s start with the <span class="alert-blue">weights</span> $w_1(X)$
and $w_0(X)$. First, the weights are functions of $X$ and have mean 1
(this may not be obvious from the expression, but it turns out that it
is easy to show, mainly by using the law of iterated expectations on the
demoninator). Second, notice that it’s possible that these weights can
be negative, given that $\L(D|X)$, a linear probability model, is not
constrained to be between 0 and 1. Third, it’s easy to calculate the
sample analog of the weights as the most complicated term is a linear
projection, which we can directly estimate by running a regresson of $D$
on $X$ and recovering predicted values.

Next, let’s look at the <span class="alert-blue">misspecification
bias</span> term. Ideally, we would like this term to be equal to 0. And
there are two cases where it will be:

1.  The conditional expectation of $Y$ given $X$ and $D=0$ really is
    linear, i.e., $\E[Y|X,D=0] = \L_0(Y|X)$.

2.  The implicit regression weights, $w_1(X)$ and $w_0(X)$ are balancing
    weights in the sense that
    $\E[w_1(X) g(X) | D=1] = \E[w_0(X) g(X) | D=0]$ for any function
    $g$.

Since the first condition is kind of obvious, let’s focus on the second
one. One case where this condition is guaranteed to hold is when the
propensity score is linear, i.e., $p(D=1|X) = \L(D|X)$. For example, one
way that you can get rid of this misspecification bias term (as in
Angrist (1998)) is when all the covariates are discrete and the model is
fully saturated in the covariates; then linearity of the propensity
score holds by construction.

Even if neither of the conditions above hold, it seems to me that, in
typical applications, you would expect both conditions to be fairly
close to holding. For condition 1, of course it does not have to be the
case that $\E[Y|X,D=0]$ but linear models are the leading functional
form assumption here and also have good approximation properties. For
condition 2, even absent assuming that the propensity score is linear
(which seems like a strong/unnatural assumption to me), the weights
$w_1(X)$ and $w_0(X)$ do have some covariate balancing properties: they
balance the means of the covariates that are included in the model. That
is, you can show that they satistfy the property
$\E[w_1(X) X | D=1] = \E[w_0(X) X | D=0]$. This is not quite strong
enough to guarantee that the misspecification bias term is 0—we would
need the weights to balance the entire distribution of $X$ (and they are
not guaranteed to do that). But it does suggest that they are doing
something in “the same ballpark” of what we need to eliminate the
misspecification bias term.

The previous argument is heuristic, but, taking the two arguments above
together, it suggests to me to that the misspecification bias term is
probably small in most applications.

Finally, let us move to the <span class="alert-blue">weighted average of
$ATT(X)$</span> term. If the main target of our analysis is $ATT$, then
the ideal weights would be $w(X)=1$, so that $\alpha = ATT$. The weights
$w_1(X)$ are not equal to 1 and, relative to this baseline, have some
drawbacks. First, as discussed above, the weights can be negative. This
means that, for certain values of the covariates, the contribution of
$ATT(X)$ to $\alpha$ can have the wrong sign (this case can be ruled out
in some situations, by assuming that the propensity score is linear, and
also it is possible to directly calculate the weights and check if they
are negative). Second, the weighted average provided here is connected
to what Słoczyński (2022) call “weight reversal”. In particular, the
magnitude of the weights depends on the value of $(1-\L(D|X))$ for
treated units (the other terms basically serve as normalizations so that
the weights have mean 1). Relative to the baseline of 1, the weights
will tend to be too large for values $X$ that are predicted to have a
low probability of being treated (where the prediction comes from a
linearity probability model) and too small for values of $X$ that are
predicted to have a high probability of being treated.

How much does this matter? Well, it depends crucially on how much
treatment effect heterogeneity there is. If $ATT(X)$ is constant across
$X$, then any weighted average of $ATT(X)$ will be equal to $ATT$. At
the opposite extreme, if $ATT(X)$ varies a lot across $X$, then the
weights will matter a lot.

# References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-angrist-1998" class="csl-entry">

Angrist, Joshua D. 1998. “Estimating the Labor Market Impact of
Voluntary Military Service Using Social Security Data on Military
Applicants.” *Econometrica* 66 (2): 249–88.

</div>

<div id="ref-aronow-samii-2016" class="csl-entry">

Aronow, Peter M, and Cyrus Samii. 2016. “Does Regression Produce
Representative Estimates of Causal Effects?” *American Journal of
Political Science* 60 (1): 250–67.

</div>

<div id="ref-blandhol-bonney-mogstad-torgovitsky-2022"
class="csl-entry">

Blandhol, Christine, John Bonney, Magne Mogstad, and Alexander
Torgovitsky. 2022. “When Is TSLS Actually Late?”

</div>

<div id="ref-caetano-callaway-2023" class="csl-entry">

Caetano, Carolina, and Brantly Callaway. 2023.
“Difference-in-Differences When Parallel Trends Holds Conditional on
Covariates.”

</div>

<div id="ref-chattopadhyay-zubizarreta-2023" class="csl-entry">

Chattopadhyay, Ambarish, and José R Zubizarreta. 2023. “On the Implied
Weights of Linear Regression for Causal Inference.” *Biometrika* 110
(3): 615–29.

</div>

<div id="ref-hahn-2023" class="csl-entry">

Hahn, Jinyong. 2023. “Properties of Least Squares Estimator in
Estimation of Average Treatment Effects.” *SERIEs* 14 (3): 301–13.

</div>

<div id="ref-sloczynski-2022" class="csl-entry">

Słoczyński, Tymon. 2022. “Interpreting OLS Estimands When Treatment
Effects Are Heterogeneous: Smaller Groups Get Larger Weights.” *The
Review of Economics and Statistics* 104 (3): 501--509.

</div>

</div>
