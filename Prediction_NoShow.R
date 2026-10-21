# ==============================================================================
# Analyzing Factors Influencing Event No-Shows using Binary Logistic Regression
# Data: Register_DB.csv (proprietary; not included in this repository)
# ==============================================================================

# --- Step 1: Packages ---
if(!require(caret)) install.packages("caret")         # confusion matrix
if(!require(car)) install.packages("car")             # GVIF, Wald tests
if(!require(pROC)) install.packages("pROC")           # ROC / AUC
if(!require(DescTools)) install.packages("DescTools") # pseudo R-squared

library(caret)
library(car)
library(pROC)
library(DescTools)

# --- Step 2: Import data ---
data=read.csv(file.choose(), head=TRUE)    # choose datalinear2.csv
attach(data)  			   # after we "attach" the data, we can use the variable name it directly when we employ the estimation codes
head(data) # check: STATUS, COUNTRY, TIME_ATTEND, COMPANYSIZE

# --- Step 3: Prepare variables ---
# JOB is one factor; glm() creates the six dummy variables automatically.
# Reference group = Technical Roles
data$JOB <- relevel(factor(data$JOB, ordered = FALSE), ref = "Technical Roles")

# --- Step 4: Binary logistic regression (STATUS: 1 = No-show, 0 = Attended) ---
logit_model <- glm(STATUS ~ COUNTRY + JOB + LEADTIME + TIME_ATTEND + COMPANYSIZE,
                   data = data,
                   family = binomial(link = "logit"))
print(summary(logit_model))
print(paste("Number of observations:", nobs(logit_model)))

# --- Step 5: Multicollinearity ---
# Use the GVIF^(1/(2*Df)) column; < 2.24 is equivalent to VIF < 5
print(vif(logit_model))

# --- Step 6: Wald tests ---
# Wald chi-square per coefficient = z^2
wald_chisq <- summary(logit_model)$coefficients[, "z value"]^2
print(round(wald_chisq, 3))
# Joint Wald test for JOB (df = 6)
print(Anova(logit_model, type = "III", test.statistic = "Wald"))

# --- Step 7: Odds ratios and 95% profile-likelihood CI ---
# (R >= 4.4; older versions need library(MASS) for profile-likelihood CI)
odds_ratio_table <- cbind(Odds_Ratio = exp(coef(logit_model)),
                          exp(confint(logit_model)))
print(odds_ratio_table)

# --- Step 8: Model fit (reported for context only) ---
print(paste("-2 Log Likelihood:", -2 * as.numeric(logLik(logit_model))))
print(PseudoR2(logit_model, which = c("CoxSnell", "Nagelkerke")))

# --- Step 9: Classification metrics (in-sample, 0.5 cut-off) ---
pred_prob    <- predict(logit_model, type = "response")
pred_class   <- factor(ifelse(pred_prob > 0.5, 1, 0), levels = c(0, 1))
actual_class <- factor(logit_model$y, levels = c(0, 1))

# positive = "1" so Sensitivity / Pos Pred Value refer to no-shows
# (caret prints Prediction in rows, Reference in columns)
print(confusionMatrix(pred_class, actual_class, positive = "1"))

roc_curve <- roc(actual_class, pred_prob)
plot(roc_curve, main = "ROC Curve - Event No-Shows (in-sample)", col = "blue", lwd = 2)
print(paste("AUC:", auc(roc_curve)))
