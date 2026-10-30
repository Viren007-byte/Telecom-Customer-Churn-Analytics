CREATE DATABASE IF NOT EXISTS telecom_churn;
USE telecom_churn;
CREATE TABLE IF NOT EXISTS customers (
 customer_id VARCHAR(12) PRIMARY KEY, gender VARCHAR(10), senior_citizen TINYINT,
 partner VARCHAR(3), dependents VARCHAR(3), tenure_months INT, contract_type VARCHAR(25),
 internet_service VARCHAR(25), tech_support VARCHAR(3), online_security VARCHAR(3),
 payment_method VARCHAR(30), paperless_billing VARCHAR(3), monthly_charges DECIMAL(10,2),
 total_charges DECIMAL(12,2), churn VARCHAR(3), churn_flag TINYINT,
 tenure_band VARCHAR(15), monthly_revenue_lost DECIMAL(10,2)
);
-- Import data/telecom_customers.csv via MySQL Workbench Table Data Import Wizard.
-- Confirm column order and numeric types; do not load duplicate customer_id values.
