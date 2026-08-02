import streamlit as st
import pandas as pd
import joblib

# ==========================================
# Page Configuration
# ==========================================

st.set_page_config(
    page_title="Customer Churn Prediction",
    page_icon="📊",
    layout="centered"
)

st.sidebar.title("Customer Churn Analytics")
st.sidebar.write("Random Forest Model")

st.markdown("---")
st.caption("Developed by Romaan Uddin Siddiqui")
# ==========================================
# Load Model
# ==========================================

from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

model = joblib.load(BASE_DIR / "Models" / "Random_forest_model.pkl")

df = pd.read_csv(BASE_DIR / "Data" / "customer_rfm.csv")
# ==========================================
# Title
# ==========================================

st.title("📊 Customer Churn Prediction")

st.write(
    "Enter the customer details below to predict whether the customer is likely to churn."
)

# ==========================================
# User Inputs
# ==========================================

customer_name = st.text_input("Customer Name")

recency = st.number_input(
    "Recency",
    min_value=0,
    value=30,
    step=1
)

frequency = st.number_input(
    "Frequency",
    min_value=0,
    value=5,
    step=1
)

monetary = st.number_input(
    "Monetary",
    min_value=0.0,
    value=1000.0,
    step=100.0
)

# ==========================================
# Predict Button
# ==========================================

if st.button("Predict Churn"):

    customer_data = pd.DataFrame({
        "recency": [recency],
        "frequency": [frequency],
        "monetary": [monetary]
    })

    prediction = model.predict(customer_data)
    probability = model.predict_proba(customer_data)

    st.divider()

    st.subheader("Prediction Result")

    st.write(f"**Customer Name:** {customer_name}")

    if prediction[0] == 1:
        st.error("Customer is likely to Churn")
        st.info("""
        Recommendation:
        • Offer a discount
        • Send personalized emails
        • Contact the customer
        """)
    else:
        st.success("Customer is NOT likely to Churn")
        st.info("""
        Recommendation:
        • Continue loyalty rewards
        • Recommend premium products
        """)
    