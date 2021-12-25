use cafy21582;

-- Drop tables
DROP TABLE IF EXISTS car_driver;
DROP TABLE IF EXISTS accident;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS driver;

-- Table creation
CREATE TABLE car(
	c_no VARCHAR(30),
    c_model VARCHAR(30),
    owner_name VARCHAR(30),
    PRIMARY KEY(c_no)
);

CREATE TABLE driver(
	d_no VARCHAR(30),
    d_name VARCHAR(30),
    d_addr VARCHAR(30),
    d_city VARCHAR(30),
    PRIMARY KEY(d_no)
);

CREATE TABLE car_driver(
	sr_no INT,
    d_no VARCHAR(30),
    c_no VARCHAR(30),
	PRIMARY KEY(sr_no),
	FOREIGN KEY(d_no) REFERENCES driver(d_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(c_no) REFERENCES car(c_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE accident(
	a_id INT,
    a_place VARCHAR(30),
    a_year INT,
    c_no VARCHAR(30),
    PRIMARY KEY(a_id),
    FOREIGN KEY(c_no) REFERENCES car(c_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO car VALUES
("M1", "Supra", "Deepak"),
("M2", "BMW GTR", "Fahed"),
("M3", "Ferrari Spider", "Saurabh"),
("M4", "Mini Cooper", "Rohit"),
("M5", "WagonR", "Hritik");

INSERT INTO driver VALUES
("1", "Deepak", "Panchavati", "Pune"),
("2", "Fahed", "Khadki", "Pune"),
("3", "Saurabh", "Pashan", "Pune"),
("4", "Rohit", "Baner", "Pune"),
("5", "Hritik", "Sus Road", "Pune");

INSERT INTO car_driver VALUES
(1, "1", "M1"),
(2, "2", "M2"),
(3, "3", "M3"),
(4, "4", "M4"),
(5, "5", "M5");

INSERT INTO accident VALUES
(1, "Pune Nagar Road", 2021, "M2"),
(2, "Satara", 2000, "M1"),
(3, "Bangalore", 2017, "M1"),
(4, "Pune", 2008, "M3"),
(5, "Akola", 2000, "M5");

-- Display all tables
SELECT * FROM car;
SELECT * FROM driver;
SELECT * FROM car_driver;
SELECT * FROM accident;

-- Queries
SELECT a.a_place, a.a_year, c.c_no, c.c_model
FROM accident a
JOIN car c USING(c_no)
WHERE a.a_year = 2000;

SELECT d.d_no, d.d_name, a.a_place AS 'Accident Place'
FROM accident a
JOIN car_driver cd USING(c_no)
JOIN driver d USING(d_no)
WHERE a.a_year = 2000;

SELECT a.a_place, a.a_year, c.c_model
FROM accident a
JOIN car c USING(c_no)
WHERE c.c_model = "WagonR";

SELECT d.d_name, c.owner_name, a.a_place
FROM accident a
JOIN car_driver cd USING(c_no)
JOIN car c USING(c_no)
JOIN driver d USING(d_no)
WHERE a.a_place = "Pune Nagar Road";