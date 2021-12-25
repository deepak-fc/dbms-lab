USE cafy21582;

-- Drop tables
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

-- Table creation
CREATE TABLE department(
	dept_no INT,
    d_name VARCHAR(30),
    loc VARCHAR(30),
    PRIMARY KEY(dept_no)
);

CREATE TABLE employee(
	emp_no INT,
    e_name VARCHAR(30),
    salary INT,
    designation VARCHAR(30),
    comm INT,
    dept_no INT,
    doj DATE,
    PRIMARY KEY(emp_no),
    FOREIGN KEY(dept_no) REFERENCES department(dept_no)
);

-- Insert values
INSERT INTO department VALUES	
(1, "IT", "Mumbai"),
(2, "Accounts", "Nashik"),
(3, "Tech Support", "Pune"),
(4, "Management", "Pune"),
(5, "Executive board", "Bangalore");

INSERT INTO employee VALUES	
(7033, "Deepak", 20000, "Intern", 5000, 1, "2018-12-12"),
(7369, "Fahed", 10000, "Intern", 2500, 1, "2021-02-015"),
(1256, "Hritik", 75000, "Accountant", 10000, 2, "2017-07-30"),
(4000, "Saurabh", 150000, "Executive", 20000, 4, "2016-04-02"),
(7836, "Rohit", 50000, "Assistant", 15000, 3, "2020-10-07");

-- Display all tables
SELECT * FROM department;
SELECT * FROM employee;

-- Queries
SELECT designation, MAX(salary), MIN(salary), AVG(salary)
FROM employee
GROUP BY designation;

SELECT e.emp_no, e.e_name, e.designation, e.doj, d.loc
FROM employee e
JOIN department d ON e.dept_no = d.dept_no
WHERE d.loc = "Pune";

SELECT *
FROM employee e
JOIN department d ON e.dept_no = d.dept_no
WHERE e.designation = "Accountant" AND d.loc = "Nashik";

SELECT *
FROM employee e
JOIN department d ON e.dept_no = d.dept_no
ORDER BY d_name;

SELECT *
FROM employee
WHERE doj <= "2018-12-12";

SELECT *
FROM employee
WHERE designation = (
				SELECT designation
				FROM employee
				WHERE emp_no = 7369);