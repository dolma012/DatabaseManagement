
/*4.1 a*/
CREATE TABLE songs(
song_id INTEGER PRIMARY KEY,
song_title TEXT NOT NULL,
artist_id INTEGER NOT NULL,
genre TEXT)

CREATE TABLE popsongs(
song_id INTEGER PRIMARY KEY,
beats_perminute INTEGER NOT NULL,
danceability INTEGER NOT NULL,
valence INTEGER NOT NULL)

CREATE TABLE favorite(
song_id INTEGER PRIMARY,
beats_perminute INTEGER NOT NULL,
danceablity INTEGER NOT NULL,
valence INTEGER NOT NULL)

CREATE TABLE artists(
CONSTRAINT artist_id PRIMARY,
	artist_name TEXT NOTNULL,
	nationality TEXT
)

/*4.1 b*/
INSERT INTO songs(song_id, song_title, artist_id,
				 genre)
				VALUES (1, 'Senorita', 1, 'pop'), (2, 'Beautiful People', 2 , 'pop'),
				(3, 'Goodbyes', 7, 'dfw rap'), (4, 'Ransom', 8, 'trap music'), 
				(5, 'How Do You Sleep', 3, 'pop'),
				(6 , 'Higher Love', 4, 'edm'),
				(7, 'Summer Days', 9, NULL) ,
				(8, 'Boyfriend', 5, 'pop'),
				(9, 'Someone You Loved', 6, 'pop'),
				(10, 'Pink Venom', 10, 'kpop');

INSERT INTO popsongs(song_id, beats_perminute, danceability, valence) 
VALUES 
(1, 117, 76, 75),
(2, 93, 64, 55),
(5, 111, 48, 35),
(9, 190, 40, 70),
(10, 110, 50, 45);

INSERT INTO favorite(song_id ,beats_perminute, danceability, valence)
VALUES (1, 117, 76, 75),
(10, 110, 50, 45),
(7, 104, 69, 40);


INSERT INTO artists(artist_id, artist_name, nationality)
VALUES 
(1, 'Shawn Mendes', 'Canadian'),
(2, 'Ed Sheeran', 'English'),
(3, 'Sam Smith', 'English'),
(4, 'Kygo', NULL),
(5, 'Ariana Grande', 'American'),
(6, 'Lewis Capaldi', 'Scottish'),
(7, 'Post Malone', 'American'),
(8, 'Lil Tecca', 'American'),
(9, 'Martin Garrix', NULL),
(10, 'Blackpink', 'South Korean'); 


/*4.2a*/
SELECT artist_name FROM artists
WHERE nationality= 'American'

/*4.2 b*/
SELECT song_id, beats_perminute, danceability, valence from popsongs
WHERE danceability = (SELECT MAX(danceability) FROM popsongs);

/*4.3 a*/
SELECT * from songs
INNER JOIN popsongs
ON songs.song_id = popsongs.song_id;

SELECT * from songs
FULL OUTER JOIN popsongs
ON songs.song_id = popsongs.song_id;


SELECT * from songs
RIGHT OUTER JOIN popsongs
ON songs.song_id = popsongs.song_id;

/*4.3 b*/
SELECT * from popsongs
UNION
SELECT * from favorite;

SELECT * from popsongs
UNION ALL
SELECT * from favorite;

/*4.4 a */
INSERT INTO artists(artist_id, artist_name,nationality )
VALUES (11,'DHRUV', NULL );

/*4.4 b*/
UPDATE artists
SET nationality = 'Indian'
WHERE artist_id = 11;

/*4.4 c*/
DELETE from artists
WHERE artist_name ='DHRUV';

/*4.5 a*/
SELECT count(genre) as count_of_genres, genre from songs
INNER JOIN popsongs ON popsongs.song_id = songs.song_id
WHERE popsongs.valence <= 70
GROUP BY genre
ORDER BY genre;

/*4.5 b*/
SELECT nationality from artists 
INNER JOIN songs ON artists.artist_id = songs.artist_id 
WHERE  songs.genre != 'kpop'  
GROUP BY nationality 
HAVING count(nationality)= 1
ORDER BY nationality;