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