USE cafy21582;

-- Drop tables
DROP TABLE IF EXISTS iss_rec;
DROP TABLE IF EXISTS membership;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS student ;

-- Table creation
CREATE TABLE student(
	stud_no VARCHAR(30),
    stud_name VARCHAR(30),
    PRIMARY KEY(stud_no)
);

CREATE TABLE membership(
	mem_no VARCHAR(30),
    stud_no VARCHAR(30),
    PRIMARY KEY(mem_no),
    FOREIGN KEY(stud_no) REFERENCES student(stud_no)
);

CREATE TABLE book(
	book_no VARCHAR(30),
    book_name VARCHAR(30),
    author VARCHAR(30),
    PRIMARY KEY(book_no)
);

CREATE TABLE iss_rec(
	iss_no VARCHAR(30),
    iss_date DATE,
    mem_no VARCHAR(30),
    book_no VARCHAR(30),
    PRIMARY KEY(iss_no),
    FOREIGN KEY(mem_no) REFERENCES membership(mem_no),
    FOREIGN KEY(book_no) REFERENCES book(book_no)
);

-- Insert values
INSERT INTO student VALUES	
(1, "Deepak"),
(2, "Rohit"),
(3, "Hritik"),
(4, "Saurabh"),
(5, "Fahed");

INSERT INTO membership VALUES	
(100, 1),
(200, 2),
(300, 3),
(400, 4),
(500, 5);

INSERT INTO book VALUES
(1, "Sword of Shanara", "Max Peterson"),
(2, "Harry Potter", "J.K Rowling"),
(3, "3 Mistakes of my life", "Chetan Bhagat"),
(4, "The T", "Korth"),
(5, "Real", "Katy Evans");

INSERT INTO iss_rec VALUES
(1, "2021-02-10", 100, 4),
(2, "2020-01-20", 200, 3),
(3, "2018-03-01", 500, 2),
(4, "2015-12-25", 300, 1),
(5, "2020-07-03", 500, 5);

-- Display all tables
SELECT * FROM student;
SELECT * FROM membership;
SELECT * FROM book;
SELECT * FROM iss_rec;

-- Queries
SELECT *
FROM books
WHERE author = "Korth";

SELECT *
FROM books
ORDER BY book_name;

SELECT *
FROM student
ORDER BY stud_name;

SELECT s.stud_name, COUNT(s.stud_name) AS 'Number Of Books Bought'
FROM iss_rec ir
JOIN membership m USING(mem_no)
JOIN student s USING(stud_no)
GROUP BY s.stud_name;

SELECT m.stud_no, b.book_no, b.book_name, b.author 
FROM iss_rec ir
JOIN membership m USING(mem_no)
JOIN book b USING(book_no)
WHERE m.stud_no = 5;