--Population Growth Comparison Between Regions
Select world_country_stats.region, AVG(CAST(world_population_by_country_2023.yearly_change AS float)) AS average_yearly_change
FROM  world_population_by_country_2023
JOIN world_country_stats on world_country_stats.country = world_population_by_country_2023.country
GROUP BY world_country_stats.region
ORDER BY average_yearly_change DESC;

--Top 5 Most Populous Countries per Region
WITH RankedCountries AS (
    SELECT PC.country, PC.population, CS.region,
           ROW_NUMBER() OVER (PARTITION BY CS.region ORDER BY PC.population DESC) AS Rank
    FROM world_population_by_country_2023 PC
    JOIN world_country_stats CS ON CS.country = PC.country
)
SELECT country, population, region
FROM RankedCountries
WHERE Rank <= 5;

--10 Countries with the Highest Density Growth per Region in 2023
WITH DensityGrowth AS (
    SELECT PC.country, 
           (CAST(PC.Population AS FLOAT) / CAST(PC.land_area AS FLOAT)) AS density_2023
    FROM world_population_by_country_2023 PC
    JOIN world_population_by_year_1950_2023 PY ON PY.country = PC.country
	WHERE PC.land_area != 0 
)
SELECT TOP 10 country, density_2023
FROM DensityGrowth
ORDER BY density_2023 DESC;

-- Urbanization Trends for Countries with Low Fertility Rates
SELECT country, fertility_rate, population_urban
FROM world_population_by_country_2023
WHERE CAST(fertility_rate AS FLOAT) < 2 
ORDER BY population_urban ASC;

-- Fertility Rate and Population Correlation
SELECT country, fertility_rate, yearly_change
FROM world_population_by_country_2023
WHERE CAST(yearly_change AS FLOAT) < 0
ORDER BY fertility_rate DESC;

-- TOP 10 Oldest countries
SELECT TOP 10 country, median_age
FROM world_country_stats
ORDER BY median_age DESC;

-- Top 5 Countries by Consistent Yearly Population Growth
WITH YearlyGrowth AS (
    SELECT PC.country, PC.yearly_change
    FROM  world_population_by_country_2023 PC
)
SELECT TOP 5 country
FROM YearlyGrowth
GROUP BY country
HAVING COUNT(CASE WHEN yearly_change > 0 THEN 1 END) = (COUNT(*))
ORDER BY country;

--Land Area and Population Growth per Region
SELECT PY.region, SUM(PC.population) AS total_population, SUM(PC.land_area) AS total_land_area
FROM world_population_by_country_2023 PC
JOIN world_country_stats PY ON PY.country = PC.country
GROUP BY PY.region
ORDER BY total_population DESC;

-- Countries with Both High Fertility Rate and Median Age
SELECT country, fertility_rate, median_age
FROM world_population_by_country_2023
WHERE fertility_rate > 4.0 AND median_age > 30 

-- Largest Population Density Differences between countries in the same region
WITH Density AS (
    SELECT PC.country, PY.region, (PC.population / PC.land_area) AS population_density
    FROM world_population_by_country_2023 PC
    JOIN world_country_stats PY ON PY.country = PC.country
)
SELECT region, MAX(population_density) - MIN(population_density) AS density_difference
FROM Density
GROUP BY region
ORDER BY density_difference DESC;


