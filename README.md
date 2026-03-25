#  Customer Churn Analysis in a Financial Institution (SQL Project)

## Overview

Customer churn is a critical challenge in financial institutions, as retaining existing customers is significantly more cost-effective than acquiring new ones.
This project analyzes customer behavior using SQL to identify key factors associated with churn and provide actionable business insights to improve customer retention.
---

Business Problem

The bank is facing a significant churn problem driven primarily by low customer engagement, especially among customers with only one product and low activity levels.
---

## Dataset

* Source: Bank Customer Churn Dataset
* Records: ~10,000 customers
* Features include:
  * Customer demographics (age, gender, country)
  * Account information (balance, products)
  * Engagement metrics (active_member)
  * Target variable (churn)

---

##Tools Used

* SQL Server
* SQL (Data Analysis)

---

## Key Analysis & Insights

### 1. Overall Churn Rate

```sql
SELECT 
    COUNT(*) AS Total_Clientes,
    SUM(CAST(churn AS INT)) AS clientes_que_se_fueron,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS tasa_churn
FROM [Bank Customer Churn Prediction];
```

**Insight:**

* The churn rate is approximately **20%**
* This means **1 in 5 customers leave the bank**, indicating a significant retention issue

---

### 2. Churn by Number of Products

```sql
SELECT 
    products_number,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM [Bank Customer Churn Prediction]
GROUP BY products_number
ORDER BY churn_rate DESC;
```

**Insight:**

* Customers with **2 products have the lowest churn (~7.6%)**
* Customers with **only 1 product have significantly higher churn (~27%)**
* Customers with 3–4 products show higher churn, likely due to small sample sizes or product mismatch

**Conclusion:** There is an optimal engagement level around **2 products**

---

### 3. Churn by Customer Activity

```sql
SELECT 
    active_member,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM [Bank Customer Churn Prediction]
GROUP BY active_member;
```

**Insight:**

* Inactive customers: **~27% churn**
* Active customers: **~14% churn**

**Conclusion:** Customer engagement is strongly associated with retention
---

### 4. Combined Analysis (Products + Activity)

```sql
SELECT 
    products_number,
    active_member,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM [Bank Customer Churn Prediction]
GROUP BY products_number, active_member
ORDER BY churn_rate DESC;
```

**Insight:**
* Highest reliable churn:
  * Customers with **1 product + inactive (~36%)**
* Lowest churn:
  * Customers with **2 products + active (~5.5%)**

 **Conclusion:**
Low engagement + low product usage = highest churn risk

---

### 5. Churn by Age Group

```sql
SELECT 
    CASE 
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle Age'
        ELSE 'Older'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(SUM(CAST(churn AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM [Bank Customer Churn Prediction]
GROUP BY 
    CASE 
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle Age'
        ELSE 'Older'
    END
ORDER BY churn_rate DESC;
```

**Insight:**

* Older customers: **~44.6% churn (highest risk)**
* Middle-aged customers: largest group and highest total churn
* Young customers: lowest churn (~7.5%)

**Conclusion:**
Older customers are the most vulnerable, while middle-aged customers drive the largest business impact

---

## Final Conclusions

* Churn is strongly associated with **low engagement and limited product usage**
* Customers with:

  * **1 product**
  * **Low activity**
  * **Older age group**

  are the most at risk

---

## Business Recommendations

* Increase customer engagement (focus on inactive users)
* Promote cross-selling strategies to reach **at least 2 products per customer**
* Develop targeted retention strategies for **older customers**
* Monitor high-risk segments (1 product + inactive)

---

## Key Takeaway

> Customer engagement and optimal product adoption are the strongest levers to reduce churn in this dataset.

---

## Future Improvements

* Build a dashboard in Power BI
* Apply machine learning models to predict churn
* Perform deeper segmentation (income, geography, etc.)
