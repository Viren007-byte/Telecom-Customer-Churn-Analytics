"""Reproducible churn analysis; run: python src/analyze_churn.py"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
df = pd.read_csv(ROOT / "data" / "telecom_customers.csv")
assert df.customer_id.is_unique and not df.isna().any().any()
assert set(df.churn_flag.unique()) <= {0, 1}
print("Customers:", len(df))
print("Churn rate: {:.2%}".format(df.churn_flag.mean()))
print("Monthly revenue lost: ${:,.2f}".format(df.monthly_revenue_lost.sum()))

fig, axs = plt.subplots(2, 2, figsize=(13, 9))
for ax, field, title in [
    (axs[0,0], "contract_type", "Churn rate by contract"),
    (axs[0,1], "internet_service", "Churn rate by internet service"),
    (axs[1,0], "payment_method", "Churn rate by payment method"),
    (axs[1,1], "tenure_band", "Churn rate by tenure")]:
    vals = (df.groupby(field).churn_flag.mean() * 100).sort_values(ascending=False)
    vals.plot(kind="bar", ax=ax, color="#168a88")
    ax.set_title(title); ax.set_xlabel(""); ax.set_ylabel("Churn rate (%)")
    ax.tick_params(axis="x", rotation=22)
    ax.set_ylim(0, max(55, vals.max() + 7))
fig.tight_layout()
out = ROOT / "visualizations" / "churn_analysis.png"
fig.savefig(out, dpi=160, bbox_inches="tight")
print("Saved", out)

for col in ["contract_type", "internet_service", "payment_method", "tenure_band"]:
    print("\n", col)
    print(df.groupby(col).agg(customers=("customer_id", "count"), churn_rate=("churn_flag", "mean")).round(3))
