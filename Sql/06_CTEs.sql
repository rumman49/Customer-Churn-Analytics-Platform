-- ==========================================================
-- CTE (Common Table Expression) QUERIES
-- ==========================================================

-- Question 1:
-- Using a CTE, find the top 10 customers based on total sales.
WITH top_customers as (
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
)

SELECT
    customer_name,
    total_sales
from top_customers
ORDER BY total_sales DESC
-- LIMIT 10
;

-- Question 2:
-- Using a CTE, calculate the average sales for each category and display only the categories with above-average sales.

WITH category_avg_sales AS (
SELECT 
    category,
    AVG(sales) AS avg_sales
FROM orders
GROUP BY category
)

SELECT
    category,
    avg_sales
from category_avg_sales
where avg_sales > (SELECT AVG(sales) FROM orders)
ORDER BY avg_sales DESC;


-- Question 3:
-- Using a CTE, find the products whose total profit is below the overall average product profit.

-- Question 4:
-- Using a CTE, calculate total sales for each region and rank the regions from highest to lowest sales.

-- Question 5:
-- Using a CTE, identify customers whose total sales are greater than the overall average customer sales.