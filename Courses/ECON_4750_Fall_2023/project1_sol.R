## ----warn=FALSE, message=FALSE-----------------------
library(haven)
library(tidyverse)
library(glmnetUtils)
library(formula.tools)
library(BMisc)
library(kableExtra)

form1 <- SalePrice ~ as.factor(Neighborhood)
form2 <- SalePrice ~ GrLivArea
form3 <- SalePrice ~ as.factor(OverallQual)
form4 <- SalePrice ~ as.factor(Neighborhood) + LotArea + GrLivArea +
  YearBuilt
form5 <- SalePrice ~ as.factor(Neighborhood) + LotArea + GrLivArea +
  YearBuilt + as.factor(BldgType) + as.factor(LotShape) +
  as.factor(LandContour) + as.factor(LandSlope) 
form6 <- SalePrice ~ (as.factor(Neighborhood) + LotArea + GrLivArea +
                        YearBuilt)^2
form7 <- SalePrice ~ (as.factor(Neighborhood) + LotArea + GrLivArea +
                        YearBuilt)^3

# print formulas
form_list <- unlist(lapply(list(form1,form2,form3,form4,form5,form6,form7), function(form) as.character((form))))
model_names <- paste0("Model ", seq(1,7))
tab1 <- data.frame(model_names, form_list)
kbl(tab1, col.names=c("", "Formula")) %>%
  kable_styling("striped", full_width=T) %>%
  column_spec(1, width="1in")


## ---- cache=TRUE-------------------------------------
train <- read.csv("house_price_train.csv")

# assign folds for cross validation
set.seed(1234)
J <- 10
n <- nrow(train)
train$fold <- sample(1:J, size=n, replace=TRUE)

# function to compute model selection criteria
mod_sel <- function(form) {
  reg <- lm(form, data=train)
  r.squared <- summary(reg)$r.squared
  adj.r.squared <- summary(reg)$adj.r.squared
  uhat <- resid(reg)
  ssr <- sum(uhat^2)
  k <- length(coef(reg))
  n <- nrow(train)
  aic <- 2*k + n*log(ssr)
  bic <- log(n)*k + n*log(ssr)
  cv <- cross_val(form)
  c(r.squared, adj.r.squared, aic, bic, cv)
}

# function for cross validation
cross_val <- function(form) {
  Ypred <- rep(NA, n)
  for (j in 1:J) {
    cv_data <- subset(train, fold != j)
    cv_reg <- lm(form, data=cv_data)
    Ypred[train$fold==j] <- predict(cv_reg, newdata=subset(train, fold==j))
  }
  Y <- train$SalePrice
  cv <- sqrt(mean( (Y-Ypred)^2))
  cv
}


# report results for models 1-7
results <- suppressWarnings(as.data.frame(t(sapply(list(form1, form2, form3, form4, form5, form6,form7), mod_sel))))
colnames(results) <- c("r.squared", "adj.r.squared", "aic", "bic", "cv")

# improve formatting
results$aic <- results$aic/1000
results$bic <- results$bic/1000
results <- round(results, 2)
results$cv <- round(results$cv, digits=0)

# function for cross validation for lasso/ridge
cross_val_lr <- function(form, alpha) {
  Ypred <- rep(NA, n)
  for (j in 1:J) {
    cv_model <- cv.glmnet(form, alpha=alpha,
                          data=subset(train, fold!=j))
    Y_pred <- predict(cv_model, newdata=train)[train$fold==j]
    Ypred[train$fold==j] <- Y_pred
  }
  Y <- train$SalePrice
  cv <- sqrt( mean( (Y-Ypred)^2) )
  
  cv
}

# not returning r-squared, etc., but want to 
# put these in the same table.  This is just a 
# simple function to match the formatting from
# earlier
mod_sel_lr <- function(form, alpha=1) {
  cv <- cross_val_lr(form, alpha)
  c(NA, NA, NA, NA, cv)
}

# lasso
lasso_results <- as.data.frame(t(sapply(list(form5, form7), mod_sel_lr, alpha=1)))
colnames(lasso_results) <- c("r.squared", "adj.r.squared", "aic", "bic", "cv")

lasso_results$cv <- round(lasso_results$cv, 0)

# ridge
ridge_results <- as.data.frame(t(sapply(list(form5, form7), mod_sel_lr, alpha=0)))
colnames(ridge_results) <- c("r.squared", "adj.r.squared", "aic", "bic", "cv")

# improve formatting
ridge_results$cv <- round(ridge_results$cv, 0)

# all results
cnames <- c("Reg 1", "Reg 2", "Reg 3", "Reg 4", "Reg 5", "Reg 6", "Reg 7",
            "Lasso 5", "Lasso 7", 
            "Ridge 5", "Ridge 7")
train_results <- rbind.data.frame(results,
                                  lasso_results,
                                  ridge_results)
train_results[is.na(train_results)] <- ""
train_results[7,5] <- "much bigger"
print_df <- data.frame(model=cnames,train_results)
kbl(print_df) %>%
  kable_styling("striped", full_width=T)


## ----------------------------------------------------
# out of sample predictions
test <- read.csv("house_price_test.csv")
test$fold <- -99 # just match training data, used below

test_mse <- function(form) {
  train_reg <- lm(form, data=train)
  Y <- test$SalePrice
  Y_pred <- predict(train_reg, newdata=test)
  mse <- sqrt( mean( (Y-Y_pred)^2) )
  mse
}

test_mse_lr <- function(form, alpha=1) {
  cv_model <- cv.glmnet(form, alpha=alpha, data=train)
  n_test <- nrow(test)
  test_Y_pred <- predict(cv_model, newdata=rbind.data.frame(test,train))[1:n_test]
  test_Y <- test$SalePrice
  mse <- sqrt(mean( (test_Y - test_Y_pred)^2))
  mse
}


out_regs <- suppressWarnings(unlist(lapply(list(form1,form2,form3,form4,form5,form6,form7), test_mse)))
out_lassos <- unlist(lapply(list(form5, form7), test_mse_lr, alpha=1))
out_ridges <- unlist(lapply(list(form5, form7), test_mse_lr, alpha=0))

cnames <- c("Reg 1", "Reg 2", "Reg 3", "Reg 4", "Reg 5", "Reg 6", "Reg 7",
            "Lasso 5", "Lasso 7", 
            "Ridge 5", "Ridge 7")

out <- c(out_regs, out_lassos, out_ridges)
out_res <- cbind.data.frame(model=cnames, cv=round(out,0))
out_res <- out_res[order(out_res[,2]),]
out_res[length(cnames),2] <- "much bigger"
rownames(out_res) <- NULL
kbl(out_res) %>%
    kable_styling("striped", full_width=T)


## ---- warn=FALSE, message=FALSE----------------------
lasso_reg <- cv.glmnet(form5, data=train, alpha=1)
test_Y <- test$SalePrice
test_Y_pred <- predict(lasso_reg, newdata=test)
miss <- test_Y - test_Y_pred
absmiss <- abs(miss)/1000
plot_df <- data.frame(absmiss=absmiss)
ggplot(plot_df, aes(x=absmiss)) +
  geom_histogram() +
  theme_bw() +
  xlab("absolute value of prediction miss in thousands of $")
mad <- median(absmiss)
frac_close <- mean( 1*(absmiss < 10) )

