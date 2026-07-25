-- Active: 1784984612094@@127.0.0.1@3306@superstore_db
-- ==========================================================
-- BUSINESS ANALYSIS QUERIES
-- ==========================================================

-- Question 1:
-- Find the top 10 customers based on total sales.
SELECT 
    customer_name,
    ROUND(SUM(sales)) as total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Question 2:
-- Find the top 10 customers based on total profit.
SELECT 
    customer_name,
    ROUND(SUM(profit)) as total_profit
FROM orders
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- Question 3:
-- Find the top 10 best-selling products based on total sales.
SELECT 
    product_name,
    ROUND(SUM(sales)) as total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Question 4:
-- Find the top 10 most profitable products.
SELECT 
    product_name,
    ROUND(SUM(profit)) as total_profit
FROM orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Question 5:
-- Find the bottom 10 products with the lowest profit.
SELECT 
    product_name,
    ROUND(SUM(profit)) as total_profit
FROM orders
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;

-- Question 6:
-- Identify the state that generated the highest total sales.
SELECT 
    state,
    ROUND(SUM(sales)) as total_sales
FROM orders
GROUP BY state
ORDER BY total_sales DESC;

-- Question 7:
-- Identify the state that generated the highest total profit.
SELECT 
    product_name,
    ROUND(SUM(profit)) as total_profit
FROM orders
GROUP BY product_name
ORDER BY total_profit DESC;

-- Question 8:
-- Find the most profitable sub-category.
SELECT 
    sub_category,
    ROUND(SUM(profit)) as total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 10;

-- Question 9:
-- Find the least profitable sub-category.
SELECT 
    sub_category,
    ROUND(SUM(profit)) as loss
FROM orders
GROUP BY sub_category
ORDER BY loss ASC
LIMIT 10;

-- Question 10:
-- Which customer segment contributes the highest total sales and profit?
SELECT 
    sub_category,
    ROUND(SUM(profit)) as total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 10;