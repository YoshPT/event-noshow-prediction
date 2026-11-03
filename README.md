# 📊 Analyzing Factors Influencing Registration No-Shows using Logistic Regression

**An exploratory study of the behavioral drivers of event no-shows**

## 🎯 Project Overview
This is my senior project in Economics, completed during my Data Analyst co-op internship at a Thai event-industry company. It applies Logistic Regression, an econometric approach, to identify the factors associated with event no-shows. The goal is to provide statistical evidence that can inform future features for event management platforms, such as risk-based reminders. The findings and recommendations were documented in a written report, which is available upon request.

## 🛠️ Technical Stack & Methodology
* **Language:** R (RStudio)
* **Model:** Binary Logistic Regression (target: no-show)
* **Inference:** p-values, Wald Chi-Square, and odds ratios (Exp(B)) with 95% profile-likelihood confidence intervals
* **Diagnostics:** Multicollinearity check using Generalized VIF (Job has six dummy variables), compared against the 2.24 threshold (equivalent to VIF < 5)
* **Evaluation:** AUC, Nagelkerke R², and a confusion matrix at a 0.5 classification threshold (in-sample)

## 📋 Data Attributes
The analysis is based on anonymized registration records. Variables and their coding:

| Variable | Coding |
|---|---|
| `Status` (Target) | 1 = No-show, 0 = Attended |
| `Country` | 1 = Domestic (Thai), 0 = International |
| `Job` | Six dummy variables: Job1 = Consultant / Advisor, Job2 = Executive / C-level, Job3 = Marketing & Communications, Job4 = Product Management, Job5 = Purchasing / Procurement, Job6 = Sales & Business Development. Reference group (all dummies = 0): Technical Roles |
| `Lead Time` | Days between registration date and event date (Event Date − Registration Date) |
| `Time` (past attendance) | 1 = returning attendee (2-3 times), 0 = first-time attendee |
| `Company Size` | 1 = more than 500 employees, 0 = 500 or fewer |

> 🔒 **Data Privacy Note:**
> The dataset used in this analysis is proprietary to the company. To comply with data privacy and confidentiality policies, the original data file and the numerical results have not been published in this public repository. The R scripts and methodology are documented to demonstrate the analytical process.

## 🔍 Approach
1. Define the outcome (no-show vs. attended) and the explanatory variables listed above.
2. Fit a binary logistic regression and check multicollinearity with Generalized VIF.
3. Interpret coefficients as odds ratios with profile-likelihood confidence intervals.
4. Evaluate fit and discrimination in-sample, and treat the results as associations rather than causal effects.

Results and the written report are available upon request.

## ⚠️ Limitations
* **In-sample evaluation:** Metrics were calculated on the data used to fit the model and may be optimistic. Validation on unseen data (e.g., a hold-out set or cross-validation) is needed before practical use.
* **Association, not causation:** The data is observational, so the findings show statistical associations, not causal effects.
* **Limited generalizability:** The model is based on registration records from a single event. Results may differ for other organizers or event types.

---
*Developed as an senior project by Poomrat Thanapasee | Connect with me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/)*
