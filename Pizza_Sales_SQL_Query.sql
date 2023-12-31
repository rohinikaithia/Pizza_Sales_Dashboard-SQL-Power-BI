--KPI's Requirement 

--1.Total Revenue- (Sum of all orders)
SELECT SUM(total_price) AS Total_Revenue from pizza_sales

--2. Average Order Value- (i.e. Avg amount spent per order, Total revenue/total no. of orders)
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales

--3. Total pizza sold
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales

--4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_orders from pizza_sales

--5. Average pizzas per order- (total num of pizzas sold/total num of orders)
SELECT SUM(quantity)/COUNT(DISTINCT order_id) from pizza_sales -- gives the round of result
-- CAST is used to get decimal value, DECIMAL(10,2) means in result we get 10 decimal values, & from that 10 we want 2 values after decimal
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_order from pizza_sales 

--CHARTS REQUIREMENT 1
--1) Daily trend for total orders
SELECT DATENAME(DW,order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders 
from pizza_sales
GROUP BY DATENAME(DW,order_date)

--2) Monthly Trend for total orders
SELECT DATENAME(MONTH,order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_orders DESC

--3) Percentage of sales by pizza category
SELECT pizza_category, SUM(total_price)*100/ (SELECT SUM(total_price) from pizza_sales) AS PCT
from pizza_sales 
GROUP BY pizza_category

SELECT pizza_category,sum(total_price) AS Total_Sales, SUM(total_price)*100/ (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date)=1) AS PCT
from pizza_sales                                                              --Apply the where clause in above subquery as well
WHERE MONTH(order_date)=1 -- gives value for Jan month
GROUP BY pizza_category

--4) Percentage of sales by Pizza Size:
SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price)*100/ (SELECT SUM(total_price) from pizza_sales ) AS DECIMAL(10,2)) AS PCT
from pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

--FOR 1st Quarter
SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price)*100/ 
(SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter,order_date)=1) AS DECIMAL(10,2)) AS PCT
from pizza_sales
WHERE DATEPART(quarter,order_date)=1  --WHERE clause before GROUP BY
GROUP BY pizza_size
ORDER BY PCT DESC

--5) Total pizzas sold by pizza category
SELECT pizza_category, SUM(quantity) AS Total_pizzas_sold from pizza_sales
GROUP BY pizza_category
ORDER BY Total_pizzas_sold DESC 

--6) Top 5 best sellers by Revenue, total quantity and total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_revenue from pizza_sales 
GROUP BY pizza_name
ORDER BY Total_revenue DESC

--Bottom 5
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_revenue from pizza_sales 
GROUP BY pizza_name
ORDER BY Total_revenue ASC --if you dont write ASC also, sql takes it asc by default

--top 5 sellers by total quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--top 5 sellers by total orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC





