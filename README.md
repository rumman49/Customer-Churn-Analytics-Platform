# Customer Churn Analytics Platform

An end-to-end data analytics project that predicts customer churn using RFM (Recency, Frequency, Monetary) analysis and machine learning, with results delivered through an interactive Power BI dashboard and a live Streamlit prediction app.

![Python](https://img.shields.io/badge/Python-3.10-blue)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 📌 Project Overview

Customer retention is far cheaper than customer acquisition. This project builds a complete pipeline — from raw transaction data to a deployed prediction tool and executive dashboard — that helps a retail business identify which customers are at risk of churning and why, so retention efforts can be targeted rather than blanket.

## 🎯 Business Problem

The Superstore dataset contains order-level transactions but no direct churn label. The goal was to:
- Convert transaction-level data into customer-level behavioral profiles (RFM)
- Define a measurable, defensible proxy for churn
- Build and compare classification models to predict at-risk customers
- Make the results usable for both technical (Streamlit) and business (Power BI) audiences

## 📊 Dataset

- **Source:** Superstore retail transactions dataset
- **Raw records:** 9,994 order-level transactions
- **After RFM aggregation:** 793 unique customer profiles

## 🛠️ Tech Stack

| Layer | Tools |
|---|---|
| Data Cleaning & Feature Engineering | Python (Pandas, NumPy) |
| EDA & Visualization | Matplotlib, Seaborn |
| Analytics | SQL |
| Machine Learning | scikit-learn (Naive Bayes, KNN, Random Forest) |
| Model Persistence | joblib |
| App Deployment | Streamlit |
| Business Dashboard | Power BI |

## 🔄 Workflow

```mermaid
flowchart TD
    A[Raw Superstore Dataset<br/>9,994 records] --> B[Data Cleaning]
    B --> C[Feature Engineering]
    C --> D[Exploratory Data Analysis]
    D --> E[SQL Analytics]
    E --> F[RFM Analysis &<br/>Customer Segmentation<br/>793 customer profiles]
    F --> G[Machine Learning<br/>Naive Bayes · KNN · Random Forest]
    G --> H[Best Model: Random Forest<br/>99.37% Accuracy · 99.30% F1]
    H --> I[Streamlit Web App<br/>Live Churn Prediction]
    H --> J[Power BI Dashboard<br/>4 Interactive Pages]
    I --> K[Business Value:<br/>Identify & Retain At-Risk Customers]
    J --> K
```

*(See `Images/architecture-diagram.svg` for a static version of this diagram.)*

## 📁 Folder Structure

```
Customer-Churn-Analytics-Platform/
│
├── Data/                  # Raw and processed datasets
├── Notebooks/             # Jupyter notebooks (EDA, feature engineering, ML)
├── SQL/                   # SQL analysis scripts
├── Models/                # Saved model & scaler (.pkl files)
├── PowerBI/               # .pbix dashboard file
├── Streamlit/             # app.py and Streamlit assets
├── Images/                # Diagrams, dashboard & app screenshots
├── Reports/               # Any supporting write-ups
├── README.md
├── requirements.txt
└── LICENSE
```

## 🧹 Data Cleaning & Feature Engineering

- Handled missing values, duplicates, and data type corrections
- Engineered 8 customer-level features from raw transactions:
  - Recency, Frequency, Monetary
  - R Score, F Score, M Score
  - RFM Score
  - Customer Segment

## 🤖 Machine Learning

Three classification models were trained and compared on the customer-level dataset (test set: 159 customers — 87 not-churned, 72 churned):

| Model | Accuracy | Precision | Recall | F1-Score | ROC-AUC |
|---|---|---|---|---|---|
| Naive Bayes | 90.57% | 90.14% | 88.89% | 89.51% | 0.9042 |
| K-Nearest Neighbors (KNN) | 91.19% | 95.31% | 84.72% | 89.71% | 0.9064 |
| **Random Forest (best)** | **99.37%** | **100%** | **98.61%** | **99.30%** | **0.9931** |

**Why Random Forest:** it consistently outperformed the other two models across every metric and handled the mix of RFM-derived features well without heavy tuning.

**Feature Importance:**

![Feature Importance](Images/feature-importance.jpg)

`recency` (0.517) and `r_score` (0.31) together account for over 80% of the model's decision-making. This is expected — and important — because the churn label itself was derived from recency (see Limitation below). This chart is the clearest evidence of *why* the model performs so well.

## 📈 Power BI Dashboard

A 4-page interactive dashboard built on the same 793-customer RFM dataset.

### 1. Executive Overview
793 total customers, 2.30M total sales, 286.40K total profit, and a 45.27% churn rate (per the proxy definition) across regions and customer segments.

![Executive Overview](Images/dashboard-executive-overview.jpg)

### 2. Customer Churn Analysis
359 churned vs. 434 retained customers. Churn concentrates heavily in the **At Risk** (127) and **Potential Loyalists** (116) segments — Champions show almost no churn, which is a strong sanity check on the segmentation.

![Customer Churn Analysis](Images/dashboard-churn-analysis.jpg)

### 3. Customer RFM Analysis
Average recency of 121.28 days and average frequency of 7.36 orders across customers. Champions average 5.4K in monetary value vs. just 0.5K for Lost Customers — a clear value gradient across segments.

![Customer RFM Analysis](Images/dashboard-rfm-analysis.jpg)

### 4. Sales Performance Analysis
Phones and Chairs are the top sub-categories by sales (0.33M each). Technology and Furniture lead by category-region split, and Standard Class dominates shipping mode at 59.12% of total sales.

![Sales Performance Analysis](Images/dashboard-sales-performance.jpg)

## 💻 Streamlit App

A live web app where a user enters customer Recency, Frequency, and Monetary values and gets an instant churn prediction with a business recommendation.

**Input form:**

![Streamlit App Form](Images/streamlit-app-form.jpg)

**Churn predicted** (low recency-value combination flagged as risk, with retention recommendations):

![Churn Prediction](Images/streamlit-churn-prediction.jpg)

**No churn predicted** (healthy recency/frequency/monetary combination, with growth recommendations):

![Non-Churn Prediction](Images/streamlit-non-churn-prediction.jpg)

## 💡 Key Business Insights

- Churn is heavily concentrated in the **At Risk** and **Potential Loyalists** segments (127 and 116 churned customers respectively) — these are the two segments retention campaigns should target first
- **Champions** (avg. 5.4K monetary value) drive a disproportionate share of revenue and show almost zero churn, confirming they need retention, not acquisition, spend
- Average customer recency across the base is 121 days — customers who cross well beyond this without a repeat order are the clearest early warning sign
- Phones and Chairs together account for the largest share of category sales, making them priority categories for churn-risk customers' win-back offers
- Standard Class shipping accounts for 59% of total sales, suggesting shipping speed/cost is not a major churn driver relative to product engagement (recency/frequency)

## ⚠️ Project Limitation

The original dataset did not contain a customer churn label. A **proxy churn label** was created using customer recency (customers inactive for more than 90 days were labeled churned). The feature importance chart shows `recency` and `r_score` alone account for over 80% of the model's predictive power — direct evidence that the model is largely learning the rule used to define the label. The high accuracy (99.37%) should be read in that context: it reflects how well the model recovers a recency-based rule, not ground-truth churn behavior. This is a documented, intentional trade-off given the dataset available, and one I'd resolve first with access to real subscription/contract-cancellation data.

## 🔮 Future Improvements

- Train on a dataset with true churn labels (subscription or contract-based business)
- Add SHAP-based explainability for individual predictions
- Track and report Streamlit prediction latency
- Deploy the Streamlit app publicly (Streamlit Community Cloud)
- Add automated retraining pipeline

## ⚙️ Setup & Usage

```bash
# Clone the repo
git clone https://github.com/rumman49/Customer-Churn-Analytics-Platform.git
cd Customer-Churn-Analytics-Platform

# Install dependencies
pip install -r requirements.txt

# Run the Streamlit app
streamlit run Streamlit/app.py
```

## 👤 Author

**Romaan Uddin Siddiqui**
[GitHub](https://github.com/rumman49) · [LinkedIn](#) · [Instagram](https://instagram.com/rumman_siddiqui_46)

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
