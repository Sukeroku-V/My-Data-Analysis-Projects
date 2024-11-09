SELECT *
FROM CovidDeaths$;

SELECT *
FROM 
CovidVaccinations$;

--Total Cases Vs Total deaths
SELECT Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
FROM CovidDeaths$
WHERE location LIKE '%States'
AND continent IS NOT NULL
ORDER BY Death_Percentage DESC;

-- Total Cases vs Population
SELECT Location, date, Population, total_cases,  (total_cases/population)*100 AS Percent_Of_Population_Infected
FROM CovidDeaths$
WHERE Location like '%States'
ORDER BY Percent_Of_Population_Infected DESC;

-- Countries with Highest Infection Rate compared to Population
SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 AS Percent_Of_Population_Infected
FROM CovidDeaths$
GROUP BY Location, Population
ORDER BY Percent_Of_Population_Infected DESC;

-- Countries with Highest Death Count per Population
SELECT Location, MAX(CAST(Total_deaths as int)) as TotalDeathCount
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC;


-- Contintents with the highest death count per population
SELECT continent, MAX(CAST(Total_deaths as int)) as TotalDeathCount
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS
Select continent, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY DeathPercentage DESC;

-- Total Population vs Vaccinations
Select DTH.continent, dTH.location, DTH.date, DTH.population, VAC.new_vaccinations, SUM(CONVERT(int,VAC.new_vaccinations)) OVER (PARTITION BY DTH.Location ORDER BY DTH.location, DTH.Date) as RollingPeopleVaccinated
From CovidDeaths$ DTH
Join CovidVaccinations$ VAC 
	On DTH.location = VAC.location
	and DTH.date = VAC.date
where DTH.continent IS NOT NULL
ORDER BY RollingPeopleVaccinated DESC;


-- Using CTE to perform Calculation on Partition By in previous query
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
Select DTH.continent, DTH.location, DTH.date, DTH.population, VAC.new_vaccinations
, SUM(CONVERT(int,VAC.new_vaccinations)) OVER (PARTITION BY DTH.Location ORDER BY DTH.location, DTH.Date) AS RollingPeopleVaccinated
From CovidDeaths$ DTH
Join CovidVaccinations$ VAC
	ON DTH.location = VAC.location
	AND DTH.date = VAC.date
WHERE DTH.continent IS NOT NULL
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;