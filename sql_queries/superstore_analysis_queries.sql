-- ======================================
-- KPI QUERIES
-- ======================================
SELECT 
	ROUND(SUM(sales),2) AS total_revenue,
	ROUND(SUM(profit),2) AS total_profit,
	ROUND(SUM(profit)*100.0 / NULLIF(SUM(sales),0),2) AS profit_margin_in_percentage,
	SUM(quantity) AS total_unit_sold,
	COUNT(DISTINCT(order_id)) AS total_orders,
	ROUND(SUM(sales) / COUNT(DISTINCT(order_id)),2) AS avg_order_value,
	COUNT(DISTINCT(customer_id)) AS total_unique_customer
FROM superstore_sales;

-- ======================================
-- CATEGORY ANALYSIS
-- ======================================
SELECT
	category,
	ROUND(SUM(sales),2) AS total_revenue,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- ======================================
-- TOP 5 PRODUCTS BY REVENUE
-- ======================================
SELECT
	product_name,
	ROUND(SUM(sales),2) AS total_revenue,
	SUM(quantity) AS total_unit_sold
FROM superstore_sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- ======================================
-- TOP 5 CUSTOMERS BY REVENUE
-- ======================================
SELECT
	customer_name,
	ROUND(SUM(sales),2) AS total_revenue,
	SUM(quantity) AS total_unit_sold,
	ROUND(SUM(sales) / COUNT(DISTINCT(order_id)),2) AS avg_order_value
FROM superstore_sales
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 5;

-- ======================================
-- Sales by Region
-- ======================================
SELECT
	region,
	ROUND(SUM(sales),2) AS total_revenue,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore_sales
GROUP BY region
ORDER BY total_revenue DESC
LIMIT 10;

-- ======================================
-- Monthly Sales Trend
-- ======================================
SELECT
	DATE_TRUNC('month', order_date)::DATE AS month_date,
	ROUND(SUM(sales), 2) AS total_revenue
FROM superstore_sales
GROUP BY month_date
ORDER BY month_date;

-- ======================================
-- Discount Impact Analysis
-- ======================================
SELECT
	discount,
	COUNT(*) AS total_orders,
	ROUND(SUM(sales), 2) AS total_revenue,
	ROUND(SUM(profit), 2) AS total_profit,
	ROUND(SUM(profit) * 100.0 / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_sales
GROUP BY discount
ORDER BY discount;









