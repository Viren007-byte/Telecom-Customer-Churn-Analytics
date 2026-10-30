# Power BI dashboard build guide

**Input:** `data/telecom_customers.csv` → Home → Get data → Text/CSV → Load.
Rename the table to **Customers** if necessary.

## Measures (Modeling → New measure)
```dax
Total Customers = DISTINCTCOUNT(Customers[customer_id])
Churned Customers = CALCULATE(DISTINCTCOUNT(Customers[customer_id]), Customers[churn] = "Yes")
Retained Customers = [Total Customers] - [Churned Customers]
Churn Rate % = DIVIDE([Churned Customers], [Total Customers])
Monthly Revenue = SUM(Customers[monthly_charges])
Monthly Revenue Lost = SUM(Customers[monthly_revenue_lost])
Average Monthly Charge = AVERAGE(Customers[monthly_charges])
Average Tenure = AVERAGE(Customers[tenure_months])
```

Format `Churn Rate %` as Percentage (2 decimal places). Format revenue measures as currency (USD, synthetic).

## Dashboard (16:9 landscape)
- Title: Telecom Customer Churn | Retention Insights
- KPI row: Total Customers; Churned Customers; Churn Rate %; Monthly Revenue; Monthly Revenue Lost
- Slicers: contract_type; internet_service; payment_method; tenure_band
- Visuals: churn rate by contract (bar); churn rate by internet service (bar); churn rate by payment method (bar); churn rate by tenure band (column); monthly revenue lost by contract (bar); customers by churn (donut)
- Theme: background #F5F7FB, cards white, text #15243A, primary teal #138B87.

**Important:** For bar charts use the **Churn Rate % measure** on the value axis, not a sum of churn flags. All KPIs will respond to slicers.

Save the completed report as `dashboard/Telecom_Customer_Churn.pbix`, then export a screenshot to `visualizations/power_bi_dashboard.png`. This project package does not include a fabricated PBIX file.
