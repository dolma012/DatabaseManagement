SELECT ac1.name 
FROM ACTOR ac1, MOVIE mv1, CASTING c1
WHERE ac1.actorId = c1.actorId 
AND c1.movieId = mv1.movieId 
AND mv1.director = 'Chaplin Charles' 
GROUP BY ac1.actorId
HAVING COUNT(ac1.actorId) = (SELECT COUNT(mv2.movieId) 
FROM MOVIE mv2 
WHERE mv2.director = 'Chaplin Charles')



SELECT ac1.name 
FROM ACTOR ac1, MOVIE mv1, CASTING c1
WHERE ac1.actorId = c1.actorId 
AND c1.movieId = mv1.movieId 
AND mv1.director = 'Chaplin Charles';



SELECT ac1.name 
FROM ACTOR ac1, MOVIE mv1, CASTING c1
WHERE ac1.actorId = c1.actorId 
AND c1.movieId = mv1.movieId 
AND mv1.director = 'Chaplin Charles'
GROUP BY ac1.actorId
HAVING COUNT(ac1.actorId) = (SELECT COUNT(c2.actorId) 
FROM CASTING c2
GROUP BY c2.actorId);




