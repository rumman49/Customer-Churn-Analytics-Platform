-- Active: 1784984612094@@127.0.0.1@3306@superstore_db

-- 1- Display all records.
SELECT * FROM orders;

-- 2- Show unique categories.
SELECT DISTINCT
    category
FROM orders;

-- 3- Find all orders from the West region.
SELECT
    *
FROM orders
WHERE region = 'west';

-- 4- Show products with sales greater than 500.
SELECT 
    * 
FROM orders
WHERE sales > 500;

-- 5- Find orders with negative profit.
SELECT
    *
FROM orders
WHERE profit < 0;

-- 6- Display orders with discount greater than 20%.
SELECT 
    *
FROM orders
WHERE discount > 0.20;

-- 7- Show all Technology products.
SELECT 
    category,
    product_name
FROM orders
WHERE category = 'Technology';

-- 8- Find all Corporate customers.
SELECT 
    customer_name,
    segment
FROM orders
WHERE segment = 'Corporate';

-- 9- Display the top 10 highest sales.
SELECT
   *
FROM orders
ORDER BY sales DESC;

-- 10- Find products shipped using First Class.
SELECT
    *
FROM orders
WHERE ship_mode = 'First Class';