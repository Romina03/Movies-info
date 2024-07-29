CREATE DATABASE movies_info;

USE movies_info;

CREATE TABLE Movies (
    movie_id int NOT NULL,
    title varchar(25),
    genre varchar(10),
    release_year YEAR(4),
    PRIMARY KEY (movie_id)
);

CREATE TABLE Actors (
    actor_id int NOT NULL,
    name varchar(20),
    birth_date DATE,
    nationality varchar(15),
    PRIMARY KEY (actor_id)
);

CREATE TABLE MovieCast (
    movie_castid int NOT NULL,
    movie_id int,
    actor_id int,
    role varchar(25),
    PRIMARY KEY (movie_castid),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors (actor_id)
);

INSERT INTO Movies(movie_id, title, genre, release_year)
VALUES ("1", "Inception", "Sci-Fi", "2010"),
       ("2", "The Dark Knight", "Action", "2008"),
       ("3", "Pulp Fiction", "Crime", "1994"),
       ("4", "Forrest Gump", "Drama", "1994"),
       ("5", "The Shawshank Redemption", "Drama", "1996"),
       ("6", "The Matrix", "Sci-Fi", "1999"),
       ("7", "The GodFather", "Crime", "1972"),
       ("8", "Fight Club", "Drama", "1999"),
       ("9", "Titanic", "Romance", "1997"),
       ("10", "Jurassic Park", "Sci-Fi", "1993");
 
INSERT INTO Actors(actor_id, name, birth_date, nationality)
VALUES ("1", "Leonardo DiCaprio", "1974-11-11", "American"),
       ("2", "Christian Bale", "1974-01-30", "British"),
       ("3", "Samuel L. Jackson", "1948-12-21", "American"), 
       ("4", "Tom Hanks", "1956-07-09","American"),
       ("5", "Morgan Freeman","1937-06-01", "American"),
       ("6", "Keanu Reeves", "1964-09-02", "Canadians"),
       ("7", "Marlon Brando", "1924-04-03", "American"), 
       ("8", "Brad Pitt", "1963-12-18", "American"), 
       ("9", "Kate Winslet", "1975-10-05", "British"),
       ("10", "Sam Neill", "1947-09-14", "New Zealander");
      
INSERT INTO MovieCast (movie_castid, movie_id, actor_id, role) 
VALUES ("1", "1", "1", "Cobb"),
       ("2", "1", "4", "Mal"),
       ("3", "2", "2", "Bruce Wayne/Batman"),
       ("4", "2", "3", "Jules Winnfield"),
       ("5", "3", "3", "Jules Winnfield"),
       ("6", "3", "7", "Vito Corleone"),
       ("7", "4", "4", "Forrest Gump"),
       ("8", "4", "5", "Ellis Boyd \"Red\" Redding"),
       ("9", "5", "5", "Ellis Boyd \"Red\" Redding"),
       ("10", "5", "4", "Andy Dufresne"),
       ("11", "6", "6", "Neo"),
       ("12", "6", "7", "Vito Corleone"),
       ("13", "7", "7", "Vito Corleone"),
       ("14", "7", "4", "Vito Corleone young"),
       ("15", "8", "8", "Tyler Durden"),
       ("16", "8", "1", "Narrator"),
       ("17", "9", "1", "Jack Dawson"),
       ("18", "9", "9", "Rose DeWitt Bukater"),
       ("19", "10", "10", "Dr. Alan Grant"),
       ("20", "10", "9", "Rose DeWitt Bukater");
       

-- Retrieve the titles of all movies released in the 90s
SELECT title
FROM Movies
WHERE release_year < 2000 AND release_year > 1899;

-- Calculate the average age of American actors
SELECT AVG(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS avg_age
FROM Actors;

 -- Find all actors who acted in "The Godfather"
SELECT Actors.name
FROM Actors 
JOIN MovieCast 
ON Actors.actor_id = MovieCast.actor_id
JOIN Movies 
ON Movies.movie_id = MovieCast.movie_id 
WHERE Movies.title = 'The GodFather';


-- Find all actors whose names contain Wins.
SELECT name 
FROM Actors
WHERE name
LIKE "%Wins%";

-- Update the release year of "The Matrix" to 1999.
UPDATE Movies
SET release_year = '1999'
WHERE title = 'The Matrix';

-- Retrieve the roles played by Leonardo DiCaprio.
SELECT MovieCast.role
FROM MovieCast 
JOIN Actors 
ON Actors.actor_id = MovieCast.actor_id
WHERE name = 'Leonardo DiCaprio';

-- Retrieve the names of all actors who were born after 1960.
SELECT name
FROM Actors 
WHERE YEAR(birth_date) > "1960";

-- Retrieve the names of actors older than 50 years old
SELECT name
FROM Actors
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) > 50;




-- Display all movie titles and corresponding roles
SELECT Movies.title, MovieCast.role
FROM Movies 
JOIN MovieCast 
ON Movies.movie_id = MovieCast.movie_id;


-- Retrieve all movies with titles starting with: The
SELECT title
FROM Movies 
WHERE title 
LIKE "The%";

-- Remove the actor record for Marlon Brando.
DELETE FROM MovieCast 
WHERE actor_id = "7";
DELETE FROM Actors 
WHERE name = "Marlon Brando"

-- Retrieve actors that acted in Drama genre. 
SELECT DISTINCT Actors.name
FROM Actors 
JOIN MovieCast 
ON Actors.actor_id = MovieCast.actor_id
JOIN Movies 
ON Movies.movie_id = MovieCast.movie_id 
WHERE Movies.genre = 'Drama';


-- Retrieve the movies that both Leonardo DiCaprio and Tom Hanks acted
SELECT Movies.title FROM Movies JOIN MovieCast ON Movies.movie_id  = MovieCast.movie_id 
JOIN Actors ON Actors.actor_id  = MovieCast.actor_id 
WHERE Actors.name = 'Leonardo DiCaprio' 
INTERSECT  
SELECT Movies.title FROM Movies JOIN MovieCast ON Movies.movie_id  = MovieCast.movie_id 
JOIN Actors ON Actors.actor_id  = MovieCast.actor_id 
WHERE Actors.name = 'Tom Hanks';