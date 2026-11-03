# 📊 Analyzing Factors Influencing Registration No-Shows using Logistic Regression

**An exploratory study of the behavioral drivers of event no-shows**

## 🎯 Project Overview
This is my senior project in Economics, completed during my Data Analyst co-op internship at a Thai event-industry company. It applies Logistic Regression, an econometric approach, to identify the factors associated with event no-shows. The goal is to provide statistical evidence that can inform future features for event management platforms, such as risk-based reminders. The findings and recommendations were documented in a written report for the co-op program.

> 📌 **Scope of this repository:** it shows the methodology and the code. The data and the study's results are intentionally **not published** here.

## 🛠️ Technical Stack & Methodology
* **Language:** R (RStudio)
* **Model:** Binary Logistic Regression (target: no-show)
* **Inference:** p-values, Wald Chi-Square, and odds ratios (Exp(B)) with 95% profile-likelihood confidence intervals
* **Diagnostics:** Multicollinearity check using Generalized VIF (Job has six dummy variables), compared against the 2.24 threshold (equivalent to VIF < 5)
* **Evaluation:** AUC, Nagelkerke R², and a confusion matrix at a 0.5 classification threshold (in-sample)

## 🔒 Data Availability & Privacy Note
The dataset (event-registration records) is **proprietary to the company** where I completed my co-op internship. Records were anonymized before analysis, and the raw data is **not published** in this repository. For the same reason, the study's results are not published here.

To make the method verifiable without the raw data, this repo provides:

* the **data dictionary** below, describing every variable and its coding
* the **R analysis code**
* a **synthetic dataset generator** (`R/generate_synthetic_data.R`) with the same structure, so the code can be run end-to-end

Questions about the project? Contact me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/).

## 📋 Data Attributes
Variables and their coding (column names used in the code, with the names used in the written report):

| Column | Name in report | Coding |
|---|---|---|
| `STATUS` (target) | Status | 1 = No-show, 0 = Attended |
| `COUNTRY` | Country | 1 = Domestic (Thai), 0 = International |
| `JOB` | Job1–Job6 | 7 groups. In the report, six dummy variables: Job1 = Consultant / Advisor, Job2 = Executive / C-level, Job3 = Marketing & Communications, Job4 = Product Management, Job5 = Purchasing / Procurement, Job6 = Sales & Business Development. Reference group (all dummies = 0): Technical Roles |
| `LEADTIME` | Lead Time | Days between registration date and event date (Event Date − Registration Date) |
| `TIME_ATTEND` | Time (past attendance) | 1 = returning attendee (attended this event 2-3 times), 0 = first-time attendee |
| `COMPANYSIZE` | Company Size | 1 = more than 500 employees, 0 = 500 or fewer |

## 🔍 Approach
1. Define the outcome (no-show vs. attended) and the explanatory variables listed above.
2. Fit a binary logistic regression and check multicollinearity with Generalized VIF.
3. Interpret coefficients as odds ratios with profile-likelihood confidence intervals.
4. Evaluate fit and discrimination in-sample, and treat the results as associations rather than causal effects.

## ⚠️ Limitations
* **In-sample evaluation:** Metrics were calculated on the data used to fit the model and may be optimistic. Validation on unseen data (e.g., a hold-out set or cross-validation) is needed before practical use.
* **Association, not causation:** The data is observational, so the findings show statistical associations, not causal effects.
* **Limited generalizability:** The model is based on registration records from a single event. Results may differ for other organizers or event types.

## ▶️ Reproducing the Analysis
The real data cannot be shared, so this repo includes a synthetic dataset generator with the same structure. In RStudio, set the working directory to the repo root and run:

```r
source("R/generate_synthetic_data.R")   # creates data/synthetic_registrations.csv
source("Prediction_NoShow.R")           # full analysis pipeline on the synthetic data
```

`Prediction_NoShow.R` uses `data/registrations.csv` when it exists and otherwise falls back to the synthetic data.

> ⚠️ The synthetic data uses made-up, illustrative effects. It only demonstrates that the code runs. **It does not reproduce the results of the original study.**

## 📁 Repository Structure
```
├── Prediction_NoShow.R             # main analysis (uses synthetic data if real data is absent)
├── R/
│   └── generate_synthetic_data.R   # synthetic data + demo model fit
├── data/
│   └── README.md                   # data format (real data not included)
├── .gitignore                      # keeps proprietary data out of the repo
└── README.md
```
---
*Developed as an senior project by Poomrat Thanapasee | Connect with me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/)*
