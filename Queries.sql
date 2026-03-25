SELECT 
	COUNT(*) AS Total_Clientes,
	SUM(cast(churn AS INT)) AS clientes_que_se_fueron,
	ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS tasa_churn
FROM [Bank Customer Churn Prediction]
--The analysis shows a churn rate of approximately 20%, meaning that 1 in 5 customers leave the bank.
--This indicates a significant retention problem and highlights the need to identify key factors driving customer attrition.


SELECT 
    products_number,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY products_number
ORDER BY churn_rate DESC;
--Customers with two products show the lowest churn rate (~7.6%), suggesting that moderate cross-selling improves customer retention.
--However, customers with three or more products exhibit higher churn rates, possibly due to over-segmentation, product mismatch, or small sample sizes.

SELECT 
    Active_member,
    count(*) as Total,
    SUM(CAST(churn as INT)) as churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM [Bank Customer Churn Prediction]
GROUP BY 
    active_member
--Increasing customer engagement could be a key strategy to reduce churn, as inactive users are significantly more likely to leave.

SELECT * FROM [Bank Customer Churn Prediction]

SELECT 
    products_number,
    active_member,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY products_number, active_member
ORDER BY churn_rate DESC;
--Customer activity significantly reduces churn across all product levels.
--The bank should prioritize increasing engagement among customers with a single product, 
--as this segment shows the highest churn risk. 
--Additionally, promoting cross-selling strategies to reach at least two products per customer could significantly improve retention

SELECT 
    CASE 
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle Age'
        ELSE 'Older'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM dbo.[Bank Customer Churn Prediction]
GROUP BY 
    CASE 
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle Age'
        ELSE 'Older'
    END
ORDER BY churn_rate DESC;
--Older customers exhibit the highest churn rates, suggesting potential dissatisfaction or unmet needs within this segment. 
--Meanwhile, middle-aged customers represent the largest portion of the customer base and contribute most to total churn, making them a key target for retention strategies.

--Churn is strongly associated with low engagement and limited product usage. Customers with only one product, low activity levels, 
--and belonging to older age groups are particularly at risk. Increasing engagement and promoting optimal product adoption (around two products) could significantly improve retention.
