-- Create Databse
CREATE DATABASE IF NOT EXISTS Walmart_Sales;

-- Create Table 
CREATE TABLE IF NOT EXISTS Sales(
	inovice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Fixing the dataset
SELECT time, CASE
           WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
           WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
           ELSE 'Evening'
           END
           AS time_of_date
FROM sales;
-- WE ADD THE COLUMN NOW THEN ITS DATA
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(10);
UPDATE sales
SET time_of_day = CASE
           WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
           WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
           ELSE 'Evening'
           END;
           
-- add the day name
SELECT date, DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- add the month name
SELECT date, MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- Let's explore the data now!

-- branches in cities
SELECT DISTINCT city, branch
FROM sales;

-- the most common payment method
SELECT payment, COUNT(payment) AS count
FROM sales
GROUP BY payment
ORDER BY count DESC
LIMIT 1;

-- total revenue by month
SELECT month_name AS month, SUM(total) AS revenue
FROM sales
GROUP BY month
ORDER BY revenue DESC;

-- product line with the largest revenue for both genders
-- for men
SELECT product_line, SUM(total) AS revenue
FROM sales
WHERE gender = 'Male'
GROUP BY product_line
ORDER BY revenue DESC
LIMIT 1;
-- for women 
SELECT product_line, SUM(total) AS revenue
FROM sales
WHERE gender = 'Female'
GROUP BY product_line
ORDER BY revenue DESC
LIMIT 1;

-- top 5 product line taxes
SELECT product_line, AVG(tax_pct) AS tax
FROM sales
GROUP BY product_line
ORDER BY tax DESC
LIMIT 5;

-- branch that sold products more than the average
SELECT branch, SUM(quantity) AS sold
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- average rating for each product line
SELECT product_line, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- good or bad products?
SELECT product_line, ROUND(AVG(total),2) AS avg_sales,
CASE
WHEN AVG(total) > (SELECT AVG(total) FROM sales) THEN "Good"
ELSE "Bad"
END AS Remarks
FROM sales
GROUP BY product_line;

-- sales for each time of the day
SELECT time_of_day, COUNT(total) sales_made
FROM sales
GROUP BY time_of_day
ORDER BY sales_made DESC;

-- gender distibution for each branch
-- A
SELECT gender, COUNT(*) AS num_of_customers
FROM sales
WHERE branch = 'A'
GROUP BY gender
ORDER BY num_of_customers DESC;
-- B
SELECT gender, COUNT(*) AS num_of_customers
FROM sales
WHERE branch = 'B'
GROUP BY gender
ORDER BY num_of_customers DESC;
-- C
SELECT gender, COUNT(*) AS num_of_customers
FROM sales
WHERE branch = 'C'
GROUP BY gender
ORDER BY num_of_customers DESC;

-- time of day when customers give best ratings
SELECT time_of_day, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- day of the week with the best rating
SELECT day_name, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC
LIMIT 1;
