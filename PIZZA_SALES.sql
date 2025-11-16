SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

CREATE DATABASE PIZZA_DB;
USE PIZZA_DB;


CREATE TABLE pizza_sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(100),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

SET sql_mode='';  


TRUNCATE TABLE pizza_sales;

LOAD DATA LOCAL INFILE 'C:/Users/hp/Desktop/pizza_sales_fixed.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(pizza_id, order_id, pizza_name_id, quantity, @order_date, order_time,
 unit_price, total_price, pizza_size, pizza_category, pizza_ingredients, pizza_name)
SET order_date = STR_TO_DATE(@order_date, '%Y-%m-%d');




SELECT*
FROM PIZZA_SALES;

SELECT SUM(total_price) AS TOTAL_REVENUE
FROM PIZZA_SALES;

SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS AVERAGE_ORDER_VALUE
FROM PIZZA_SALES;

SELECT SUM(quantity) AS TOTAL_PIZZA_SOLD
FROM PIZZA_SALES;

SELECT COUNT(DISTINCT order_id) AS TOTAL_ORDERS_PLACED
FROM PIZZA_SALES;

SELECT SUM(quantity)/COUNT(DISTINCT ORDER_ID) AS AVERAGE_PIZZAS_PER_ORDER
FROM PIZZA_SALES;

DESCRIBE PIZZA_SALES;

SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY DAYNAME(order_date);


SELECT monthname(order_date) AS month_name, COUNT(DISTINCT order_id) AS TOTAL_ORDERS 
FROM PIZZA_SALES
GROUP BY monthname(order_date)
ORDER BY TOTAL_ORDERS DESC;


SELECT*
FROM PIZZA_SALES;


SELECT pizza_category,SUM(TOTAL_PRICE) AS TOTAL_SALES, SUM(total_price)*100/ (SELECT SUM(total_price)
FROM PIZZA_SALES WHERE MONTH(order_date) = 1) AS PCT
FROM PIZZA_SALES
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

SELECT*
FROM PIZZA_SALES;

SELECT pizza_size, SUM(total_price) AS TOTAL_SALES, SUM(total_price) * 100/ (SELECT SUM(total_price)
FROM PIZZA_SALES)  AS PCT_SIZE
FROM PIZZA_SALES
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_SIZE DESC;


SELECT pizza_name , SUM(total_price) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE DESC
LIMIT 5;

SELECT pizza_name, SUM(total_price) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE ASC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS TOTAL_QUANTITY
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY TOTAL_QUANTITY DESC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS TOTAL_QUANTITY
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY TOTAL_QUANTITY ASC
LIMIT 5;


SELECT pizza_name, COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY TOTAL_ORDERS DESC
LIMIT 5;


SELECT pizza_name, COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY TOTAL_ORDERS ASC
LIMIT 5;
