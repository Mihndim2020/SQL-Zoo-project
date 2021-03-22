-- 1
SELECT id, title
FROM movie
WHERE yr=1962

--2
SELECT yr 
FROM movie 
WHERE title = 'Citizen Kane';

--3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4
SELECT id 
FROM actor
WHERE name = 'Glenn Close';

-- 5
SELECT id 
FROM movie 
WHERE title = 'Casablanca';

-- 6
SELECT name 
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE movieid = 11768;

-- 7
SELECT name 
FROM actor JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE title = 'Alien'; 

-- 8
SELECT title 
FROM movie JOIN casting ON movie.id = casting.movieid 
JOIN actor ON casting.actorid = actor.id
WHERE director LIKE '%Harrison Ford%' OR name LIKE '%Harrison Ford%';

-- 9
SELECT title 
FROM movie JOIN casting ON movie.id = casting.movieid 
JOIN actor ON casting.actorid = actor.id
WHERE director LIKE '%Harrison Ford%' OR name LIKE '%Harrison Ford%' AND ord != 1;

-- 10
SELECT title, name 
FROM movie JOIN casting ON movie.id = casting.movieid 
JOIN actor ON casting.actorid = actor.id
WHERE ord = 1 AND yr = 1962;

-- 11
SELECT yr, COUNT(title)
FROM movie JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12
SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid AND ord = 1 
JOIN actor ON casting.actorid = actor.id
WHERE  movie.id IN (
SELECT movieid FROM casting
WHERE actorid IN (
SELECT id FROM actor
WHERE name='Julie Andrews'));

-- 13
SELECT actor.name
FROM casting
JOIN actor
ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 15
ORDER BY name;

-- 14
SELECT title, COUNT(actorid)
FROM movie
JOIN casting
ON movie.id = casting.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;

-- 15
SELECT name
FROM casting
JOIN actor
ON casting.actorid = actor.id
WHERE movieid IN (
  SELECT movieid
  FROM casting
  JOIN movie
  ON casting.movieid = movie.id
  WHERE actorid = (
    SELECT id
    FROM actor
    WHERE name = 'Art Garfunkel'
  )
) AND actor.name != 'Art Garfunkel';
