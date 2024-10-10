SELECT *
FROM Sales

--Most Profitable Months in every Year
--2011
SELECT Month, Year, CAST(SUM(CAST(Profit AS DECIMAL(10, 0))) AS DECIMAL(10, 0)) AS Total_Profit
FROM Sales
WHERE Year = 2011
GROUP BY Month, Year
ORDER BY Total_Profit DESC;
--2012
SELECT Month, Year, CAST(SUM(CAST(Profit AS DECIMAL(10, 0))) AS DECIMAL(10, 0)) AS Total_Profit
FROM Sales
WHERE Year = 2012
GROUP BY Month, Year
ORDER BY Total_Profit DESC;
--2013
SELECT Month, Year, CAST(SUM(CAST(Profit AS DECIMAL(10, 0))) AS DECIMAL(10, 0)) AS Total_Profit
FROM Sales
WHERE Year = 2013
GROUP BY Month, Year
ORDER BY Total_Profit DESC;
--2014
SELECT Month, Year, CAST(SUM(CAST(Profit AS DECIMAL(10, 0))) AS DECIMAL(10, 0)) AS Total_Profit
FROM Sales
WHERE Year = 2014
GROUP BY Month, Year
ORDER BY Total_Profit DESC;
--2015
SELECT Month, Year, CAST(SUM(CAST(Profit AS DECIMAL(10, 0))) AS DECIMAL(10, 0)) AS Total_Profit
FROM Sales
WHERE Year = 2015
GROUP BY Month, Year
ORDER BY Total_Profit DESC;
--2016
SELECT Month, Year, CAST(SUM(CAST(Profit AS DECIMAL(10, 0))) AS DECIMAL(10, 0)) AS Total_Profit
FROM Sales
WHERE Year = 2016
GROUP BY Month, Year
ORDER BY Total_Profit DESC;

--Tatgeted Audience
--By Age Group
SELECT Age_Group, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
GROUP BY Age_Group
ORDER BY Total_Revenue DESC;
--By Gender
SELECT Customer_Gender, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
GROUP BY Customer_Gender
ORDER BY Total_Revenue DESC;
--BY Country
SELECT Country, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
GROUP BY Country
ORDER BY Total_Revenue DESC;

--Now let's go further and discover which states brings more $ to the company in each Country
--United States 
SELECT TOP 5 State, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
WHERE Country = 'United States'
GROUP BY State
ORDER BY Total_Revenue DESC;
--Australia
SELECT TOP 5 State, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
WHERE Country = 'Australia'
GROUP BY State
ORDER BY Total_Revenue DESC;
--Canada
SELECT TOP 3 State, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
WHERE Country = 'Canada'
GROUP BY State
ORDER BY Total_Revenue DESC;
--United Kingdom
SELECT TOP 1 State, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
WHERE Country = 'United Kingdom'
GROUP BY State
ORDER BY Total_Revenue DESC;
--Germany
SELECT TOP 5 State, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
WHERE Country = 'Germany'
GROUP BY State
ORDER BY Total_Revenue DESC;
--France
SELECT TOP 5 State, SUM(TRY_CAST(Revenue AS DECIMAL(10, 0))) AS Total_Revenue
FROM Sales
WHERE Country = 'France'
GROUP BY State
ORDER BY Total_Revenue DESC;

--Most Successful Products
--By Category
SELECT Product_Category,SUM(TRY_CAST(Profit AS DECIMAL(10, 0))) AS Total_Profit
FROM Sales
GROUP BY Product_Category
ORDER BY Total_Profit DESC;
--By Sub Categories
SELECT Sub_Category, Product_Category, SUM(TRY_CAST(Profit AS DECIMAL(10, 0))) AS Total_Profit
FROM Sales
GROUP BY Sub_Category, Product_Category
ORDER BY Total_Profit DESC;

--TOP 10 most successful products
SELECT TOP 10 Product, Sub_Category, Product_Category, Sub_Category, SUM(TRY_CAST(Profit AS DECIMAL(10, 0))) AS Total_Profit
FROM Sales
GROUP BY Product, Product_Category, Sub_Category
ORDER BY Total_Profit DESC;

--Products that causes high cost 
SELECT TOP 10 Product, Sub_Category, Product_Category, Sub_Category, SUM(TRY_CAST(Cost AS DECIMAL(10, 0))) AS Total_Cost
FROM Sales
GROUP BY Product, Product_Category, Sub_Category
ORDER BY Total_Cost DESC;
