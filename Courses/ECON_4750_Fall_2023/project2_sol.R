# comparison of means using observational data
library(modelsummary)
library(haven)
library(tidyverse)
jtrain_obs <- read_dta("jtrain_observational.dta")
modelsummary(lm(re78 ~ train, data=jtrain_obs), 
             gof_map=c("nobs", "r.squared"))


# summary statistics
jtrain_obs$train_factor <- as.factor(ifelse(jtrain_obs$train==1, "train", "non-train"))
datasummary_balance(~ train_factor, 
                    data=select(jtrain_obs, train_factor, re78, re75, re74, unem75, unem74, age, educ, black, hisp, married),
                    title="Job Training Summary Statistics",
                    fmt=fmt_decimal(digits=2))


# different models for part 1
reg1 <- lm(I(re78-re75) ~ train + unem75 + unem74 + age + educ + black + hisp + married, data=jtrain_obs)
reg2 <- lm(re78 ~ train + re75 + re74 + unem75 + unem74 + age + educ + black + hisp + married, data=jtrain_obs)
reg3 <- lm(I(re78-re75) ~ train, data=jtrain_obs)
reg4 <- lm(re78 ~ train + age + educ + black + hisp + married, data=jtrain_obs)
modelsummary(list(reg1,reg2,reg3,reg4), gof_map=NA)


# results using experimental data
jtrain_exp <- read_dta("jtrain_experimental.dta")
exp_reg <- lm(re78 ~ train, data=jtrain_exp)
modelsummary(exp_reg, gof_map=c("nobs"))

