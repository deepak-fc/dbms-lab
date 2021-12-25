use cafy21582;

-- Drop tables
DROP TABLE IF EXISTS game_player;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS player;

-- Table creation
CREATE TABLE game(
	name VARCHAR(30),
    no_of_players INT,
    captain_name VARCHAR(30),
    PRIMARY KEY(name)
);

CREATE TABLE player(
	name VARCHAR(30),
    address VARCHAR(50),
    club_name VARCHAR(30),
    PRIMARY KEY(name)
);

CREATE TABLE game_player(
	g_name VARCHAR(30),
    p_name VARCHAR(30),
    coach_name VARCHAR(30),
    PRIMARY KEY(g_name, p_name),
    FOREIGN KEY(g_name) REFERENCES game(name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(p_name) REFERENCES player(name) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO game VALUES
("Football", 11, "Deepak"),
("Basketball", 12, "Hritik"),
("Volleyball", 7, "Rohit"),
("Hockey", 20, "Fahed"),
("Cricket", 11, "Saurabh");

INSERT INTO player VALUES
("Deepak", "Panchavati", "PSG"),
("Hritik", "Sus Road", "Lakers"),
("Rohit", "Baner", "VB Blasters"),
("Fahed", "Khadki", "Zumanity"),
("Saurabh", "Pashan", "RCB"),
("Abhishek", "Aundh", "VB Blasters"),
("Kshitij", "Aundh Gaon", "Zumanity");

INSERT INTO game_player VALUES
("Football", "Deepak", "Vicente del Bosque"),
("Football", "Hritik", "Max Utaf"),
("Football", "Fahed", "Rahul Dravid"),
("Basketball", "Hritik", "Nate McMillan"),
("Basketball", "Abhishek", "Nate McMillan"),
("Volleyball", "Fahed", "Max Utaf"),
("Volleyball", "Rohit", "Max Utaf"),
("Hockey", "Kshitij", "Maninder Singh"),
("Hockey", "Fahed", "Maninder Singh"),
("Cricket", "Deepak", "Rahul Dravid"),
("Cricket", "Hritik", "Rahul Dravid"),
("Cricket", "Fahed", "Rahul Dravid"),
("Cricket", "Saurabh", "Rahul Dravid"),
("Cricket", "Kshitij", "Rahul Dravid"),
("Cricket", "Rohit", "Rahul Dravid");


-- Display all tables
SELECT * FROM game;
SELECT * FROM player;
SELECT * FROM game_player;

-- Queries
SELECT COUNT(p.name) AS 'In number of games', p.name AS 'Player name'
FROM game_player gp
JOIN player p ON gp.p_name = p.name
GROUP BY p.name
HAVING COUNT(p.name) > 2;

SELECT g.name, g.captain_name
FROM game_player gp
JOIN game g ON g.name = gp.g_name
GROUP BY g.name
HAVING COUNT(DISTINCT gp.coach_name) > 2;

SELECT name 
FROM game
WHERE no_of_players > 5;

SELECT p.name, gp.coach_name
FROM game_player gp
JOIN player p ON p.name = gp.p_name;