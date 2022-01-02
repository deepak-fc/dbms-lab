USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS bus_driver;
DROP TABLE IF EXISTS bus;
DROP TABLE IF EXISTS route;
DROP TABLE IF EXISTS driver2;

-- Table creation
CREATE TABLE route(
	route_no INT,
    source CHAR(20),
    destination CHAR(20),
    no_of_stations INT,
    PRIMARY KEY(route_no)
);

CREATE TABLE bus(
	bus_no INT,
    capacity INT NOT NULL,
    depot_name VARCHAR(20),
    route_no INT,
    PRIMARY KEY(bus_no),
	FOREIGN KEY(route_no) REFERENCES route(route_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE driver2(
	driver_no INT,
    driver_name CHAR(20),
    license_no INT UNIQUE,
    address CHAR(20),
    d_age INT,
    salary FLOAT,
    PRIMARY KEY(driver_no)
);

CREATE TABLE bus_driver(
	bus_no INT,
    driver_no INT,
    date_of_duty DATE,
    shift INT CHECK(shift = 1 OR shift = 2), 
    PRIMARY KEY(bus_no, driver_no),
    FOREIGN KEY(bus_no) REFERENCES bus(bus_no) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(driver_no) REFERENCES driver2(driver_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO route VALUES
(1, "Pashan", "Kothrud Depot", 10),
(2, "Kothrud Depot", "Sus Road", 5),
(3, "Shivajinagar", "Deccan", 7),
(4, "Panchavati", "Corporation", 3),
(5, "Pune University", "Aundh", 2);

INSERT INTO bus VALUES
(10, 50, "Kothrud Depot", 1),
(11, 30, "Corporation", 4),
(12, 40, "Aundh Depot", 5),
(13, 60, "Sus Depot", 2),
(14, 80, "Kothrud Depot", 1);

INSERT INTO driver2 VALUES
(1, "Deepak", 1005, "Pashan", 40, 35000),
(2, "Fahed", 1006, "Sus Road", 45, 50000),
(3, "Rohit", 1007, "Baner", 60, 25000),
(4, "Hritik", 1008, "Aundh", 38, 30000),
(5, "Saurabh", 1009, "Dapodi", 47, 25000);

INSERT INTO bus_driver VALUES
(10, 1, "2021-12-25", 1),
(10, 2, "2021-12-25", 2),
(11, 3, "2021-12-26", 1),
(11, 2, "2021-12-26", 2),
(12, 3, "2021-12-27", 1),
(12, 4, "2021-12-27", 2),
(13, 5, "2021-12-28", 1),
(13, 4, "2021-12-28", 2),
(14, 3, "2021-12-29", 1),
(14, 2, "2021-12-29", 2),
(10, 3, "2021-12-30", 1),
(10, 4, "2021-12-30", 2);

-- Create View
CREATE OR REPLACE VIEW Bus10DriverDetails AS
SELECT b.*, d.*
FROM bus_driver bd
JOIN bus b USING(bus_no)
JOIN driver2 d USING(driver_no)
WHERE b.bus_no = 10;

-- Confused on second view

-- Display View
SELECT *
FROM Bus10DriverDetails;
