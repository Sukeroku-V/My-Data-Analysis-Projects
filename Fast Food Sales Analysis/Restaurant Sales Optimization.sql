SELECT *
FROM Balaji_Fast_Food_Sales

--Dropping null values rows
DELETE FROM Balaji_Fast_Food_Sales
WHERE transaction_type = '';

--Analyzing sales trends over time
SELECT  FORMAT(CAST(date AS DATE), 'yyyy-MM') AS month, item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
GROUP BY FORMAT(CAST(date AS DATE), 'yyyy-MM'), item_name, item_type
ORDER BY Revenue DESC;

--Customers Preferences for Different Items
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
GROUP BY item_name, item_type
ORDER BY Revenue DESC;

--Evaluating the impact of payment methods on Revenue
SELECT transaction_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
GROUP BY transaction_type
ORDER BY Revenue DESC;

--Investigating the preferences of males and females customers
--For males
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE received_by = 'Mr.'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;
--For Females
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE received_by = 'Mrs.'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;

--Finding out which time of the day the store is at its peak revenue
SELECT time_of_sale, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
GROUP BY time_of_sale
ORDER BY Revenue DESC;

--Exploring the popularity of items during different times of the day
--Night
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE time_of_sale = 'Night'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;
--Afternoon
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE time_of_sale = 'Afternoon'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;
--Evening
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE time_of_sale = 'Evening'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;
--Morning
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE time_of_sale = 'Morning'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;
--Midnight
SELECT item_name, item_type, SUM(CAST(transaction_amount AS DECIMAL(10, 2)))  AS Revenue
FROM Balaji_Fast_Food_Sales
WHERE time_of_sale = 'Midnight'
GROUP BY item_name, item_type
ORDER BY Revenue DESC;
