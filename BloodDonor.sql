USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS blood;
DROP TABLE IF EXISTS donor;

-- Table creation
CREATE TABLE donor(
	donor_no INT,
    name VARCHAR(30),
    city VARCHAR(30),
    PRIMARY KEY(donor_no)
);

CREATE TABLE blood(
	blood_id INT,
    blood_group VARCHAR(30) NOT NULL,
    quantity FLOAT,
    rhfactor ENUM("Positive", "Negative"),
    date_of_collection DATE,
    donor_no INT,
    PRIMARY KEY(blood_id),
    FOREIGN KEY (donor_no) REFERENCES donor(donor_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO donor VALUES
(1, "Hritik", "Pune"),
(2, "Deepak", "Mumbai"),
(3, "Fahed", "Pune"),
(4, "Saurabh", "Banglore"),
(5, "Rohit", "Mumbai"),
(6, "Gaurav", "Satara"),
(7, "Arjun", "MP"),
(8, "Pranav", "Jhansi");

INSERT INTO blood VALUES
(1, "O+", 200, "Positive", "2008-04-11", 1),
(2, "O-", 100, "Positive", "2007-01-31", 2),
(3, "A+", 300, "Negative", "2021-10-01", 3),
(4, "A-", 100, "Positive", "2008-04-11", 4),
(5, "B+", 250, "Negative", "2007-01-31", 5),
(6, "B-", 150, "Negative", "2021-10-01", 6),
(7, "AB+", 145.5, "Positive", "2021-10-01", 7),
(8, "AB-", 195.6, "Positive", "2021-10-01", 8),
(9, "O-", 400.50, "Negative", "2007-01-31", 2),
(10, "A-", 175.34, "Positive", "2007-01-31", 4),
(11, "B+", 123.67, "Positive", "2008-04-11", 5),
(12, "AB-", 450.35, "Positive", "2021-10-01", 8);

-- Display all tables
SELECT * FROM donor;
SELECT * FROM blood;

-- Queries
SELECT COUNT(donor_no) AS 'Donor Count'
FROM blood
WHERE date_of_collection = "2008-04-11";

SELECT d.name, d.city
FROM blood b
JOIN donor d USING(donor_no)
WHERE b.blood_group LIKE "A%" AND b.rhfactor = "Negative";

SELECT SUM(quantity) AS 'Total quantity', blood_group
FROM blood
WHERE date_of_collection = "2007-01-31"
GROUP BY blood_group;

SELECT DISTINCT d.donor_no, d.name, b.blood_group
FROM blood b
JOIN donor d USING(donor_no)
ORDER BY d.name;