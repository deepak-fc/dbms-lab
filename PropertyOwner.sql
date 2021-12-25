USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS property;
DROP TABLE IF EXISTS district;
DROP TABLE IF EXISTS owner;

-- Table creation
CREATE TABLE owner(
    o_name VARCHAR(30) NOT NULL,
    o_address VARCHAR(30),
    o_phone VARCHAR(10),
    PRIMARY KEY(o_name)
);

CREATE TABLE district(
    d_code INT NOT NULL,
    d_name VARCHAR(30),
    tax_rate FLOAT,
    PRIMARY KEY(d_code)
);

CREATE TABLE property(
	p_number INT NOT NULL,
    description VARCHAR(30),
    area FLOAT,
    o_name VARCHAR(30),
    d_code INT,
    PRIMARY KEY(p_number),
    FOREIGN KEY (o_name) REFERENCES owner(o_name) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (d_code) REFERENCES district(d_code) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO owner VALUES
("Hritik", "Sus Road, Pashan", "0948534567"),
("Deepak", "Panchavati, NCL Road", "7628482848"),
("Fahed", "Khadki", "9726153748"),
("Saurabh", "Pashan", "7384726389"),
("Mr. Dev", "Baner", "8374636254");

INSERT INTO district VALUES
(1, "Nashik", 25.5),
(2, "Pune", 10.5),
(3, "Dhule", 35.0),
(4, "Sangli", 5.0),
(5, "Solapur", 18.0);

INSERT INTO property VALUES
(1, "Villa with 1 pool", 1000, "Hritik", 1),
(2, "Farm house", 4000, "Mr. Dev", 4),
(3, "2bhk Flat", 2000.5 , "Mr. Dev", 4),
(4, "Bungalow", 5000, "Saurabh", 4),
(5, "Farming Land", 20000, "Fahed", 1),
(6, "Rental Guest House", 30000, "Saurabh", 2);

-- Display all tables
SELECT * FROM owner;
SELECT * FROM district;
SELECT * FROM property;

-- Queries
SELECT o.o_name, p.description, d.d_name
FROM property p
JOIN owner o USING(o_name)
JOIN district d USING(d_code);

SELECT p.p_number, p.description, p.area AS 'Area in sq'
FROM property p
JOIN district d USING(d_code)
WHERE d.d_name = "Nashik";

SELECT SUM(p.area) AS 'Total Area Owned' 
FROM property p
JOIN district d USING(d_code)
JOIN owner o USING(o_name)
WHERE d.d_name = "Sangli" AND o.o_name = "Mr. Dev";

SELECT d.d_name, p.description, o.o_name, p.area, d.tax_rate 
FROM property p
JOIN district d USING(d_code)
JOIN owner o USING(o_name)
ORDER BY d.d_name;