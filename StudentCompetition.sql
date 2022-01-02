USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS student2_competition;
DROP TABLE IF EXISTS student2;
DROP TABLE IF EXISTS competition;

-- Table creation
CREATE TABLE student2(
	sreg_no INT,
    name CHAR(30),
    class CHAR(10),
    PRIMARY KEY(sreg_no)
);

CREATE TABLE competition(
	c_no INT,
    name CHAR(20),
    type CHAR(15),
    PRIMARY KEY(c_no)
);

CREATE TABLE student2_competition(
	sreg_no INT,
    c_no INT,
    s_rank INT,
    year INT,
    PRIMARY KEY(sreg_no, c_no),
	FOREIGN KEY (sreg_no) REFERENCES student2(sreg_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (c_no) REFERENCES competition(c_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO student2 VALUES
(1, "Deepak", "FYMCA"),
(2, "Rohit", "SYMCA"),
(3, "Fahed", "FYMCA"),
(4, "Saurabh", "SYMCA"),
(5, "Hritik", "FYMCA");

INSERT INTO competition VALUES
(1, "Gaming", "E-Sport"),
(2, "Tennis", "Outdoor"),
(3, "Chess", "Indoor"),
(4, "Football", "Outdoor"),
(5, "Cricket", "Outdoor");

INSERT INTO student2_competition VALUES
(1, 1, 1, 2021),
(2, 2, 2, 2021),
(3, 3, 1, 2021),
(4, 4, 2, 2021),
(5, 5, 3, 2021),
(1, 5, 4, 2020),
(1, 2, 5, 2020),
(3, 1, 6, 2020),
(3, 2, 7, 2020),
(5, 3, 3, 2020);


-- Create View
CREATE OR REPLACE VIEW CompetitionNameType AS
SELECT name, type
FROM competition
ORDER BY type;

CREATE OR REPLACE VIEW StudentRankDetails AS
SELECT s.name AS 'Stdent Name', s.class, c.name AS 'Competition Name', sc.s_rank, sc.year
FROM student2_competition sc
JOIN competition c USING(c_no)
JOIN student2 s USING(sreg_no)
ORDER BY s.name;
      
-- Display View
SELECT *
FROM CompetitionNameType;

SELECT *
FROM StudentRankDetails;
