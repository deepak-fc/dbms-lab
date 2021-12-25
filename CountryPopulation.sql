USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS population;
DROP TABLE IF EXISTS country;

-- Table creation
CREATE TABLE country(
    c_code INT,
    c_name VARCHAR(30) NOT NULL,
    capital VARCHAR(30),
    PRIMARY KEY(c_code)
);

CREATE TABLE population(
    pop_code INT ,
    population INT,
    c_code INT UNIQUE,
    PRIMARY KEY(pop_code),
    FOREIGN KEY (c_code) REFERENCES country(c_code) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO country VALUES
(1, "India", "Delhi"),
(2, "China", "Beijing"),
(3, "USA", "Washington D.C"),
(4, "South Africa", "Cape Town"),
(5, "Japan", "Tokyo");

INSERT INTO population VALUES
(1, 1411778724, 2),
(2, 1385859919, 1),
(3, 332920786, 3),
(4, 60142978, 4),
(5, 125070000, 5);

-- Display all tables
SELECT * FROM country;
SELECT * FROM population;

-- Queries
SELECT c.c_name, MAX(p.population) AS 'Population'
FROM population p
JOIN country c USING(c_code);

SELECT c.c_name, p.population
FROM population p
JOIN country c USING(c_code)
WHERE c.capital = "Tokyo";

SELECT c.c_name, p.population
FROM population p
JOIN country c USING(c_code)
ORDER BY c.c_name;