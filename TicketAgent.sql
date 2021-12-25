USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS agent_ticket;
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS agent;

-- Table creation
CREATE TABLE agent(
	a_code VARCHAR(30),
    a_name VARCHAR(30),
    PRIMARY KEY(a_code)
);

CREATE TABLE ticket(
	t_code VARCHAR(30),
    passenger_name VARCHAR(30), 
    no_of_tickets INT,
    a_code VARCHAR(30),
    booking_date DATE,
    PRIMARY KEY(t_code),
    FOREIGN KEY (a_code) REFERENCES agent(a_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE agent_ticket(
    t_code VARCHAR(30),
    a_code VARCHAR(30),
    PRIMARY KEY(t_code, a_code),
    FOREIGN KEY (t_code) REFERENCES ticket(t_code) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (a_code) REFERENCES agent(a_code) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Insert values
INSERT INTO agent VALUES
("1", "Mr.XXX"),
("2", "Hritik"),
("3", "Deepak"),
("4", "Fahed"),
("5", "Rohit");

INSERT INTO ticket VALUES
("1", "Rishi", 2, 1, "2020-10-01"),
("2", "Kshitij", 3, 2, "2000-05-10"),
("3", "Abhishek", 1, 1, "2017-06-22"),
("4", "Kedar", 10, 3, "2021-01-05"),
("5", "Vedant", 5, 4, "2018-10-07"),
("6", "Atharva", 3, 5, "2020-12-12");

INSERT INTO agent_ticket VALUES
("1", "1"),
("2", "2"),
("3", "1"),
("4", "3"),
("5", "4"),
("6", "5");

-- Display all tables
SELECT * FROM agent;
SELECT * FROM ticket;
SELECT * FROM agent_ticket;

-- Queries
SELECT t.t_code, t.passenger_name, a.a_name
FROM ticket t
JOIN agent a USING(a_code)
WHERE t.no_of_tickets < 5;

SELECT a.a_name, COUNT(a_t.a_code) AS 'Total tickets booked'
FROM agent_ticket AS a_t
JOIN agent a USING(a_code)
WHERE a.a_name = "Mr.XXX";

SELECT a.a_code, a.a_name, a_t.t_code
FROM agent_ticket a_t
JOIN agent a USING(a_code)
WHERE a.a_name LIKE "%k";

SELECT *
FROM ticket
ORDER BY booking_date DESC;