CREATE TABLE genre(
id INTEGER,
genre TEXT NOT NULL,
CONSTRAINT PKgenre PRIMARY KEY(id));


CREATE TABLE movie(
id INTEGER,
movie_title TEXT NOT NULL,
year TEXT NOT NULL,
genre INTEGER NOT NULL,
CONSTRAINT PKmovie PRIMARY KEY(id),
CONSTRAINT FKmovie FOREIGN KEY(genre) REFERENCES genre);

CREATE TABLE movie_info(
movie_id INTEGER,
genre_id INTEGER,
content_rating TEXT NOT NULL,
CONSTRAINT PKmovie_info PRIMARY KEY(movie_id,genre_id),
CONSTRAINT FKmovie_info FOREIGN KEY(movie_id) REFERENCES movie,
CONSTRAINT FKmovie_info1 FOREIGN KEY(genre_id) REFERENCES genre);

CREATE TABLE audience(
id INTEGER,
audience_rating INTEGER,
audience_count NUMERIC(10,1),
CONSTRAINT PKaudience PRIMARY KEY(id),
CONSTRAINT FKaudience FOREIGN KEY(id) REFERENCES movie);




SELECT movie.year FROM movie
WHERE movie.movie_title LIKE 'Jack and Jill';


SELECT movie.movie_title FROM movie, genre
WHERE movie.genre = genre.id 
AND genre.genre LIKE 'Animation'
AND movie.year = '2004';

 SELECT movie.movie_title, movie_info.content_rating 
 FROM movie, movie_info, audience, genre
 WHERE movie_info.movie_id = movie.id
 AND movie_info.movie_id = audience.id 
 AND movie_info.genre_id = genre.id 
 AND movie_info.movie_id = audience.id
 AND genre.genre LIKE 'Classics'
 AND audience.audience_rating >90;
 
 SELECT movie.id , movie.movie_title FROM movie, audience
 WHERE movie.id = audience.id 
 AND movie.year >= '2013' 
 AND movie.year < '2015'
 ORDER BY audience.audience_count DESC;

 SELECT genre.genre , COUNT(*) AS num_of_movies FROM genre, audience, movie_info
 WHERE genre.id = movie_info.genre_id AND audience.id = movie_info.movie_id 
 AND audience.audience_rating > 80
 GROUP BY genre.genre
 ORDER BY num_of_movies DESC;

SELECT movie.movie_title, audience.audience_rating 
FROM movie, audience
WHERE movie.id = audience.id
GROUP BY movie.movie_title, audience.audience_rating
HAVING audience.audience_rating > (SELECT AVG(audience.audience_rating) AS averating FROM audience);

SELECT movie1.movie_title , movie2.movie_title 
FROM movie movie1, movie movie2
WHERE movie1.movie_title NOT LIKE movie2.movie_title
AND movie1.id < movie2.id
AND movie1.genre = movie2.genre 
AND movie1.year = movie2.year;

