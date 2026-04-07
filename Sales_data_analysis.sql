-- =========================================================
-- SQL Data Analysis Project
-- This project analyses customer orders and spending behaviour
-- using SQL queries such as joins, aggregations, filtering,
-- and subqueries.
-- Dataset:
-- orders1 (order_id, customer_id, order_date, amount)
-- customers1 (customer_id, first_name, last_name, city, country)
-- =========================================================


-- 1. Total Spending by Country
SELECT 
    c.country,
    SUM(o.amount) AS total_spending
FROM orders1 o
INNER JOIN customers1 c 
    ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_spending DESC;


-- 2. Customer Order Count and Total Spending
SELECT 
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM customers1 c
INNER JOIN orders1 o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC;


-- 3. Top 5 Customers by Number of Orders
SELECT 
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers1 c
INNER JOIN orders1 o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;


-- 4. Average Spending by City
SELECT 
    c.city,
    AVG(o.amount) AS avg_spending
FROM customers1 c
INNER JOIN orders1 o 
    ON c.customer_id = o.customer_id
GROUP BY c.city;


-- 5. High-Value Transactions (>= 500)
SELECT 
    c.first_name,
    c.last_name,
    o.amount
FROM customers1 c
INNER JOIN orders1 o 
    ON c.customer_id = o.customer_id
WHERE o.amount >= 500;


-- 6. Orders in 2024
SELECT 
    c.first_name,
    c.last_name,
    o.order_date
FROM customers1 c
INNER JOIN orders1 o 
    ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2024;


-- 7. Highest Spending per Customer (Subquery)
SELECT 
    c.first_name,
    c.last_name,
    o.amount AS max_amount
FROM orders1 o
INNER JOIN customers1 c 
    ON o.customer_id = c.customer_id
WHERE o.amount = (
    SELECT MAX(amount)
    FROM orders1
    WHERE customer_id = o.customer_id
);