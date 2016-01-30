-- 1. List the films where the yr is 1962 [Show id, title]

SELECT id, title
  FROM movie
  WHERE yr=1962

-- 2. Give year of 'Citizen Kane'.

SELECT yr
  FROM movie
  WHERE title='Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%star trek%'
  ORDER BY yr

-- 4. What are the titles of the films with id 11768, 11955, 21191

SELECT title
  FROM movie
  WHERE id IN (11768, 11955, 21191)

-- 5. What id number does the actress 'Glenn Close' have?

SELECT id
  FROM actor
  WHERE name='Glenn Close'

-- 6. What is the id of the film 'Casablanca'

SELECT id
  FROM movie
  WHERE title='Casablanca'

-- 7. Obtain the cast list for 'Casablanca'.

--what is a cast list?
--The cast list is the names of the actors who were in the movie.

--Use movieid=11768, this is the value that you obtained in the previous question.

SELECT name
  FROM movie
  JOIN casting ON id=movieid
  JOIN actor ON actorid = actor.id
  WHERE movieid=11768


-- 8. Obtain the cast list for the film 'Alien'

SELECT name
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid = actor.id
  WHERE title='Alien'

-- 9. List the films in which 'Harrison Ford' has appeared

SELECT title
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid = actor.id
  WHERE name='Harrison Ford'

-- 10. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT title
  FROM movie
  JOIN casting ON id=movieid
  JOIN actor ON actorid = actor.id
  WHERE ord!=1 AND name='Harrison Ford'

-- 11. List the films together with the leading star for all 1962 films.

SELECT title, name
  FROM movie
  JOIN casting ON id=movieid
  JOIN actor ON actorid = actor.id
  WHERE ord=1 AND yr=1962

-- 12. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(title)
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid=actor.id
  WHERE name='John Travolta'
  AND yr > 2
  GROUP BY yr
  ORDER BY COUNT(title) DESC
  LIMIT 1

/* 13.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?
Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).

Title is not a unique field, create a table of IDs in your subquery
*/

SELECT title, name
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid=actor.id
  where casting.ord=1
  AND movie.id IN (
    SELECT movie.id
    FROM movie JOIN casting
      ON id=movieid
    JOIN actor
      ON actorid=actor.id
    WHERE name='Julie Andrews'
)

-- 14. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

SELECT DISTINCT name
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid=actor.id
  WHERE ord=1
  GROUP BY name
  HAVING COUNT(title) >= 30

-- 15. List the films released in the year 1978 ordered by the number of actors in the cast.

SELECT title, COUNT(actorid)
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid=actor.id
  WHERE yr=1978
  GROUP BY title
  ORDER BY COUNT(actorid) DESC

-- 16. List all the people who have worked with 'Art Garfunkel'.

SELECT name
  FROM movie JOIN casting
    ON id=movieid
  JOIN actor
    ON actorid=actor.id
  WHERE name!='Art Garfunkel'
  AND title IN (
    SELECT title
      FROM movie JOIN casting
        ON id=movieid
      JOIN actor
        ON actorid=actor.id
      WHERE name='Art Garfunkel'
)
