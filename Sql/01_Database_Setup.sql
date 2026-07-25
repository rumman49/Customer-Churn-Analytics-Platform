
-- create database 
CREATE DATABASE superstore_db;

-- 1. Select the database
USE superstore_db;

-- Create Table Schema For the Dataset
CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2),
    cost DECIMAL(12,2),
    profit_margin DECIMAL(5,2),
    shipping_days INT,
    order_year INT,
    order_month INT,
    order_quarter INT,
    order_days INT
);

-- uploaded the Featured_superstore.csv in orders table 
SELECT * FROM orders