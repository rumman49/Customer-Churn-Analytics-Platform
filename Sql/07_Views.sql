-- Active: 1784984612094@@127.0.0.1@3306@superstore_db
-- ==========================================================
-- SQL VIEWS
-- ==========================================================

-- Question 1:
-- Create a view that shows total sales and total profit for each category.
CREATE OR REPLACE VIEW category_performance AS
SELECT 
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY category;

-- Question 2:
-- Create a view that displays customer-wise total sales, total profit, and total orders.
CREATE OR REPLACE VIEW customer_report AS
SELECT 
    customer_name,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY customer_name;

-- Question 3:
-- Create a view showing region-wise sales and profit.
CREATE OR REPLACE VIEW region_performance AS
SELECT 
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region;

-- Question 4:
-- Create a view containing the top 10 customers based on total sales.
CREATE OR REPLACE VIEW top_customers AS
SELECT 
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Question 5:
-- Create a view that summarizes product performance with total sales, total profit, and total quantity sold.
CREATE OR REPLACE VIEW product_performance AS
SELECT 
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold
FROM orders
GROUP BY product_name;

