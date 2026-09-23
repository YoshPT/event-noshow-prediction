# 📊 Event Registration No-Show Prediction: A Proof-of-Concept

> **Transforming Event Registration Data into Predictive Insights**

## 🎯 Project Overview
This project is an **exploratory study and Proof-of-Concept (PoC)** developed during a Data Analytics internship. It utilizes econometric approaches and Logistic Regression to understand the key drivers behind event no-shows. The ultimate goal is to provide statistical evidence that can inform future feature development for event management platforms, such as predictive dashboards or smart reminder systems.

## 🛠️ Technical Stack & Methodology
* **Language:** R
* **Algorithm:** Logistic Regression
* **Evaluation Metrics:** Percentage Correct (Overall Accuracy: 72.4%), Nagelkerke R Square (0.132)
* **Statistical Techniques:** Multicollinearity validation via Variance Inflation Factor (VIF), Odds Ratio Analysis (Exp(B))

## 📋 Data Attributes
The analysis is based on 9,179 anonymized registration records. Key variables include:
* `Status` (Target): 1 = No-show, 0 = Attended
* `Country`: Domestic vs. International registrants
* `Job`: Occupational level (e.g., C-Level, Procurement, Sales, Technical)
* `Lead Time`: Days between the registration date and the event date
* `Time`: Frequency of past event attendance
* `Company Size`: Number of employees in the registrant's organization
* > 🔒 **Data Privacy Note:** The dataset used in this analysis is proprietary to the company. To comply with data privacy and confidentiality policies, the original data file has not been uploaded to this public repository. However, the R scripts, methodologies, and statistical outputs are fully documented to demonstrate the analytical process.

## 💡 Key Findings & Behavioral Insights
By translating statistical outputs (P-values and Odds Ratios) into human behavior, the study found:
1. **The Trap of Time:** Longer registration lead times significantly increase the probability of a no-show (Exp(B) = 1.028). Early registrants require more engagement to maintain commitment.
2. **Position & Commitment:** Decision-makers (C-Level, Procurement, Sales) show a significantly lower no-show rate compared to technical or educational staff, likely driven by high-stakes business negotiation motives.
3. **Brand Loyalty:** Registrants with a history of attending the event (2-3 past attendances) are highly reliable and show strong brand loyalty (Coefficient = -0.221).
4. **Corporate Accountability:** Attendees from large enterprises (>500 employees) are more likely to attend, correlating with formal corporate assignments and reporting structures.

## 🚀 Proposed Business Use Cases
Based on the predictive model's findings, the following data-driven strategies are proposed for future platform development and operational optimization:
* **Automated "Smart Reminder" System:** Develop a CRM feature that triggers targeted email/SMS reminders specifically for high-risk segments (e.g., users who registered >30 days in advance).
* **Data-Driven Smart Overbooking:** Provide event organizers with a suggested overbooking quota (e.g., 10-15%) based on the risk profile of the current registration pool to maximize venue utilization.
* **VIP Loyalty Segments:** Flag returning attendees in the system to offer "Fast Track" check-in experiences, reinforcing retention for the highest-quality attendees.
* **On-Site Resource Optimization:** Utilize the predicted total attendance to accurately allocate the company's on-site staff and check-in hardware, effectively reducing operational costs.

---
*Developed as an internship Proof-of-Concept project by Poomrat Thanapasee | Connect with me on [LinkedIn](https://www.linkedin.com/in/poomrat-thanapasee-6a99443b3/)*
