-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
--      Create a table called movies with each of these columns
-- - As a guest, I want to see the movies which a single studio has produced.
--      Create a studios table
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
--      Create a characters table as cast screws with code
-- - As a guest, I want to see the movies which a single actor has acted in.
-- * Note: The "guest" user role represents the experience prior to logging-in
--      Create an actors table
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:

-- PART 1
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.

-- PART 2
-- - Insertion of "Batman" sample data into tables.

-- PART 3 REPORT
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint #1: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.

--   Hint #2: Do NOT name one of your models/tables “cast” or “casts”; this 
--   is a reserved word in sqlite and will break your database! Instead, 
--   think of a better word to describe this concept; i.e. the relationship 
--   between an actor and the movie in which they play a part.

-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns

-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created
-- - It actually works, i.e. proper INSERT syntax

-- 4. "The report" (SELECT statements) - 6 points
-- - Write 2 `SELECT` statements to produce something similar to the
--   sample output below - 1 for movies and 1 for cast. You will need
--   to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!

DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS studios;
DROP TABLE IF EXISTS characters;

-- Create new tables, according to your domain model
-- TODO!

CREATE TABLE actors (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    title TEXT,
    year INTEGER,
    rating TEXT,
    studio_id INTEGER,
    FOREIGN KEY(studio_id) REFERENCES studios(id)
);

CREATE TABLE studios (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE characters (
    actor_id INTEGER,
    movie_id INTEGER,
    character_name TEXT,
    FOREIGN KEY(actor_id) REFERENCES actors(id),
    FOREIGN KEY(movie_id) REFERENCES movies(id)
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!

INSERT INTO studios (
    id, name
    ) 
VALUES (
    1, "Warner Bros."
);

INSERT INTO movies (
    id, title, year, rating, studio_id
    )
VALUES (
    1, "Batman Begins", 2005, "PG-13", 1
    ),
(
    2, "The Dark Knight", 2008, "PG-13", 1
    ),
(
    3, "The Dark Knight Rises", 2012, "PG-13", 1
    );

INSERT INTO actors (
    id, name
    ) 
VALUES
(1, "Christian Bale"),
(2, "Michael Caine"),
(3, "Liam Neeson"),
(4, "Katie Holmes"),
(5, "Gary Oldman"),
(6, "Heath Ledger"),
(7, "Aaron Eckhart"),
(8, "Maggie Gyllenhaal"),
(9, "Tom Hardy"),
(10, "Joseph Gordon-Levitt"),
(11, "Anne Hathaway"
)
;

INSERT INTO characters (
    actor_id, movie_id, character_name
    ) 
VALUES
-- Batman Begins --
(1, 1, "Bruce Wayne"),
(2, 1, "Alfred"),
(3, 1, "Ra's Al Ghul"),
(4, 1, "Rachel Dawes"),
(5, 1, "Commissioner Gordon"),

-- The Dark Knight --
(1, 2, "Bruce Wayne"),
(6, 2, "Joker"),
(7, 2, "Harvey Dent"),
(2, 2, "Alfred"),
(8, 2, "Rachel Dawes"),
(5, 2, "Commissioner Gordon"),

-- The Dark Knight Rises --
(1, 3, "Bruce Wayne"),
(5, 3, "Commissioner Gordon"),
(9, 3, "Bane"),
(10, 3, "John Blake"),
(11, 3, "Selina Kyle")
;

-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
-- TODO!

SELECT title, year, rating, name 
FROM movies
JOIN studios ON movies.studio_id = studios.id
;

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
-- TODO!

SELECT movies.title, actors.name AS actor_name, characters.character_name
FROM movies
INNER JOIN characters ON movies.id = characters.movie_id
INNER JOIN actors ON characters.actor_id = actors.id
;