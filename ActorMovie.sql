USE cafy21582;

-- Drop tables
DROP TABLE IF EXISTS actor_movie;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS movie;

-- Table creation
CREATE TABLE actor(
	act_no INT,
    act_name VARCHAR(30),
    PRIMARY KEY(act_no)
);

CREATE TABLE movie(
	mov_no INT,
    mv_name VARCHAR(30),
    release_year DATE,
    PRIMARY KEY(mov_no)
);

CREATE TABLE actor_movie(
	sr_no INT,
    act_no INT,
    mov_no INT,
    PRIMARY KEY(sr_no),
    FOREIGN KEY(act_no) REFERENCES actor(act_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(mov_no) REFERENCES movie(mov_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO actor VALUES
(1, "Hritik Roshan"),
(2, "Salman Khan"),
(3, "Amitabh Bachchan"),
(4, "Sharukh Khan"),
(5, "Nawazuddin Siddiqui"),
(6, "Rajpal Yadav");

INSERT INTO movie VALUES
(1, "Karmveer", "1980-10-05"),
(2, "Pink", "2020-05-04"),
(3, "Om Shanti Om", "2004-05-01"),
(4, "DDLJ", "2000-05-01"),
(5, "Super 30", "2010-04-01"),
(6, "Bajrangi Bhaijan", "2016-10-05"),
(7, "Bodyguard", "2009-12-20"),
(8, "Random Movie", "2021-10-01");

INSERT INTO actor_movie VALUES
(1, 1, 5),
(2, 2, 6),
(3, 3, 1),
(4, 3, 2),
(5, 4, 4),
(6, 5, 8),
(7, 2, 7),
(8, 1, 8),
(9, 2, 8),
(10, 3, 8),
(11, 4, 8),
(12, 6, 8);


-- Display all tables
SELECT * FROM actor;
SELECT * FROM movie;
SELECT * FROM actor_movie;

-- Queries
SELECT m.mov_no, m.mv_name, m.release_year, a.act_name
FROM actor_movie am
JOIN actor a USING(act_no)
JOIN movie m USING(mov_no)
WHERE (a.act_name = "Amitabh Bachchan") AND 
	(m.release_year >= "1965-01-01" AND m.release_year <= "1980-12-31") AND
	(m.mv_name LIKE "k%");

SELECT m.mov_no, m.mv_name, m.release_year, a.act_name
FROM actor_movie am
JOIN actor a USING(act_no)
JOIN movie m USING(mov_no)
ORDER BY a.act_name;

SELECT COUNT(m.mov_no) AS "Salman Movie Count"
FROM actor_movie am
JOIN actor a USING(act_no)
JOIN movie m USING(mov_no)
WHERE a.act_name = "Salman Khan";

SELECT COUNT(a.act_no) AS 'Actor Count', m.mv_name 
FROM actor_movie am
JOIN actor a USING(act_no)
JOIN movie m USING(mov_no)
GROUP BY m.mv_name
HAVING COUNT(a.act_no) > 5;