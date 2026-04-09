# 📊 Superstore Sales Analysis – Detailed Insights

## 🧠 Project Approach
This analysis follows a structured workflow:
1. Business KPI Evaluation  
2. Category and Product Analysis  
3. Customer Segmentation  
4. Regional Performance Analysis  
5. Time-Series Trend Analysis  
6. Discount Impact Evaluation  

## 📌 Overall Business Performance (KPI)
The business generated **$12.6M in total revenue** and **$1.5M in profit**, resulting in a **profit margin of 11.61%**, indicating a healthy and sustainable operation.

A total of **178K units** were sold across **25K orders**, with an **average order value of $504.99**. The business served **1,590 unique customers**, demonstrating a stable and active customer base.

<details>
<summary>View SQL Query</summary>

```sql
SELECT 
	ROUND(SUM(sales),2) AS total_revenue,
	ROUND(SUM(profit),2) AS total_profit,
	ROUND(SUM(profit)*100.0 / NULLIF(SUM(sales),0),2) AS profit_margin_in_percentage,
	SUM(quantity) AS total_unit_sold,
	COUNT(DISTINCT(order_id)) AS total_orders,
	ROUND(SUM(sales) / COUNT(DISTINCT(order_id)),2) AS avg_order_value,
	COUNT(DISTINCT(customer_id)) AS total_unique_customer
FROM superstore_sales;
```
</details>

<details>
<summary>View Sample Result</summary>  
    
| total_revenue | total_profit | profit_margin_% | total_units | total_orders | avg_order_value | unique_customers |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| $12,642,501.91 | $1,467,457.29 | 11.61% | 178,312 | 25,035 | $504.99 | 1,590 |

</details>

## 🛍️ Revenue VS Profit by Category
The **Technology category** is the strongest performer, generating **$4.7M in revenue** and **$663K in profit**.

Although **Furniture** generates higher revenue than Office Supplies, it produces significantly lower profit, indicating **higher costs or lower margins**.

In contrast, **Office Supplies** demonstrates stronger profitability efficiency, suggesting better margin control.

👉 **Insight:** High revenue does not always translate to high profit.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
	category,
	ROUND(SUM(sales),2) AS total_revenue,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore_sales
GROUP BY category
ORDER BY total_revenue DESC;
```
</details>

<details>
<summary>View Sample Result</summary>  

| category | total_revenue | total_profit |
| :--- | :---: | :---: |
| **Technology** | $4.74M | $663.8K |
| **Furniture** | $4.11M | $285.2K |
| **Office Supplies** | $3.79M | $518.5K |

</details>

## 📦 Top Products Analysis
Top-performing products include **smartphones and high-value office equipment**.

- Smartphones drive revenue through **high sales volume**
- The **Canon imageCLASS Copier** generates high revenue with **low unit sales**, indicating a **price-driven product**

👉 **Insight:** Revenue is driven by both **volume-based and high-margin products**, creating a balanced sales mix.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
	product_name,
	ROUND(SUM(sales),2) AS total_revenue,
	SUM(quantity) AS total_unit_sold
FROM superstore_sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;
```
</details>

<details>
<summary>View Sample Result</summary>  
    
| product_name | total_revenue | total_unit_sold |
| :--- | :---: | :---: |
| Apple Smart Phone, Full Size | $86.9K | 171 |
| Cisco Smart Phone, Full Size | $76.4K | 139 |
| Motorola Smart Phone, Full Size | $73.2K | 134 |
| Nokia Smart Phone, Full Size | $71.9K | 147 |
| Canon imageCLASS 2200 Advanced Copier | $61.6K | 20 |

</details>

## 👥 Customer Analysis
A small group of top customers contributes a significant portion of total revenue.

Two distinct behaviors are observed:
- **High-volume buyers** (frequent purchases)
- **High-value buyers** (higher spend per order)

👉 **Insight:** Customer segmentation can improve targeting strategies (e.g., loyalty vs premium offers).

<details>
<summary>View SQL Query</summary>

```sql
SELECT
	customer_name,
	ROUND(SUM(sales),2) AS total_revenue,
	SUM(quantity) AS total_unit_sold,
	ROUND(SUM(sales) / COUNT(DISTINCT(order_id)),2) AS avg_order_value
FROM superstore_sales
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 5;
```
</details>

<details>
<summary>View Sample Result</summary>  
    
