# 📊  Analyzing Factors Influencing Registration No-Shows using Logistic Regression

**An exploratory study of the behavioral drivers of event no-shows**

## 🎯 Project Overview
This is my senior project in Economics, completed during my Data Analyst co-op internship at Eventthai Co., Ltd. applying Logistic Regression, an econometric approach, to identify the factors associated with event no-shows. The goal is to provide statistical evidence that can inform future features for event management platforms, such as risk-based reminders. The findings and recommendations were documented in a written report.

## 🛠️ Technical Stack & Methodology
* **Language:** R (RStudio)
* **Model:** Binary Logistic Regression (target: no-show)
* **Model Fit:** Nagelkerke R² of 0.132, AUC of 0.70 (see Model Performance)
* **Inference:** p-values, Wald Chi-Square, and odds ratios (Exp(B)) with 95% profile-likelihood confidence intervals
* **Diagnostics:** Multicollinearity check using Variance Inflation Factor (VIF). Generalized VIF is used because Job has six dummy variables; all GVIF^(1/(2*Df)) values are at most 1.04, well below 2.24 (the equivalent of VIF < 5), so multicollinearity is not a concern

## 📋 Data Attributes
The analysis is based on 9,179 anonymized registration records. Variables and their coding:

| Variable | Coding |
|---|---|
| `Status` (Target) | 1 = No-show, 0 = Attended |
| `Country` | 1 = Domestic (Thai), 0 = International |
| `Job` | Six dummy variables: Job1 = Consultant / Advisor, Job2 = Executive / C-level, Job3 = Marketing & Communications, Job4 = Product Management, Job5 = Purchasing / Procurement, Job6 = Sales & Business Development. Reference group (all dummies = 0): Technical Roles |
| `Lead Time` | The time duration between registration date and event date (Event Date - Registration Date). |
| `Time` | Past attendance of this event: 1 = attended 2-3 times, 0 = never attended |
| `Company Size` | 1 = more than 500 employees, 0 = fewer than 500 employees |

> 🔒 **Data Privacy Note:**
> The dataset used in this analysis is proprietary to the company. To comply with data privacy and confidentiality policies, the original data file has not been uploaded to this public repository. However, the R scripts, methodologies, and statistical outputs are fully documented to demonstrate the analytical process.

## 🎯 Model Performance
Metrics are calculated at a 0.5 classification threshold on the full dataset (in-sample).

| Metric | Value |
|---|---|
| Overall accuracy | 72.4% |
| Majority-class baseline | 71.0% |
| AUC | 0.70 |
| Nagelkerke R² | 0.132 |
| No-show recall | 23.1% |
| No-show precision | 55.6% |

| | Predicted: Attended | Predicted: No-show |
|---|---|---|
| **Actual: Attended** | 6,030 | 491 |
| **Actual: No-show** | 2,044 | 614 |

* **Accuracy vs. baseline:** Accuracy is only 1.4 percentage points above the baseline because no-shows are the minority class (29.0%) and the model rarely predicts them at this threshold, so accuracy alone is not informative here. The AUC and the precision of the flagged group describe the model more usefully.
* **Discrimination:** An AUC of 0.70 means a randomly chosen no-show receives a higher predicted probability than a randomly chosen attendee about 70% of the time.
* **Targeting value:** Among registrants flagged as no-shows, 55.6% did not attend, about 1.9 times the overall no-show rate. This suggests the model can help prioritize groups for follow-up, although it captures only 23.1% of all no-shows.

## 💡 Key Findings
Results are statistical associations, not causal effects. Exp(B) is the multiplicative change in the odds of a no-show. Occupations are compared with the reference group Technical Roles. Variables are significant at the 0.01 level except where noted.

| Factor | B | S.E. | Wald χ² | Exp(B) | 95% CI for Exp(B) | Change in odds of no-show | p |
|---|---|---|---|---|---|---|---|
| Country: Thai vs. international | 0.1622 | 0.0543 | 8.918 | 1.176 | 1.058-1.309 | +17.6% | 0.003 |
| Occupation: Consultant / Advisor (Job1) | 0.0633 | 0.1358 | 0.217 | 1.065 | 0.815-1.387 | +6.5% (not significant) | 0.641 |
| Occupation: Executive / C-level (Job2) | -0.3213 | 0.0761 | 17.816 | 0.725 | 0.625-0.842 | -27.5% | < 0.001 |
| Occupation: Marketing & Communications (Job3) | -0.3186 | 0.0925 | 11.875 | 0.727 | 0.606-0.871 | -27.3% | 0.001 |
| Occupation: Product Management (Job4) | -0.3062 | 0.1147 | 7.124 | 0.736 | 0.587-0.920 | -26.4% | 0.008 |
| Occupation: Purchasing / Procurement (Job5) | -0.3737 | 0.1075 | 12.086 | 0.688 | 0.557-0.848 | -31.2% | 0.001 |
| Occupation: Sales & Business Development (Job6) | -0.4696 | 0.0734 | 40.906 | 0.625 | 0.541-0.722 | -37.5% | < 0.001 |
| Lead time (per additional day) | 0.0274 | 0.0010 | 763.562 | 1.028 | 1.026-1.030 | +2.8% | < 0.001 |
| Past attendance: 2-3 times vs. never | -0.2197 | 0.0499 | 19.386 | 0.803 | 0.728-0.885 | -19.7% | < 0.001 |
| Company size: >500 vs. <500 employees | -0.2457 | 0.0750 | 10.738 | 0.782 | 0.674-0.905 | -21.8% | 0.001 |

Model: N = 9,179, -2 Log Likelihood = 10,160.857, Cox & Snell R² = 0.092, Nagelkerke R² = 0.132. Joint Wald test for Job (df = 6): χ² = 50.43, p < 0.001.

* **Higher odds of a no-show:** longer lead time and Thai registrants. For lead time, the effect compounds per day: registering 30 days earlier corresponds to roughly 2.3× the odds (exp(0.0274 × 30)), assuming a linear effect on the log-odds.
* **Lower odds of a no-show:** five of the six occupation categories, prior attendance, and larger companies. Consultant / Advisor did not differ significantly from the reference group.

## 🚀 Proposed Business Use Cases
Based on these findings, the following ideas are proposed for future platform development:
* **Smart reminders:** Trigger targeted email/SMS reminders for higher-risk segments, such as early registrants (the exact threshold would need to be validated).
* **Risk-based overbooking:** Suggest an overbooking quota to organizers based on the risk profile of the current registration pool (the rate would need to be estimated from historical data).

**Other ideas (not directly derived from the model results):**
* **Returning-attendee segments:** Flag returning attendees to offer perks such as fast-track check-in.
* **On-site resource planning:** Use expected attendance to plan on-site staffing and check-in hardware.

## ⚠️ Limitations
* **Moderate predictive performance:** The Nagelkerke R² of 0.132 and AUC of 0.70 indicate that the model explains a limited share of no-show behavior. Its main contribution is identifying associated factors, not individual-level prediction.
* **In-sample evaluation:** All metrics were calculated on the data used to fit the model and may be optimistic. Validation on unseen data (e.g., a hold-out set or cross-validation) is needed before practical use.
* **Association, not causation:** The data is observational, so the findings show statistical associations, not causal effects.
* **Limited generalizability:** The model is based on 9,179 records from a single event. Results may differ for other organizers or event types.

---
*Developed as an senior project by Poomrat Thanapasee | Connect with me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/)*
