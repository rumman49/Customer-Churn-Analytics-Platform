-- Active: 1784984612094@@127.0.0.1@3306@superstore_db
-- ==========================================================
-- WINDOW FUNCTION QUERIES
-- ==========================================================

-- Question 1:
-- Rank all customers based on their total sales using RANK().
SELECT 
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER(ORDER BY SUM(sales) DESC) AS sales_rank
FROM orders
GROUP BY customer_name;

-- Question 2:
-- Assign a row number to each order within every region based on sales (highest to lowest).
SELECT 
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROW_NUMBER() OVER(ORDER BY ROUND(SUM(sales),2) DESC) AS row_numberr
FROM orders
GROUP BY region;

-- Question 3:
-- Find the top-selling product in each category using ROW_NUMBER().
SELECT 
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROW_NUMBER() OVER(ORDER BY ROUND(SUM(sales),2) DESC) AS row_numberr
FROM orders
GROUP BY product_name;

-- Question 4:
-- Calculate a running total of sales ordered by order date.
SELECT 
    product_name,
    sales,
    sum(sales) OVER(ORDER BY order_date) AS running_total
FROM orders

-- Question 5:
-- Rank products within each category based on total profit using DENSE_RANK().
SELECT 
    category,
    product_name,
    SUM(profit),
    DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(profit) desc) as profit_rank
FROM orders
GROUP BY category, product_name;

-- Question 6:
-- Find the top 3 customers by total profit in each region.
SELECT 
    customer_name,
    region,
    sum(profit) as total_profit,
    RANK() OVER(PARTITION BY region ORDER BY SUM(profit) desc) as profit_rank
FROM orders
GROUP BY customer_name, region

-- Question 7:
-- Display the previous order's sales for each customer using LAG().
SELECT 
    customer_name,
    SUM(profit) AS total_profit,
    LAG(SUM(profit)) OVER(PARTITION BY customer_name ORDER BY order_date) AS previous_order_profit
FROM orders
GROUP BY customer_name, order_date;

-- Question 8:
-- Display the next order's sales for each customer using LEAD().
SELECT 
    customer_name,
    SUM(sales) AS total_sales,
    LEAD(SUM(sales)) OVER(PARTITION BY customer_name ORDER BY order_date) AS next_order_sales
FROM orders
GROUP BY customer_name, order_date;

-- Question 9:
-- Compare each order's sales with the average sales of its category.
SELECT 
    category,
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(AVG(SUM(sales)) OVER(PARTITION BY category),2) AS avg_category_sales
FROM orders
GROUP BY category, product_name;

-- Question 10:
-- Divide customers into four groups based on total sales using NTILE(4).
SELECT 
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    NTILE(4) OVER(ORDER BY SUM(sales) DESC) AS sales_quartile
FROM orders
GROUP BY customer_name;
