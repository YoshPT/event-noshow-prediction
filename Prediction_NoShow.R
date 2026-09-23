# ==============================================================================
# PROJECT: Predicting Event No-Shows using Logistic Regression
# ==============================================================================

# --- ขั้นตอนที่ 1: ติดตั้งและเรียกใช้ Library ---
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(caret)) install.packages("caret")      # สำหรับวัดผล Prediction (Accuracy)
if(!require(mfx)) install.packages("mfx")          # สำหรับหา Marginal Effects 
if(!require(car)) install.packages("car")          # สำหรับเช็ค VIF (Multicollinearity)
if(!require(pROC)) install.packages("pROC")        # สำหรับกราฟ ROC
if(!require(DescTools)) install.packages("DescTools") # สำหรับ Pseudo R-Squared
if(!require(fmsb)) install.packages("fmsb")

library(tidyverse)
library(caret)
library(mfx)
library(car)
library(pROC)
library(DescTools)
library(dplyr)
library(fmsb)

# --- ขั้นตอนที่ 2: นำเข้าข้อมูล (Import Data) ---
# แนะนำให้วางไฟล์ CSV ไว้ในโฟลเดอร์เดียวกับโค้ด R
data <- read.csv("Register_DB.csv", header=TRUE) 
attach(data)
head(data)

# --- ขั้นตอนที่ 3: เตรียมตัวแปร (Data Pre-processing) ---
# แปลงตัวแปรกลุ่ม (Categorical) เป็น Factor
JOB <- as.factor(JOB)

# --- ขั้นตอนที่ 4: กำหนดตัวแปรอ้างอิง (Reference Level) ---
data$JOB <- factor(data$JOB, ordered = FALSE)
data$JOB <- relevel(data$JOB, ref = "Technical Roles")

# --- ขั้นตอนที่ 5: สร้างโมเดลสมการการถดถอยโลจิสติก (Binary Logistic Regression) ---
logit_model <- glm(STATUS ~ COUNTRY + JOB + LEADTIME + TIME_ATTEND + COMPANYSIZE, 
                   data = data, 
                   family = binomial(link = "logit"))
summary(logit_model)

# --- ขั้นตอนที่ 6: ตรวจสอบปัญหาความสัมพันธ์เชิงซ้อน (Multicollinearity) ---
# ค่า VIF ควร < 5 ถึงจะถือว่าใช้งานได้
vif_values <- vif(logit_model)
print(vif_values)

# --- ขั้นตอนที่ 7: คำนวณค่า Odds Ratio และช่วงความเชื่อมั่น (Exp(B) & 95% CI) ---
# 1. ดึงค่า Coefficient (B) ออกมาแล้วทำการ Exponential
exp_b <- exp(coef(logit_model))

# 2. คำนวณช่วงความเชื่อมั่น 95% (95% CI) แล้ว Exponential
conf_int <- exp(confint(logit_model))

# 3. รวมผลลัพธ์เป็นตารางเดียวเพื่อให้ดูง่าย
odds_ratio_table <- cbind(Odds_Ratio = exp_b, conf_int)
print("--- Odds Ratio and 95% Confidence Interval ---")
print(odds_ratio_table)

# --- ขั้นตอนที่ 8: คำนวณค่า R-square สำหรับ Logistic Regression ---
minus_2ll <- -2 * logLik(logit_model)
print(paste("-2 Log Likelihood:", minus_2ll))

print("--- Pseudo R-Squared ---")
PseudoR2(logit_model, which = c("CoxSnell", "Nagelkerke"))
print(paste("Number of observations:", nobs(logit_model)))

# --- ขั้นตอนที่ 9: ทำนายผลและประเมินความแม่นยำของโมเดล (Model Evaluation) ---
# 1. ทำนายความน่าจะเป็น
pred_prob <- predict(logit_model, type = "response")

# 2. จัดกลุ่มผลลัพธ์ (Cut-off ที่ 0.5: >0.5 คือ No-show, <0.5 คือ Show)
pred_class <- ifelse(pred_prob > 0.5, 1, 0)
pred_class <- as.factor(pred_class)
actual_class <- as.factor(data$STATUS)

# 3. สร้าง Confusion Matrix ดูค่า Accuracy
print("--- Confusion Matrix and Accuracy ---")
confusionMatrix(pred_class, actual_class)

# 4. วาดกราฟ ROC Curve เพื่อดูประสิทธิภาพโมเดล
roc_curve <- roc(data$STATUS, pred_prob)
plot(roc_curve, main = "ROC Curve - Event No-Shows Prediction", col = "blue", lwd = 2)
print(paste("AUC (Area Under Curve):", auc(roc_curve)))