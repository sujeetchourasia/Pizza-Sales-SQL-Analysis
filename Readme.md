# Pizza Sales SQL Analysis Project

## 📌 Project Overview
This project involves analyzing pizza sales data to gain insights into business performance. The analysis is performed using **SQL (MySQL)** to answer critical business questions regarding orders, revenue, and pizza popularity.

## 📂 Database Schema
The analysis is based on four relational tables:
* **`orders`**: Contains order ID, date, and time.
* **`order_details`**: Contains order details, quantity, and pizza ID.
* **`pizzas`**: Contains pizza price, size, and links to pizza types.
* **`pizza_types`**: Contains pizza names, categories, and ingredients.

## 🛠️ Tech Stack
* **Database:** MySQL
* **Language:** SQL
* **Tools:** MySQL Workbench

## 🔍 Key Business Questions Solved
I structured the analysis into three levels of complexity to demonstrate a range of SQL skills.

### 🟢 Basic Analysis
* Retrieve the total number of orders placed.
* Calculate the total revenue generated from pizza sales.
* Identify the highest-priced pizza.
* Identify the most common pizza size ordered.
* List the top 5 most ordered pizza types along with their quantities.

### 🟡 Intermediate Analysis
* Join the necessary tables to find the total quantity of each pizza category ordered.
* Determine the distribution of orders by hour of the day.
* Join relevant tables to find the category-wise distribution of pizzas.
* Group the orders by date and calculate the average number of pizzas ordered per day.

### 🔴 Advanced Analysis
* **Calculate percentage contribution:** Calculated the percentage contribution of each pizza type to total revenue.
* **Analyze cumulative revenue:** Generated a running total of revenue over time to track business growth.
* **Determine top 3 best sellers:** Identified the top 3 most ordered pizza types based on revenue for each pizza category.

## 📈 Key Insights & Findings
* **Peak Hours:** The store sees the highest volume of orders at 12:00 PM and 6:00 PM.
* **Category Performance:** The "Classic" category contributes to the highest total quantity of orders.
* **Best Sellers:** The "Thai Chicken Pizza" is the highest revenue-generating pizza.
* **Sales Trends:** Fridays exhibit a strong cumulative revenue growth pattern.

## 🚀 How to Use
1.  Clone this repository.
2.  Import the raw CSV files (or execute the schema creation script) into your SQL database.
3.  Open the `.sql` file to view the queries and execute them to reproduce the analysis.

---
*Author: SUJEET CHOURASIA*

*Connect with me on LinkedIn: https://www.linkedin.com/in/sujeet-chourasia-556886294/*