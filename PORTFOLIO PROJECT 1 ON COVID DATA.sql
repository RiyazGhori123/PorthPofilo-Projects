--SELECT *
--FROM [PORTFOLIO PROJECT].[dbo].[CovidDeaths$]

--SELECT location,date, total_cases, new_cases, total_deaths, population_density
--FROM CovidDeaths$
--ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths

--SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--FROM CovidDeaths$
--WHERE location like '%states%'
--Order by 1,2 

-- Looking at Total cases vs Population
-- Shows what percentage of Population got covid
--SELECT Location, date, total_cases, population_density, (total_cases/population_density)*100 as PoupulationPercentage
--FROM CovidDeaths$
--WHERE location like '%india%'
--Order by 1,2 

-- Looking at Countries with Highest Infection Rate Compared to Population

--SELECT Location, population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population_density))*100 as PercentagePopulationInfected
--FROM CovidDeaths$
--WHERE location like '%india%'
--Group by location, population_density
--Order by PercentagePopulationInfected DESC

-- Showing Countries with Highest Death Count per Population

--SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
--FROM [PORTFOLIO PROJECT].dbo.CovidDeaths$
----WHERE LOCATION LIKE '%INDIA%'
--GROUP BY LOCATION
--ORDER BY TotalDeathCount DESC

-- LET'S BREAKS THINGS DWON BY CONTINENT

--SELECT continent, Max(cast(total_deaths as int)) as TotalDeathCount
--FROM [PORTFOLIO PROJECT].dbo.CovidDeaths$
----WHERE LOCATION LIKE '%INDIA%'
--WHERE continent is Not NULL
--GROUP BY continent
--ORDER BY TotalDeathCount DESC

--- CONTINENTS IWTH HIGHEST DEATH COUNT PER POPULATION same as above

--GLOBAL NUMBERS
--SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
--FROM [PORTFOLIO PROJECT].DBO.CovidDeaths$
--WHERE continent is NOT NULL
--order by 1,2

SELECT dea.continent, dea.location, dea.date,
      dea.population_density, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations )) OVER (Partition by dea.Location)
FROM [PORTFOLIO PROJECT].DBO.[CovidVaccinations$'] VAC
Join [PORTFOLIO PROJECT].DBO.[CovidDeaths$] DEA
    On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is NOT NULL
order by 2,3

