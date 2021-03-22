-- 1
SELECT lastName, party, votes
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC;

-- 2
SELECT party, votes,
RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;

-- 3
SELECT yr,party, votes,
RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party,yr;

-- 4
SELECT
  constituency,
  party,
  votes,
  RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rank
FROM ge
WHERE
  constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr  = 2017
ORDER BY
  rank,
  constituency;

  -- 5
SELECT
constituency,
party
FROM ge AS x
WHERE
constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017
AND votes = (SELECT MAX(votes)
              FROM ge AS y
              WHERE x.constituency = y.constituency
              AND yr = 2017)
ORDER BY
  constituency,
  votes DESC;

 -- 6
SELECT
party,
COUNT(*)
FROM ge AS x
WHERE
constituency LIKE 'S%'
AND yr  = 2017
AND votes = (SELECT MAX(votes)
              FROM ge AS y
              WHERE x.constituency = y.constituency
              AND yr = 2017)
GROUP BY party; 

