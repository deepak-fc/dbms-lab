USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS workshop_participant;
DROP TABLE IF EXISTS participant;
DROP TABLE IF EXISTS workshop;

-- Table creation
CREATE TABLE workshop(
	w_id VARCHAR(30),
    w_title VARCHAR(30),
    no_of_speakers INT,
    designation VARCHAR(30),
    fees FLOAT,
    PRIMARY KEY(w_id)
);

CREATE TABLE participant(
	p_id VARCHAR(30),
    p_name VARCHAR(30), 
    w_id VARCHAR(30),
    PRIMARY KEY(p_id),
    FOREIGN KEY (w_id) REFERENCES workshop(w_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE workshop_participant(
    p_id VARCHAR(30),
    w_id VARCHAR(30),
    PRIMARY KEY(p_id, w_id),
    FOREIGN KEY (p_id) REFERENCES participant(p_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (w_id) REFERENCES workshop(w_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO workshop VALUES
("1", "Management Workshop", 3, "Senior Managers" ,2000),
("2", "Lunch and Learn", 4, "Junior Managers", 5000),
("3", "Self Defence", 2, "Interns", 9000),
("4", "Vision Board Workshop", 1, "Associates", 8000),
("5", "Mindfulness Workshop", 1, "Everyone", 1000);

INSERT INTO participant VALUES
("1", "Rishi", "1"),
("2", "Kshitij", "3"),
("3", "Abhishek", "4"),
("4", "Kedar", "4"),
("5", "Vedant", "5"),
("6", "Atharva", "2");

INSERT INTO workshop_participant VALUES
("1", "1"),
("2", "3"),
("3", "4"),
("4", "4"),
("5", "5"),
("5", "2");

-- Display all tables
SELECT * FROM workshop;
SELECT * FROM participant;
SELECT * FROM workshop_participant;

-- Queries
SELECT p.p_name, w.w_title
FROM participant p
JOIN workshop w USING (w_id)
WHERE w.no_of_speakers > 2;

SELECT p.p_id, p.p_name, w.w_id
FROM workshop w
JOIN participant p USING(w_id)
WHERE w.designation IN ("Senior Managers", "Junior Managers");

SELECT w.w_id, w.w_title, wp.p_id
FROM workshop_participant wp
JOIN workshop w USING(w_id)
JOIN participant p USING(p_id)
WHERE w.fees BETWEEN 5000 AND 8000;