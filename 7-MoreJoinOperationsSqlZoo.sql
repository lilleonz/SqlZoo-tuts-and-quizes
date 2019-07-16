-- 1 Query to show the films where the yr is 1962 [Show id, title].
SELECT id, title
FROM movie
WHERE yr=1962;

-- 2 Query to show year of 'Citizen Kane'.
SELECT yr FROM movie WHERE title='Citizen Kane';

-- 3 Query to show all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%' ORDER BY yr;

-- 4 Query to show the id number of the actor 'Glenn Close'.
SELECT id FROM actor WHERE name = 'Glenn Close'

-- 5 Query to show the id of the film 'Casablanca'.
SELECT id FROM movie WHERE title = 'Casablanca';

-- 6 Query to obtain the cast list for 'Casablanca'. 
SELECT actor.name FROM actor JOIN casting ON actor.id=casting.actorid
WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca');

-- 7 Query to obtain the cast list for the film 'Alien'.
SELECT actor.name FROM actor JOIN casting ON actor.id=casting.actorid
WHERE casting.movieid = (SELECT movie.id FROM movie WHERE movie.title = 'Alien');

-- 8 Query to list the films in which 'Harrison Ford' has appeared.
SELECT movie.title FROM movie JOIN casting ON movie.id=casting.movieid
WHERE casting.actorid = (SELECT actor.id FROM actor WHERE actor.name = 'Harrison Ford');

-- 9 Query to list the films where 'Harrison Ford' has appeared - but not in the starring role. 
SELECT movie.title FROM movie JOIN casting ON movie.id=casting.movieid
WHERE casting.actorid = (SELECT actor.id FROM actor WHERE actor.name = 'Harrison Ford') AND casting.ord != 1;

-- 10 Query to list the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name
FROM movie JOIN casting ON (movie.id=casting.movieid) JOIN actor ON (casting.actorid=actor.id)
WHERE casting.ord=1 AND movie.yr = 1962;

-- 11 Query to show the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
SELECT yr,COUNT(title) 
FROM movie JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12 Query to list the film title and the leading actor for all of the films 'Julie Andrews' played in. 
SELECT movie.title, actor.name
FROM movie JOIN casting ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE casting.ord = 1 AND casting.movieid=ANY(
SELECT casting.movieid FROM casting
WHERE casting.actorid IN (
SELECT actor.id FROM actor
WHERE name='Julie Andrews'));

-- 13 Query to obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 
SELECT actor.name
FROM actor JOIN casting ON (actor.id=casting.actorid)
WHERE casting.ord=1
GROUP BY actor.name
HAVING COUNT(actor.name) >= 30
ORDER BY actor.name ASC;

-- 14 Query to list the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
SELECT movie.title, COUNT(movieid) FROM movie
JOIN casting ON (movie.id=casting.movieid)
JOIN actor ON (casting.actorid=actor.id)
WHERE yr=1978
GROUP BY movie.title
ORDER BY COUNT(casting.movieid) DESC, movie.title;

-- 15 Query to list all the people who have worked with 'Art Garfunkel'.
SELECT actor.name FROM actor
JOIN casting ON (actor.id=casting.actorid)
JOIN movie ON (casting.movieid=movieid)
WHERE actor.name!='Art Garfunkel' AND casting.movieid=ANY(
SELECT casting.movieid FROM casting
WHERE casting.actorid=
(SELECT actor.id FROM actor WHERE actor.name='Art Garfunkel'))
GROUP BY actor.name;