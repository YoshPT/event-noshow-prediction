# 📊 Analyzing Factors Influencing Registration No-Shows using Logistic Regression

**An exploratory study of the behavioral drivers of event no-shows**

![R](https://img.shields.io/badge/R-RStudio-276DC3?logo=r&logoColor=white)
![Model](https://img.shields.io/badge/Model-Binary%20Logistic%20Regression-blueviolet)
![AUC](https://img.shields.io/badge/AUC-0.70%20(in--sample)-orange)
![Data](https://img.shields.io/badge/Data-Proprietary%20(not%20published)-lightgrey)

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Technical Stack & Methodology](#-technical-stack--methodology)
- [Data Attributes](#-data-attributes)
- [Approach](#-approach)
- [Model Performance](#-model-performance)
- [Data Availability](#-data-availability)
- [How to Use the Script](#-how-to-use-the-script)
- [Limitations](#-limitations)

## 🎯 Project Overview

This is my **senior project in Economics**, completed during my **Data Analyst co-op internship** at a Thai event-industry company.

It applies **Logistic Regression**, an econometric approach, to identify the factors associated with event no-shows. The goal is to provide statistical evidence that can inform future features for event management platforms, such as **risk-based reminders**.

The findings and recommendations were documented in a written report for the co-op program.

## 🔧 Technical Stack & Methodology

| Area | Details |
|---|---|
| **Language** | R (RStudio) |
| **Model** | Binary Logistic Regression (target: no-show) |
| **Inference** | p-values, Wald Chi-Square, and odds ratios (Exp(B)) with 95% profile-likelihood confidence intervals |
| **Diagnostics** | Multicollinearity check using Generalized VIF (Job has six dummy variables), compared against the 2.24 threshold (equivalent to VIF < 5) |
| **Evaluation** | AUC, Nagelkerke R², and a confusion matrix at a 0.5 classification threshold (in-sample) |

## 📋 Data Attributes

### Variables and coding

| Column | Role | Coding |
|---|---|---|
| `STATUS` | 🎯 Target | `1` = No-show, `0` = Attended |
| `COUNTRY` | Predictor | `1` = Domestic (Thai), `0` = International |
| `JOB` | Predictor | 7 groups (see below) |
| `LEADTIME` | Predictor | Days between registration date and event date (Event Date − Registration Date) |
| `TIME_ATTEND` | Predictor | `1` = returning attendee (attended this event 2–3 times), `0` = first-time attendee |
| `COMPANYSIZE` | Predictor | `1` = more than 500 employees, `0` = 500 or fewer |

### Job dummy variables

`JOB` has 7 groups. In the report it is represented by six dummy variables. The reference group (all dummies = 0) is **Technical Roles**.

| Dummy | Job group |
|---|---|
| `Job1` | Consultant / Advisor |
| `Job2` | Executive / C-level |
| `Job3` | Marketing & Communications |
| `Job4` | Product Management |
| `Job5` | Purchasing / Procurement |
| `Job6` | Sales & Business Development |
| *(reference)* | Technical Roles |

## 🔍 Approach

1. **Define** the outcome (no-show vs. attended) and the explanatory variables listed above.
2. **Fit** a binary logistic regression and check multicollinearity with Generalized VIF.
3. **Interpret** coefficients as odds ratios with profile-likelihood confidence intervals.
4. **Evaluate** fit and discrimination in-sample, and treat the results as associations rather than causal effects.

## 📈 Model Performance

| Metric | Result |
|---|---|
| **AUC** (in-sample) | **0.70**, i.e., moderate ability to distinguish no-shows from attendees |

> [!NOTE]
> This is an in-sample figure. See [Limitations](#-limitations).

## 🔒 Data Availability

The dataset (event-registration records) is **proprietary to the company** where I completed my co-op internship.

- Records were anonymized before analysis.
- The raw data is **not published** in this repository.
- Detailed results (coefficients and odds ratios) are **not published** either, for the same reason.

The analysis code is in [`Prediction_NoShow.R`](Prediction_NoShow.R). It is shared to document the method. Since the dataset is not published, the script cannot be run as-is.

## 🚀 How to Use the Script

If you have your own data with the columns listed in [Data Attributes](#-data-attributes):

1. Open `Prediction_NoShow.R` in **RStudio**.
2. Run the script.
3. Select your **CSV file** when prompted.

## 🚧 Limitations

> [!WARNING]
> Please read these before drawing any practical conclusions from the results.

| Limitation | What it means |
|---|---|
| **In-sample evaluation** | Metrics, including the AUC above, were calculated on the data used to fit the model and may be optimistic. Validation on unseen data (e.g., a hold-out set or cross-validation) is needed before practical use. |
| **Association, not causation** | The data is observational, so the findings show statistical associations, not causal effects. |
| **Limited generalizability** | The model is based on registration records from a single event. Results may differ for other organizers or event types. |

---
*Developed as an senior project by Poomrat Thanapasee | Connect with me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/)*
