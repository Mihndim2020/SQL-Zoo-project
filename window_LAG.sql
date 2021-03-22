-- 1
SELECT name, DAY(whn),
confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn;

-- 2
SELECT
  name,
  DAY(whn),
  confirmed,
  LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
FROM covid
WHERE
  name = 'Italy'
  AND MONTH(whn) = 3
ORDER BY whn;

-- 3
SELECT
  name,
  DAY(whn),
  confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
FROM covid
WHERE
  name = 'Italy'
  AND MONTH(whn) = 3
ORDER BY whn;

-- 4
SELECT
  name,
  DATE_FORMAT(whn, '%Y-%m-%d') AS Date,
  confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
FROM covid
WHERE
  name = 'Italy'
  AND WEEKDAY(whn) = 0
ORDER BY whn;

-- 5
SELECT
  current.name,
  DATE_FORMAT(current.whn, '%Y-%m-%d') AS Date,
  current.confirmed - previous.confirmed AS new
FROM covid AS current
LEFT JOIN covid AS previous
  ON DATE_ADD(previous.whn, INTERVAL 1 WEEK) = current.whn
  AND current.name = previous.name
WHERE
  current.name = 'Italy'
  AND WEEKDAY(current.whn) = 0
ORDER BY current.whn;

-- 6
SELECT 
  name,
  confirmed,
  RANK() OVER (ORDER BY confirmed DESC) AS rank1,
  deaths,
  RANK() OVER (ORDER BY deaths DESC) AS rank2
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

-- 7
SELECT 
   world.name,
   ROUND(100000 * covid.confirmed / world.population) AS rate,
   RANK() OVER (ORDER BY covid.confirmed / world.population ASC) AS rank
FROM covid
JOIN world ON covid.name = world.name
WHERE
  whn = '2020-04-20'
  AND population >= 10000000
ORDER BY population DESC;

-- 8
SELECT
  Name,
  Date,
  New AS peakNewCases
FROM
  (SELECT
    current.name AS Name,
    DATE_FORMAT(current.whn, '%Y-%m-%d') AS Date,
    current.confirmed - previous.confirmed AS New,
    RANK() OVER (PARTITION BY name ORDER BY New DESC) AS Rank
  FROM covid AS current
  LEFT JOIN covid AS previous
    ON DATE_ADD(previous.whn, INTERVAL 1 DAY) = current.whn
    AND current.name = previous.name
  WHERE
    current.confirmed - previous.confirmed > 1000
  GROUP BY
    current.name,
    Date
  ) AS secondary
WHERE
  Rank = 1
ORDER BY 
  Date,
  peakNewCases;
  