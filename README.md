# Customer Churn Analytics Platform
### End-to-End Customer Intelligence & Revenue Protection System

---

## Business Problem

Businesses lose customers every month without knowing:
- Who is about to leave?
- Why are they leaving?
- How much revenue is at risk?
- What should we do about it?

This platform answers all four questions using machine learning,
explainable AI, and business analytics.

---

## Project Architecture

Raw Data (IBM Telco)

↓

Module 1 — Customer Intelligence & Segmentation

↓

Module 2 — Churn Prediction & Risk Scoring

↓

Module 3 — Explainable AI & Revenue Protection

↓

Power BI Dashboard (3 pages)

---

## Modules

### Module 1 — Customer Intelligence & Segmentation
**Notebooks:** 01_eda_and_cleaning, 02_data_cleaning, 03_rfm_analysis, 04_clv_calculation

**What it does:**
- Exploratory Data Analysis on 7,032 customers
- RFM Analysis (Recency, Frequency, Monetary)
- K-Means Customer Segmentation (4 segments)
- Customer Lifetime Value (CLV) calculation

**Key Finding:**
Champions segment (28% of customers) accounts for
68% of total revenue at risk ($1.6M out of $2.33M)

---

### Module 2 — Churn Prediction & Risk Scoring
**Notebooks:** 05_feature_engineering, 06_model_training, 07_risk_scoring

**What it does:**
- Feature engineering and encoding
- Model comparison: Logistic Regression, Random Forest, XGBoost
- Hyperparameter tuning via GridSearchCV (27 combinations, 5-fold CV)
- Class imbalance handling via scale_pos_weight
- Risk scoring: High / Medium / Low
- Priority assignment: Critical / High / Medium / Low

**Model Performance (XGBoost Tuned):**
| Metric | Score |
|---|---|
| AUC ROC | 0.8387 |
| Recall | 0.7995 |
| Precision | 0.5000 |
| F1 Score | 0.6152 |
| Accuracy | 0.7342 |

**Key Finding:**
Month-to-month contract customers churn at 42.7%
vs 2.85% for two-year contracts — 15x difference

---

### Module 3 — Explainable AI & Revenue Protection
**Notebooks:** 08_shap_global, 09_shap_local, 10_revenue_at_risk

**What it does:**
- SHAP Global: Top 15 churn drivers across all customers
- SHAP Local: Individual customer waterfall explanation
- Revenue at Risk = CLV × Churn Probability
- Customer Priority Matrix
- Retention Strategy Recommendation Engine
- Campaign ROI Simulator (3 scenarios)

**Key Finding:**
Total Revenue at Risk: $2,331,701
Top churn driver: Contract_Month-to-month (SHAP: +0.85)

---

### SQL Business Queries
**Notebook:** sql/business_queries.ipynb

10 SQL queries covering:
- Overall and segment-level churn rates
- Revenue at risk analysis
- Customer prioritization
- Retention strategy distribution
- Campaign targeting

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python | Data processing and ML |
| Pandas / NumPy | Data manipulation |
| Scikit-learn | Model training and evaluation |
| XGBoost | Churn prediction model |
| SHAP | Explainable AI |
| SQLite | SQL business queries |
| Power BI | Interactive dashboard |
| Jupyter Notebooks | Analysis and documentation |

---

## Dataset

**IBM Telco Customer Churn Dataset**
- Source: Kaggle
- Rows: 7,032 customers
- Columns: 21 features
- Target: Churn (Yes/No) — 26.58% churn rate

---

## Key Business Insights

1. **Contract type is the #1 churn driver**
   Month-to-month customers churn 15x more than two-year customers

2. **Champions drive 68% of revenue at risk**
   Despite being only 28% of customers

3. **60 Critical customers identified**
   Average $980 revenue at risk each — need immediate personal outreach

4. **$2.33M total revenue at risk**
   Discount campaign targeting 500 customers saves $62,500 net at 416% ROI

5. **Tuned XGBoost catches 80% of churners**
   Recall of 0.80 after class imbalance handling and hyperparameter tuning

---

## Power BI Dashboard

3-page interactive dashboard:

**Page 1 — Customer Intelligence**
Segment distribution, CLV analysis, revenue by segment

**Page 2 — Churn Risk**
Risk scoring, priority matrix, CLV vs churn scatter plot,
high risk customer list with retention strategies

**Page 3 — Revenue Protection**
Revenue at risk analysis, critical customer action list,
SHAP feature importance, campaign ROI scenarios

---

## Project Structure
customer-churn-platform/

├── data/

│   ├── telco_churn.csv

│   ├── telco_churn_cleaned.csv

│   └── telco_churn_ml_ready.csv

├── module1_segmentation/

│   ├── 01_eda_and_cleaning.ipynb

│   ├── 02_data_cleaning.ipynb

│   ├── 03_rfm_analysis.ipynb

│   └── 04_clv_calculation.ipynb

├── module2_churn_prediction/

│   ├── 05_feature_engineering.ipynb

│   ├── 06_model_training.ipynb

│   └── 07_risk_scoring.ipynb

├── module3_explainability/

│   ├── 08_shap_global.ipynb

│   ├── 09_shap_local.ipynb

│   └── 10_revenue_at_risk.ipynb

├── sql/

│   └── business_queries.ipynb

├── outputs/

│   ├── rfm_segments.csv

│   ├── clv_scores.csv

│   ├── risk_scored_customers.csv

│   ├── revenue_at_risk.csv

│   ├── xgb_model.pkl

│   └── shap_plots/

├── powerbi/

│   └── churn_dashboard.pbix

└── requirements.txt

---

## How to Run

**Step 1 — Clone the repository**
```bash
git clone https://github.com/sukhdevx09/customer-churn-platform.git
cd customer-churn-platform
```

**Step 2 — Create virtual environment**
```bash
python -m venv venv
venv\Scripts\activate
```

**Step 3 — Install dependencies**
```bash
pip install -r requirements.txt
```

**Step 4 — Download dataset**
Download IBM Telco Customer Churn from Kaggle:
https://www.kaggle.com/datasets/blastchar/telco-customer-churn
Place as: data/telco_churn.csv

**Step 5 — Run notebooks in order**
module1_segmentation/01 → 02 → 03 → 04

module2_churn_prediction/05 → 06 → 07

module3_explainability/08 → 09 → 10

sql/business_queries

**Step 6 — Open Power BI dashboard**
powerbi/churn_dashboard.pbix

---

## Author
**Sukhdev**
Data Analyst | Machine Learning | Business Analytics

---

## Target Industries
Banking | Credit Cards | FinTech | Telecom | Insurance | Subscription