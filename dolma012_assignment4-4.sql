/*3.3.1*/
SELECT act1.name FROM actor act1, movie mov1, casting cast1
WHERE act1.id = cast1.actor_id AND mov1.id = cast1.movie_id
AND mov1.votes > 2000 AND mov1.votes <= 2100
GROUP BY act1.name
EXCEPT
SELECT act2.name FROM actor act2
WHERE act2.name NOT LIKE 'D%'
GROUP BY act2.name;

/*3.3.2 query the directors  who directed a movie that scored more than 95% of the highest score
ANSWER: the highest score is 10 so the 95 percent of the highest score will be greater than 9.5*/
SELECT mov.director FROM movie mov
WHERE mov.director IN
(SELECT mov1.director FROM movie mov1
WHERE mov1.score > 9.5)
GROUP BY mov.director;



/*3.3.3 First find the first sub query looks for movies starred by summerville, slim. second subquery looks for movies starred by Chaplin Charles. combined subquery outputs movies starred by both summeriville and chaplin */
SELECT act1.name FROM actor act1, casting cast1, movie mov1
WHERE act1.id = cast1.actor_id AND cast1.movie_id = mov1.id
AND act1.name NOT IN ( 'Summerville, Slim','Chaplin, Charles')
AND mov1.id IN
(SELECT mov2.id FROM movie mov2, casting cast2, actor act2
WHERE mov2.id = cast2.movie_id 
AND cast2.actor_id= act2.id 
AND act2.name IN ('Summerville, Slim')
AND mov2.id IN
(SELECT mov3.id FROM movie mov3, casting cast3, actor act3
WHERE mov3.id = cast3.movie_id 
AND cast3.actor_id= act3.id
AND act3.name IN ('Chaplin, Charles')))
GROUP BY act1.name;



/*3.3.4*/
SELECT act1.name FROM actor act1, casting cast1, movie mov1
WHERE act1.id = cast1.actor_id
AND cast1.movie_id = mov1.id
AND mov1.title LIKE 'The Ring%'
GROUP BY act1.name
HAVING COUNT(*)=(SELECT COUNT(mov2.title) FROM movie mov2 
WHERE mov2.title LIKE 'The Ring%');


/*3.4.1*/
SELECT site FROM cancer_rate_per_100k
WHERE gender LIKE 'Female'
AND state LIKE 'Minnesota'
INTERSECT 
SELECT c.site FROM cancer_rate_per_100k c
WHERE c.death_rate = (SELECT MIN(c1.death_rate)
FROM cancer_rate_per_100k c1);

/*3.4.2*/
SELECT r.state,  MAX(c.death_rate * p.population/ 100000) as death_count
FROM cancer_rate_per_100k c,regions r, pop_by_state_and_gender_2010 p
WHERE r.state = c.state
AND r.state = p.state
AND c.gender = p.gender
AND c.gender = 'Male'
AND c.site = 'Prostate'
GROUP BY r.state
ORDER BY  MAX(c.death_rate * p.population/ 100000) DESC;

--the condition where max number of death is larger than the average death rate is not in the query because max number of death and avg of the death rate are not compatible metrics; if we do compare it the query will still have the same amount of rows with or without this condition. The answer for  3.4.2 has all the deaths of a population by state, because it is the max deaths of a male in prostate site.


/*3.4.3*/
SELECT c.site, r.region, ROUND(CAST(AVG(c.rate_of_new_cases)AS NUMERIC),4) AS avg_rate_of_new_cases 
FROM cancer_rate_per_100k c, regions r
WHERE c.state = r.state
AND c.site IN
(SELECT c1.site FROM cancer_rate_per_100k c1, regions r1
WHERE c1.gender = 'Male'
AND c1.site NOT LIKE 'Prostate'
GROUP BY c1.site
HAVING  ROUND(CAST(AVG(c1.rate_of_new_cases)AS NUMERIC),4) > SOME
(SELECT ROUND(CAST(AVG(c2.rate_of_new_cases)AS NUMERIC),4) 
AS avg_rate_of_new_cases FROM cancer_rate_per_100k c2, regions r2
WHERE c2.state = r2.state
AND c2.gender = 'Female'
GROUP BY c2.site, r2.region
ORDER BY c2.site))
GROUP BY c.site, r.region
ORDER BY c.site;

/*3.4.4*/
SELECT regions.region, T.site, SUM(sum_state_site) AS sum_of_deaths FROM 
(SELECT  c.state, c.site , SUM(c.death_rate * p.population/ 100000) as sum_state_site
FROM cancer_rate_per_100k c, pop_by_state_and_gender_2010 p
WHERE c.state = p.state
AND c.gender = p.gender
GROUP BY c.state, c.site) T
JOIN regions ON T.state = regions.state 
GROUP BY regions.region, T.site
ORDER BY sum_of_deaths DESC;

/*3.4.5*/
CREATE INDEX index_on_rates ON cancer_rate_per_100k 
(rate_of_new_cases, death_rate);
CREATE INDEX index_on_population ON pop_by_state_and_gender_2010
(population);
--answer
--Creating an index decreases the execution time for both 3.4.3 and 3.4.4 because indexes do not have to carry all the data for each row in the table, it just carries the data that we are looking for. This makes it easy for the operating system to cache a lot of the indexes into the memory for faster access and for the file system to read a huge number of records simultaneously rather than reading them from the disk. Also since we are joining the cancer_rate_per_100k and pop_by_state_and_gender_2010 for 3.4.4, the sql can look for the indexes quickly and easily instead of searching sequentially through a large table. 





