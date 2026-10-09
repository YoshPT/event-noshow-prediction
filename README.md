# 📊  Predicting Registration No-Shows with Logistic Regression

**An exploratory study of the behavioral drivers of event no-shows**

## 🎯 Project Overview
This is my senior project in Economics, completed during my Data Analyst co-op internship at Eventthai Co., Ltd., on a topic defined by the company. It applies Logistic Regression, an econometric approach, to identify the factors associated with event no-shows. The goal is to provide statistical evidence that can inform future features for event management platforms, such as risk-based reminders. The findings and recommendations were documented in a written report.

## 🛠️ Technical Stack & Methodology
* **Language:** R (RStudio)
* **Model:** Binary Logistic Regression (target: no-show)
* **Model Fit:** Nagelkerke R² of 0.132, AUC of 0.70 (see Model Performance)
* **Inference:** p-values, Wald Chi-Square, and odds ratios (Exp(B))
* **Diagnostics:** Multicollinearity check using Variance Inflation Factor (VIF)

## 📋 Data Attributes
The analysis is based on 9,179 anonymized registration records. Key variables include:
* `Status` (Target): 1 = No-show, 0 = Attended
* `Country`: Domestic vs. international registrants
* `Job`: Occupational level (e.g., Consultant, Executive, Marketing, Product Management, Procurement, Sales, and Technical & Education)
* `Lead Time`: Days between the registration date and the event date
* `Time`: Frequency of past event attendance
* `Company Size`: Number of employees in the registrant's organization

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

* **Accuracy vs. baseline:** Accuracy is only 1.4 percentage points above the baseline because no-shows are the minority class (29.0%) and the model rarely predicts them at this threshold. Accuracy alone therefore understates the model's usefulness.
* **Discrimination:** An AUC of 0.70 means a randomly chosen no-show receives a higher predicted probability than a randomly chosen attendee about 70% of the time.
* **Targeting value:** Among registrants flagged as no-shows, 55.6% did not attend, about 1.9 times the overall no-show rate. This suggests the model can help prioritize groups for follow-up, although it captures only about a quarter of all no-shows.

## 💡 Key Findings
Results are statistical associations, not causal effects. Exp(B) is the multiplicative change in the odds of a no-show. Variables are significant at the 0.01 level except where noted.

| Factor | B | S.E. | Exp(B) | Change in odds of no-show | p |
|---|---|---|---|---|---|
| Country: Thai vs. international | 0.171 | 0.056 | 1.186 | +18.6% | 0.002 |
| Occupation: Consultant / Advisor (Job1) | 0.061 | 0.136 | 1.063 | +6.3% (not significant) | 0.653 |
| Occupation: Executive / Senior Management (Job2) | -0.327 | 0.077 | 0.721 | -27.9% | < 0.001 |
| Occupation: Marketing & Communications (Job3) | -0.316 | 0.093 | 0.729 | -27.1% | 0.001 |
| Occupation: Product Management (Job4) | -0.306 | 0.115 | 0.736 | -26.4% | 0.008 |
| Occupation: Procurement (Job5) | -0.372 | 0.108 | 0.690 | -31.0% | 0.001 |
| Occupation: Sales & Business Development (Job6) | -0.471 | 0.073 | 0.624 | -37.6% | < 0.001 |
| Lead time (per additional day) | 0.027 | 0.001 | 1.028 | +2.8% | < 0.001 |
| Past attendance: 2-3 times vs. never | -0.221 | 0.050 | 0.802 | -19.8% | < 0.001 |
| Company size: >500 vs. <500 employees | -0.247 | 0.075 | 0.781 | -21.9% | 0.001 |

Model: N = 9,179, -2 Log Likelihood = 10,160.857, Cox & Snell R² = 0.092, Nagelkerke R² = 0.132.

Occupations are compared with Occupation: Technician and Education.
* **Higher odds of a no-show:** longer lead time and Thai registrants.
* **Lower odds of a no-show:** five of the six occupation categories, prior attendance, and larger companies. Consultant / Advisor did not differ significantly from the reference group.

## 🚀 Proposed Business Use Cases
Based on these findings, the following ideas are proposed for future platform development:
* **Smart reminders:** Trigger targeted email/SMS reminders for higher-risk segments, such as early registrants (the exact threshold would need to be validated).
* **Risk-based overbooking:** Suggest an overbooking quota to organizers based on the risk profile of the current registration pool (the rate would need to be estimated from historical data).
* **Returning-attendee segments:** Flag returning attendees to offer perks such as fast-track check-in.
* **On-site resource planning:** Use expected attendance to plan on-site staffing and check-in hardware.

## ⚠️ Limitations
* **Moderate predictive performance:** The Nagelkerke R² of 0.132 and AUC of 0.70 indicate that the model explains a limited share of no-show behavior. Its main contribution is identifying associated factors, not individual-level prediction.
* **In-sample evaluation:** All metrics were calculated on the data used to fit the model and may be optimistic. Validation on unseen data (e.g., a hold-out set or cross-validation) is needed before practical use.
* **Association, not causation:** The data is observational, so the findings show statistical associations, not causal effects.
* **Limited generalizability:** The model is based on 9,179 records from a single event. Results may differ for other organizers or event types.
---
*Developed as an internship Proof-of-Concept project by Poomrat Thanapasee | Connect with me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/)*
