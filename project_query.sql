-- Pizza Sales Data Analysis Project
-- Author: SUJEET CHOURASIA
-- Tool Used: MySQL Workbench

-- ---------------------------------------------------------
-- BASIC ANALYSIS
-- ---------------------------------------------------------

-- 1. Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, pizzas.pizza_id, SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name,  pizzas.pizza_id
ORDER BY total_quantity DESC
LIMIT 5;

-- ---------------------------------------------------------
-- INTERMEDIATE ANALYSIS
-- ---------------------------------------------------------

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- 7. Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS busy_hours, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time)
ORDER BY order_count DESC;

-- 8. Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY category;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.
WITH order_quantity AS (
    SELECT 
    orders.order_date, SUM(order_details.quantity) AS sum_of_quantity
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_date)

SELECT 
    round(AVG(sum_of_quantity),0) AS average_pizzas_ordered
FROM
    order_quantity;
    
-- 10. Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    pizza_types.pizza_type_id,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id 
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.pizza_type_id , pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;

-- ---------------------------------------------------------
-- ADVANCED ANALYSIS
-- ---------------------------------------------------------

-- 11. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.name,
    pizza_types.pizza_type_id,
    ROUND(SUM(order_details.quantity * pizzas.price) * 100 / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id),
            2) AS revenue_percentage,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.pizza_type_id , pizza_types.name
ORDER BY total_revenue DESC ; 

-- 12. Analyze the cumulative revenue generated over time.
SELECT order_date,
SUM(revenue) OVER(ORDER BY order_date) as cum_revenue
FROM
(SELECT orders.order_date,
SUM(order_details.quantity * pizzas.price) as revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) as sales;

-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
 SELECT name, total_revenue FROM
 
 (SELECT category , name , total_revenue, RANK() OVER( PARTITION BY category
 ORDER BY total_revenue DESC) AS rn
 FROM
 
 (SELECT 
    pizza_types.name,
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id 
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn<=3;