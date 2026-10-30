USE telecom_churn;
-- 1. Overall customer and churn KPIs
SELECT COUNT(*) AS customers, SUM(churn_flag) AS churned,
 ROUND(100.0*AVG(churn_flag),2) AS churn_rate_pct,
 ROUND(SUM(monthly_revenue_lost),2) AS monthly_revenue_lost
FROM customers;

-- 2. Contract type and churn
SELECT contract_type, COUNT(*) AS customers, SUM(churn_flag) AS churned,
 ROUND(100.0*AVG(churn_flag),2) AS churn_rate_pct
FROM customers GROUP BY contract_type ORDER BY churn_rate_pct DESC;

-- 3. Internet service and churn
SELECT internet_service, COUNT(*) AS customers,
 ROUND(100.0*AVG(churn_flag),2) AS churn_rate_pct
FROM customers GROUP BY internet_service ORDER BY churn_rate_pct DESC;

-- 4. Payment method and churn
SELECT payment_method, COUNT(*) AS customers,
 ROUND(100.0*AVG(churn_flag),2) AS churn_rate_pct
FROM customers GROUP BY payment_method ORDER BY churn_rate_pct DESC;

-- 5. Tenure cohort analysis
SELECT tenure_band, COUNT(*) AS customers,
 ROUND(100.0*AVG(churn_flag),2) AS churn_rate_pct
FROM customers GROUP BY tenure_band ORDER BY MIN(tenure_months);

-- 6. Revenue exposure by segment
SELECT contract_type, ROUND(SUM(monthly_revenue_lost),2) AS monthly_revenue_lost
FROM customers GROUP BY contract_type ORDER BY monthly_revenue_lost DESC;

-- 7. High-charge churned customers (sample)
SELECT customer_id, tenure_months, contract_type, monthly_charges
FROM customers WHERE churn_flag = 1 ORDER BY monthly_charges DESC LIMIT 20;

-- 8. Support and security segmentation
SELECT tech_support, online_security, COUNT(*) AS customers,
 ROUND(100.0*AVG(churn_flag),2) AS churn_rate_pct
FROM customers GROUP BY tech_support, online_security ORDER BY churn_rate_pct DESC;
