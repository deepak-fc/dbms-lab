USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS machine;

-- Table creation
CREATE TABLE machine(
    m_no INT,
    name VARCHAR(30) NOT NULL,
    m_type VARCHAR(30),
    m_cost FLOAT,
    PRIMARY KEY(m_no)
);

CREATE TABLE part(
    p_no INT,
    p_name VARCHAR(30),
    p_desc VARCHAR(50),
    m_no INT,
    PRIMARY KEY(p_no),
    FOREIGN KEY (m_no) REFERENCES machine(m_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO machine VALUES
(1, "Vending Machine", "Vending", 50000),
(2, "Milling Machine", "Indudtrial", 300000),
(3, "Sewing Machine", "Vintage", 10000),
(4, "Labeling Machine", "Industrial", 250000),
(5, "Parts Badger", "Industrial", 75000);

INSERT INTO part VALUES
(1, "Coinco BA30B", "Bill validator", 1),
(2, "Dixie Narco", "Condenser", 1),
(3, "Spindle", "Circular Spindle", 2),
(4, "Spool pin", "Pin 5mm", 3),
(5, "Electric Cabinet", "Size 10x10cm", 4),
(6, "Insinkerator", "Disposable badge", 5);

-- Display all tables
SELECT * FROM machine;
SELECT * FROM part;

-- Queries
UPDATE machine
SET m_cost = m_cost + ((m_cost * 10) / 100);
SELECT * FROM machine;

SELECT m.m_no, m.name, m.m_type, m.m_cost, p.p_name, p.p_desc
FROM part p
JOIN machine m USING(m_no);

SELECT p.p_no, p.p_name, p.p_desc
FROM part p
JOIN machine m USING(m_no)
WHERE m.m_cost < 20000;

SELECT m.name, COUNT(p.p_no) AS 'Parts'
FROM part p
JOIN machine m USING(m_no)
GROUP BY(m.name);