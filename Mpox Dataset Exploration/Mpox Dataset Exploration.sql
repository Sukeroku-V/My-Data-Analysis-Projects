SELECT *
FROM [owid-monkeypox-data];

--Places with the most mpox cases
SELECT location, SUM(CAST(total_cases as FLOAT)) as Mpox_Cases
FROM [owid-monkeypox-data]
WHERE location != 'World'
GROUP BY location
ORDER BY Mpox_Cases DESC;

--Places with the most mpox deaths
SELECT location, SUM(CAST(total_deaths as FLOAT)) as Mpox_Deaths
FROM [owid-monkeypox-data]
WHERE location != 'World'
GROUP BY location
ORDER BY Mpox_Deaths DESC;

--High Spreading Mpox in these locations
SELECT location,SUM(CAST(new_cases as FLOAT)) as New_Mpox_Cases, SUM(CAST(new_deaths as FLOAT)) as New_Mpox_Deaths
FROM [owid-monkeypox-data]
WHERE location != 'World'
GROUP BY location
ORDER BY New_Mpox_Cases DESC;

--Top 10 dates with the highest mpox cases
SELECT TOP 10 date, new_cases, location
FROM [owid-monkeypox-data]
ORDER BY new_cases DESC;

--Top 10 dates with the highest mpox deaths
SELECT TOP 10 date, new_deaths, location
FROM [owid-monkeypox-data]
ORDER BY new_deaths DESC;

--
