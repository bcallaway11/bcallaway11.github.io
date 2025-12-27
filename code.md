---
layout: single
title: Code
permalink: /code/
---

## Main Packages

These are the main packages that I have developed and actively maintain.

**1. R `did` Package** [[Website](http://bcallaway11.github.io/did/)][[CRAN](https://cran.r-project.org/web/packages/did/index.html)]

This package contains tools for computing average treatment effect parameters in a difference in differences framework with more than two periods and with variation in treatment timing; it is based on Callaway and Sant'Anna (2021).  The main parameters are group-time average treatment effects which are the average treatment effect for a particular group at a a particular time.  These can be aggregated into a fewer number of treatment effect parameters, and the package provides aggregations into overall average treatment effects, dynamic treatment effects (event studies), group-specific treatment effects, and calendar time-specific treatment effects, or combinations of these.  There are also functions for pre-testing the parallel trends assumption (the main assumption underlying DID), and plotting group-time average treatment effects and/or particular aggregations of interest.

**2. R `ife` Package** [[Github](https://github.com/bcallaway11/ife)]

The `ife` package contains code for estimating treatment effects in interactive fixed effects models with a small number of time periods.  Interactive fixed effects models allow for the "return" to unobserved heterogeneity (i.e., unit fixed effects) to change over time --- which is an important concern in many application in economics.  The package contains code from two of my projects: "Treatment Effects in Interactive Fixed Effects Models" (co-authored with Sonia Karami) and "Treatment Effects in Staggered Adoption Designs with Non-Parallel Trends" (co-authored with Emmanuel Tsyawo).

**3. R `ptetools` Package** [[Website](https://bcallaway11.github.io/ptetools)][[[CRAN](https://cran.r-project.org/web/packages/ptetools/index.html)]

The `ptetools` package serves as the backbone for many of my other projects.  It contains generic code for panel data causal inference and is useful for extending panel data methods to new settings.

**4. R `qte` Package** [[Website](http://bcallaway11.github.io/qte/)][[CRAN](https://cran.r-project.org/web/packages/qte/index.html)]

The R `qte` package provides many methods for estimating the Quantile Treatment Effect (QTE) or the Quantile Treatment Effect on the Treated (QTET). This package contains the code to implement the estimators of quantile treatment effects in difference in differences designs that we proposed in Callaway and Li (2019) and Callaway, Li, Oka (2018).  In addition, the package includes code for estimating the QTE and QTET under the assumption of selection on observables (Firpo, 2007), the QTET in the Changes in Changes model (Athey and Imbens, 2006), the QTET in the Quantile Difference in Differences model.

**5. R `contdid` Package** [[Website](http://bcallaway11.github.io/contdid)] [[CRAN](https://cran.r-project.org/web/packages/contdid/index.html)]

The `contdid` package contains code for estimating treatment effects in difference-in-differences designs with a continuous treatment.  It is based on my paper "Difference-in-Differences Designs with a Continuous Treatment" (co-authored with Pedro H.C. Sant'Anna and Andrew Goodman-Bacon).

**6. R `twfeweights` Package** [[Github](https://github.com/bcallaway11/twfeweights)]

The `twfeweights` computes (implicit) regression weights in TWFE regressions with multiple periods and specifications that include covariates.

**7. R `BMisc` Package** [[Website](http://bcallaway11.github.io/BMisc/)][[CRAN](https://cran.r-project.org/web/packages/BMisc/index.html)]

The `BMisc` package contains various functions that I have found useful in my research and in writing `R` packages.  In particular, it contains functions for working with panel data, distribution and quantile functions, working with formulas, and generating summary statistics.

## Utility Packages

Smaller packages that serve a specific purpose.

**1. R `revealEquations` Package** [[Github](https://github.com/bcallaway11/revealEquations)]

Code for revealing math line-by-line in Quarto or Xaringan presentations.

**2. `kotlarski` code** [[Github](https://github.com/bcallaway11/kotlarski)]

This is code for implementing Kotlarski's result (as in Li and Vuong (1998)) for estimating the distribution of a latent variable when repeated observations are available for that variable.

**3. R `ugametrics` Package** [[Github](https://github.com/bcallaway11/ugametrics)]

Contains code for my class, mainly code for regression adjustment estimation of treatment effects.

## Additional Packages

These are packages developed for specific projects. They are functional, but not as general purpose as the packages above, and I am not actively maintaining them.

**1. R `ppe` Package** [[Github](https://github.com/bcallaway11/ppe)]

The `ppe` package contains code for implementing the approaches suggested in "Policy Evaluation during a Pandemic" (co-authored with Tong Li).  In that paper, we suggest alternative approaches to policy evaluation during a pandemic (essentially conditioning on lagged outcomes) and recommend these over difference in differences approaches due to the possibly highly nonlinear nature of a pandemic.  This package contains code both for the case where the number of Covid-19 cases is the outcome of interest as well as code for when some other economic outcome is of interest but may itself depend on the number of Covid-19 cases.

*Note:* The functionality of this package has been merged into the `ptetools` package, but the examples from the original package are still available here.

**2. R `csabounds` Package**[[Website](https://bcallaway11.github.io/csabounds/)]

The `csabounds` package contains functions written for my project "Bounds on Distributional Treatment Effect Parameters using Panel Data with an Application on Job Displacement."  The main functions are `csa.bounds` which computes bounds on the distribution and quantile of the treatment effect and `attcpo` which computes the average treatment effect conditional on the previous outcome.

**3. R `ccfa` Package**[[Website](https://WeigeHuangEcon.github.io/ccfa/)] [[Github](https://github.com/WeigeHuangEcon/ccfa)]

The `ccfa` package contains functions for computing counterfactual distributions with a continuous treatment variable.  Weige Huang and I developed this package in conjunction with our project "Distributional Effects of a Continuous Treatment with an Application on Intergenerational Mobility."

**4. R `distreg` Package** [[Website](http://bcallaway11.github.io/distreg/)] [[Github](https://github.com/bcallaway11/distreg)]

The `distreg` package contains code for distribution regression.

**5. R `qrme` Package** [[Github](https://github.com/bcallaway11/qrme)]

The `qrme` package implements the approach to nonlinear models with measurement error proposed in "Distributional Effects with Two-Sided Measurement Error: An Application to Intergenerational Income Mobility" (co-authored with Tong Li, Irina Murtazashvili, and Emmanuel Tsyawo).  The package contains code for (i) quantile regression with measurement error and (ii) a variety of nonlinear models (particularly related to intergenerational mobility) with measurement error in both the outcome and a "treatment" variable.
