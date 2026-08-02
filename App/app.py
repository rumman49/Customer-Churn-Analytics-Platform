import streamlit as st
import pandas as pd
import joblib
from pathlib import Path

# ==========================================
# Page Configuration
# ==========================================

st.set_page_config(
    page_title="Customer Churn Prediction",
    page_icon="📊",
    layout="centered"
)

BASE_DIR = Path(__file__).resolve().parent.parent

# ==========================================
# Sidebar
# ==========================================

st.sidebar.title("📊 Customer Churn Analytics")
st.sidebar.write("**Model:** Random Forest Classifier")

with st.sidebar.expander("Model Performance"):
    st.write("Accuracy: **99.37%**")
    st.write("Precision: **100%**")
    st.write("Recall: **98.61%**")
    st.write("F1 Score: **99.30%**")
    st.write("ROC-AUC: **0.9931**")

with st.sidebar.expander("About churn label"):
    st.caption(
        "Churn here is a proxy label derived from recency "
        "(customer inactive for 90+ days), since the dataset "
        "has no ground-truth churn flag. Predictions reflect "
        "'gone quiet' risk, not a confirmed cancellation."
    )

st.sidebar.markdown("---")
st.sidebar.caption("Developed by Romaan Uddin Siddiqui")

# ==========================================
# Load Model & Data (with error handling)
# ==========================================

@st.cache_resource
def load_model():
    model_path = BASE_DIR / "Models" / "Random_forest_model.pkl"
    return joblib.load(model_path)

@st.cache_data
def load_data():
    data_path = BASE_DIR / "Data" / "customer_rfm.csv"
    return pd.read_csv(data_path)

try:
    model = load_model()
    df = load_data()
    load_error = None
except FileNotFoundError as e:
    load_error = str(e)
except Exception as e:
    load_error = f"Unexpected error while loading model/data: {e}"

if load_error:
    st.error("Failed to load model or data.")
    st.code(load_error)
    st.info(
        f"Expected paths:\n"
        f"- {BASE_DIR / 'Models' / 'Random_forest_model.pkl'}\n"
        f"- {BASE_DIR / 'Data' / 'customer_rfm.csv'}"
    )
    st.stop()

# ==========================================
# Title
# ==========================================

st.title("📊 Customer Churn Prediction")
st.write(
    "Enter the customer's RFM details below to predict churn risk."
)

# ==========================================
# User Inputs
# ==========================================

customer_name = st.text_input("Customer Name", placeholder="e.g. John Doe")

col1, col2, col3 = st.columns(3)

with col1:
    recency = st.number_input(
        "Recency (days)",
        min_value=0,
        value=30,
        step=1,
        help="Days since the customer's last purchase."
    )

with col2:
    frequency = st.number_input(
        "Frequency",
        min_value=0,
        value=5,
        step=1,
        help="Total number of purchases made."
    )

with col3:
    monetary = st.number_input(
        "Monetary ($)",
        min_value=0.0,
        value=1000.0,
        step=100.0,
        help="Total amount spent by the customer."
    )

st.markdown("---")

# ==========================================
# Predict Button
# ==========================================

predict_clicked = st.button("🔍 Predict Churn", use_container_width=True)

if predict_clicked:

    if not customer_name.strip():
        st.warning("Please enter a customer name before predicting.")
        st.stop()

    with st.spinner("Running prediction..."):
        customer_data = pd.DataFrame({
            "recency": [recency],
            "frequency": [frequency],
            "monetary": [monetary]
        })

        prediction = model.predict(customer_data)[0]
        probability = model.predict_proba(customer_data)[0]
        churn_prob = probability[1]
        retain_prob = probability[0]

    st.subheader("Prediction Result")
    st.write(f"**Customer Name:** {customer_name}")

    # Probability bar
    st.write("**Churn probability**")
    st.progress(float(churn_prob))
    st.caption(f"{churn_prob * 100:.1f}% likely to churn · {retain_prob * 100:.1f}% likely to stay")

    st.markdown("---")

    if prediction == 1:
        st.error(f"⚠️ Customer is likely to Churn ({churn_prob * 100:.1f}% confidence)")
        st.info(
            "**Recommended actions:**\n"
            "- Offer a targeted discount or retention deal\n"
            "- Send a personalized win-back email\n"
            "- Have a rep reach out directly\n"
            "- Flag account for priority support"
        )
    else:
        st.success(f"✅ Customer is NOT likely to Churn ({retain_prob * 100:.1f}% confidence)")
        st.info(
            "**Recommended actions:**\n"
            "- Continue loyalty rewards\n"
            "- Recommend premium/upsell products\n"
            "- Keep engagement consistent"
        )

    # Downloadable result
    result_text = (
        f"Customer: {customer_name}\n"
        f"Recency: {recency} days | Frequency: {frequency} | Monetary: ${monetary}\n"
        f"Prediction: {'Churn' if prediction == 1 else 'No Churn'}\n"
        f"Churn Probability: {churn_prob * 100:.1f}%\n"
    )
    st.download_button(
        "⬇️ Download Result",
        data=result_text,
        file_name=f"churn_prediction_{customer_name.strip().replace(' ', '_')}.txt",
        mime="text/plain",
        use_container_width=True
    )

# ==========================================
# Dataset Preview (optional, collapsible)
# ==========================================

with st.expander("Preview underlying customer dataset"):
    st.dataframe(df.head(20), use_container_width=True)
    st.caption(f"Showing 20 of {len(df):,} customers.")