| customer_name | total_revenue | total_unit_sold | avg_order_value |
| :--- | :---: | :---: | :---: |
| Tom Ashbrook | $40.5K | 284 | $1.35K |
| Tamara Chand | $37.5K | 271 | $1.04K |
| Greg Tran | $35.6K | 310 | $1.05K |
| Christopher Conant | $35.2K | 287 | $0.90K |
| Sean Miller | $35.2K | 169 | $1.26K |

</details>

## 🌍 Regional Performance
The **Central region** leads in both revenue and profit, making it the primary growth driver.

However, regions like **Southeast Asia and EMEA** show weaker profitability despite moderate revenue.

👉 **Insight:** Some regions may suffer from **pricing inefficiencies or higher operational costs**.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
	region,
	ROUND(SUM(sales),2) AS total_revenue,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore_sales
GROUP BY region
ORDER BY total_revenue DESC
LIMIT 10;
```
</details>

<details>
<summary>View Sample Result</summary>  
    
| region | total_revenue | total_profit |
| :--- | :---: | :---: |
| Central | $2.82M | $311.4K |
| South | $1.60M | $140.4K |
| North | $1.25M | $194.6K |
| Oceania | $1.10M | $120.1K |
| Southeast Asia | $884.4K | $17.9K |
| North Asia | $848.3K | $165.6K |
| EMEA | $806.2K | $43.9K |
| Africa | $783.8K | $88.9K |
| Central Asia | $752.8K | $132.5K |
| West | $725.5K | $108.4K |

</details>

## 📈 Sales Trend Over Time
Sales show a clear **upward trend with strong seasonality**.

- Peak months: **November and December**
- Highest monthly revenue: **~$509K**

👉 **Insight:** Sales are heavily influenced by **year-end demand and holiday seasonality**.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
	DATE_TRUNC('month', order_date)::DATE AS month_date,
	ROUND(SUM(sales), 2) AS total_revenue
FROM superstore_sales
GROUP BY month_date
ORDER BY month_date;
```
</details>

<details>
<summary>View Sample Result</summary>  
    
| month_date | total_revenue |
| :--- | :---: |
| 2011-01-01 | $138.2K |
| 2011-02-01 | $135.0K |
| 2011-03-01 | $171.5K |
| ... | ... |
| 2012-12-01 | $292.0K |
| 2013-01-01 | $206.5K |
| ... | ... |
| 2014-10-01 | $406.7K |
| 2014-11-01 | $509.0K |
| 2014-12-01 | $427.8K |

</details>

## 💸 Discount Impact Analysis
Discounting has a **significant negative impact on profitability**.

- **0–10% discount** → healthy margins (~16%–25%)  
- **20%+ discount** → sharp margin decline  
- **30%+ discount** → often results in **losses**

👉 **Insight:** Excessive discounting drives revenue but **destroys profitability**.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
	discount,
	COUNT(*) AS total_orders,
	ROUND(SUM(sales), 2) AS total_revenue,
	ROUND(SUM(profit), 2) AS total_profit,
	ROUND(SUM(profit) * 100.0 / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_sales
GROUP BY discount
ORDER BY discount;
```
</details>

<details>
<summary>View Sample Result</summary>  
    
| discount | total_orders | total_revenue | total_profit | profit_margin_pct |
| :--- | :---: | :---: | :---: | :---: |
| 0 | 29,009 | $6.99M | $1.77M | 25.32% |
| 0.002 | 461 | $261.4K | $58.0K | 22.18% |
| 0.1 | 4,068 | $1.58M | $259.1K | 16.40% |
| ... | ... | ... | ... | ... |
| 0.202 | 41 | $16.2K | -$0.6K | -3.67% |
| 0.4 | 3,177 | $559.5K | -$143.7K | -25.69% |
| ... | ... | ... | ... | ... |
| 0.8 | 316 | $20.5K | -$38.6K | -188.71% |
| 0.85 | 2 | $0.8K | -$3.1K | -385.10% |

</details>

## 🧾 Final Conclusion
The business demonstrates strong overall performance with solid revenue, profitability, and customer activity. Growth is driven by high-performing categories, key products, and seasonal demand.

However, several optimization opportunities exist:
- Improve margins in low-profit categories (Furniture)  
- Optimize underperforming regions  
- Control excessive discounting  
- Leverage customer segmentation strategies  

👉 **Final Takeaway:** Sustainable growth will depend on balancing **revenue generation with profitability optimization**.


