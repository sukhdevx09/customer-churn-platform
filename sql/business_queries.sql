-- Active: 1785243127350@@127.0.0.1@3306
-- 10 Business Queries 

-- Query 1: Overall Churn Rate
-- Business Question: What percentage of customers churned?

SELECT * FROM customers LIMIT 5;
SELECT * FROM telco LIMIT 5;

SELECT 
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS Churn_Rate_Pct
FROM telco;

-- Result: 26.58% churn rate across 7,032 customers

-- Query 2: Churn Rate by Contract Type
-- Business Question: Which contract type has highest churn?

SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS Churn_Rate_Pct
FROM telco
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;

-- Result: Month-to-month 42.71% vs Two-year 2.85% — 15x difference

-- Query 3: Top 10 Customers by CLV
-- Business Question: Who are our most valuable customers?

SELECT 
    customerID,
    tenure,
    MonthlyCharges,
    ROUND(CLV_Enhanced, 2) AS CLV,
    CLV_Tier,
    Segment,
    Risk_Label,
    Retention_Strategy
FROM customers
ORDER BY CLV_Enhanced DESC
LIMIT 10;

-- Result: Champions dominate top 10 — avg CLV $8,578

-- Query 4: Revenue at Risk by Segment
-- Business Question: Where is most revenue at risk?

SELECT 
    Segment,
    COUNT(*) AS Customers,
    ROUND(SUM(Revenue_at_Risk), 2) AS Total_Revenue_at_Risk,
    ROUND(AVG(Revenue_at_Risk), 2) AS Avg_Revenue_at_Risk,
    ROUND(AVG(Churn_Probability) * 100, 2) AS Avg_Churn_Prob_Pct
FROM customers
GROUP BY Segment
ORDER BY Total_Revenue_at_Risk DESC;

-- Result: Champions carry $2.70M (69%) of total $3.89M revenue at risk

-- Query 5: High Risk Customers by Segment
-- Business Question: Where are high risk customers concentrated?

SELECT 
    Segment,
    Risk_Label,
    COUNT(*) AS Customers,
    ROUND(SUM(Revenue_at_Risk), 2) AS Total_Revenue_at_Risk
FROM customers
WHERE Risk_Label = 'High Risk'
GROUP BY Segment, Risk_Label
ORDER BY Total_Revenue_at_Risk DESC;

-- Result: Champions (237 customers, $548,735), and Loyal Customers has 407

-- Query 6: Average Monthly Charges by Churn Status
-- Business Question: Do churners pay more than non-churners?

SELECT 
    Churn,
    COUNT(*) AS Customers,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charges,
    ROUND(AVG(tenure), 2) AS Avg_Tenure_Months,
    ROUND(AVG(TotalCharges), 2) AS Avg_Total_Charges
FROM telco
GROUP BY Churn
ORDER BY Churn DESC;

-- Result: Churners pay higher monthly charges on average

-- Query 7: Retention Strategy Distribution
-- Business Question: How many customers need each retention action?

SELECT 
    Retention_Strategy,
    COUNT(*) AS Customers,
    ROUND(SUM(Revenue_at_Risk), 2) AS Total_Revenue_at_Risk,
    ROUND(AVG(Churn_Probability) * 100, 2) AS Avg_Churn_Prob_Pct
FROM customers
GROUP BY Retention_Strategy
ORDER BY Total_Revenue_at_Risk DESC;

-- Result: Personal RM needed for 463 critical customers

-- Query 8: Priority Customer Summary
-- Business Question: How many customers in each priority level?

SELECT 
    Priority,
    COUNT(*) AS Customers,
    ROUND(SUM(Revenue_at_Risk), 2) AS Total_Revenue_at_Risk,
    ROUND(AVG(Revenue_at_Risk), 2) AS Avg_Revenue_at_Risk,
    ROUND(AVG(Churn_Probability) * 100, 2) AS Avg_Churn_Prob_Pct
FROM customers
GROUP BY Priority
ORDER BY 
    CASE Priority
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
    END;

-- Result: 463 Critical ($1,718 avg) | 2,127 High ($854 avg)

-- Query 9: Top 10 Customers by Revenue at Risk
-- Business Question: Who should we target first?

SELECT 
    customerID,
    ROUND(Churn_Probability * 100, 2) AS Churn_Prob_Pct,
    Risk_Label,
    Priority,
    ROUND(CLV_Enhanced, 2) AS CLV,
    ROUND(Revenue_at_Risk, 2) AS Revenue_at_Risk,
    Retention_Strategy
FROM customers
ORDER BY Revenue_at_Risk DESC
LIMIT 10;

-- Result: Actionable target list for immediate retention outreach

-- Query 10: Churn Rate by CLV Tier
-- Business Question: Do high value customers churn more?

SELECT 
    CLV_Tier,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS Churn_Rate_Pct,
    ROUND(AVG(Revenue_at_Risk), 2) AS Avg_Revenue_at_Risk
FROM customers
GROUP BY CLV_Tier
ORDER BY Churn_Rate_Pct DESC;

-- Result: Low Value tier churns most (40.56%), Premium least (15.07%); churn decreases as CLV increases.
