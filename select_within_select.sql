-- 1
SELECT name FROM world
WHERE population >(SELECT population FROM world
WHERE name='Russia')

-- 2
SELECT name 
FROM world
WHERE continent = 'Europe' AND gdp/population > 
(SELECT gdp/population FROM world WHERE name = 'United Kingdom'); 

-- 3
SELECT name, continent
FROM world 
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 4
SELECT name, population
FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');

-- 5
SELECT name, CONCAT(ROUND(100*(population/(SELECT population FROM world WHERE name = 'Germany'))),'%')

FROM world
WHERE continent = 'Europe';

-- 6
SELECT name 
FROM world 
WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp > 0 AND continent = 'Europe');

-- 7
SELECT continent, name, area
FROM world original
WHERE area > ALL (SELECT area
FROM world copy
WHERE original.continent = copy.continent AND
area > 0 AND
original.name <> copy.name);

-- 8
SELECT continent, name
FROM world original
WHERE name = (SELECT name
FROM world copy
WHERE original.continent = copy.continent
ORDER BY name
LIMIT 1);

-- 9
SELECT name, continent, population
FROM world original
WHERE 25000000 > ALL(SELECT population
FROM world copy
WHERE original.continent = copy.continent);

-- 10
SELECT name, continent
FROM world original
WHERE population > ALL (SELECT population * 3
FROM world copy
WHERE original.continent = copy.continent
AND original.name <> copy.name);
