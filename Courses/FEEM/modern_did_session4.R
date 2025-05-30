## -----------------------------------------------------------------------------
library(did)
library(fixest)
library(modelsummary)
load("mw_data2.RData")

# create post treatment dummy
mw_data2$post <- 1*(mw_data2$year >= mw_data2$first.treat & mw_data2$first.treat > 0)

# run TWFE regression
twfe_x <- feols(lemp ~ post | countyreal + region^year,
                data=mw_data2)



## -----------------------------------------------------------------------------
modelsummary(twfe_x, gof_omit=".*")


## -----------------------------------------------------------------------------
cs_x <- att_gt(yname="lemp",
               tname="year",
               idname="countyreal",
               gname="first.treat",
               xformla=~region,
               data=mw_data2)
cs_x_res <- aggte(cs_x, type="group")


## -----------------------------------------------------------------------------
summary(cs_x_res)


## -----------------------------------------------------------------------------
# regression
cs_x_reg <- att_gt(yname="lemp",
               tname="year",
               idname="countyreal",
               gname="first.treat",
               xformla=~region + lpop,
               est_method = "reg",
               data=mw_data2)
cs_x0_reg <- aggte(cs_x_reg, type="group")


## -----------------------------------------------------------------------------
# propensity score weighting
cs_x_ipw <- att_gt(yname="lemp",
               tname="year",
               idname="countyreal",
               gname="first.treat",
               xformla=~region + lpop,
               est_method = "ipw",
               data=mw_data2)
cs_x0_ipw <- aggte(cs_x_ipw, type="group")


## -----------------------------------------------------------------------------
# doubly robust
cs_x_dr <- att_gt(yname="lemp",
               tname="year",
               idname="countyreal",
               gname="first.treat",
               xformla=~region + lpop,
               est_method = "dr",
               data=mw_data2)
cs_x0_dr <- aggte(cs_x_dr, type="group")


## -----------------------------------------------------------------------------
# show results
round(cbind.data.frame(reg=cs_x0_reg$overall.att, 
                       ipw=cs_x0_ipw$overall.att,
                       dr=cs_x0_dr$overall.att), 6)


## ---- fig.align="center", fig.width=10, fig.height=8, echo=FALSE--------------
cs_res <- att_gt(yname="lemp",
               tname="year",
               idname="countyreal",
               gname="first.treat",
               data=mw_data2)
ggdid(cs_res, ylim=c(-.2,.1))


## ---- echo=FALSE, cache=TRUE, fig.align="center", fig.width=14, fig.height=8, message=FALSE, warning=FALSE----
library(HonestDiD)
cs_es <- aggte(cs_res, type="dynamic")
# recover influence function for event study estimates
es_inf_func <- cs_es$inf.function$dynamic.inf.func.e

# recover variance-covariance matrix
n <- nrow(es_inf_func)
V <- t(es_inf_func) %*% es_inf_func / (n*n) 

eventplot <- ggdid(cs_es)

# edit below here

es.effects <- cs_es$att.egt

preperiod <- 4
postperiod <- 5

baseVec1 <- basisVector(index=1,size=postperiod)

RobustResultsPost1 <- createSensitivityResults_relativeMagnitudes(betahat = es.effects, sigma = V, 
                                                                  numPrePeriods = preperiod, 
                                                                  numPostPeriods = postperiod, 
                                                                  l_vec = baseVec1,
                                                                  Mbarvec = seq(from = 0, to = 2, by = 0.5),
                                                                  gridPoints = 100, grid.lb = -1, grid.ub = 1)

# plots

# first period post adoption
Orig1 <- constructOriginalCS(betahat = es.effects,
                             sigma = V, numPrePeriods = preperiod, numPostPeriods = postperiod,
                             l_vec = baseVec1)

SensPlot1 <- createSensitivityPlot_relativeMagnitudes(robustResults = RobustResultsPost1,
                                                      originalResults = Orig1)

# sensitivity plots for each post-adoption period
gridExtra::grid.arrange(eventplot,SensPlot1,ncol = 2)

