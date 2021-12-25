use cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS book2_author;
DROP TABLE IF EXISTS book2;
DROP TABLE IF EXISTS author;

-- Table creation
CREATE TABLE book2(
	book_no INT,
    name VARCHAR(30),
    pub_name VARCHAR(30) NOT NULL,
    pub_year DATE,
    PRIMARY KEY(book_no)
);

CREATE TABLE author(
	author_no INT,
    author_name VARCHAR(30) NOT NULL,
    PRIMARY KEY(author_no)
);

CREATE TABLE book2_author(
	sr_no INT,
    book_no INT,
    author_no INT,
    PRIMARY KEY(sr_no),
    FOREIGN KEY (book_no) REFERENCES book2(book_no) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (author_no) REFERENCES author(author_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO book2 VALUES
(101, "Ben Hur", "TCK Publishing", "2019-1-01"),
(200, "Mein Kampf", "Reed Elsevier", "2020-1-01"),
(300, "Time Machine", "Tata McgrawHill", "2019-10-01"),
(400, "A passage to India", "Simon & Schuster", "2019-05-01"),
(501, "Utopia", "Tata McgrawHill", "2021-12-01");

INSERT INTO author VALUES
(1, "Lewis Wallace"),
(2, "Adolf Hitler"),
(3, "H.G. Wells"),
(4, "E.M.Forster"),
(5, "Korth");

INSERT INTO book2_author VALUES
(1, 101, 1),
(2, 200, 2),
(3, 300, 3),
(4, 400, 4),
(5, 501, 5);

-- Display all tables
SELECT * FROM book2;
SELECT * FROM author;
SELECT * FROM book2_author;

-- Queries
SELECT *
FROM book2
ORDER BY pub_year DESC;

SELECT *
FROM book2
WHERE pub_name = "Tata McgrawHill";

SELECT 
	b.book_no,
    b.name as 'Book name',
    b.pub_name,
    b.pub_year,
    a.author_name
FROM book2_author ba
JOIN book2 b USING(book_no)
JOIN author a USING(author_no)
WHERE a.author_name = "Korth";

SELECT 
	b.name as 'Book name',
	a.author_name,
    b.pub_name
FROM book2_author ba
JOIN book2 b USING(book_no)
JOIN author a USING(author_no)
WHERE b.book_no = 101 AND b.pub_year LIKE "2019-%-%";