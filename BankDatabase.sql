USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS branch;

-- Table creation
CREATE TABLE customer(
	cust_no INT,
    cust_name CHAR(20),
    cust_street CHAR(15),
    cust_city VARCHAR(20),
    PRIMARY KEY(cust_no)
);

CREATE TABLE branch(
	branch_no INT,
    branch_name CHAR(20) NOT NULL,
    branch_city VARCHAR(20),
    PRIMARY KEY(branch_no)
);
CREATE TABLE account(
	acc_no INT,
    acc_type CHAR(10),
    balance FLOAT(8,2),
    cust_no INT,
    branch_no INT,
    PRIMARY KEY(acc_no),
	FOREIGN KEY(cust_no) REFERENCES customer(cust_no) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(branch_no) REFERENCES branch(branch_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE loan(
	loan_no INT,
    loan_amt DOUBLE(9,2),
    no_of_years INT,
	cust_no INT,
    branch_no INT,
    PRIMARY KEY(loan_no),
    FOREIGN KEY(cust_no) REFERENCES customer(cust_no) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(branch_no) REFERENCES branch(branch_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO customer VALUES
(1, "Vijay Mallya", "Park Street", "Pune"),
(2, "Nirav Modi", "Regent Street", "Satara"),
(3, "Fahed", "Oxford Street", "Mumbai"),
(4, "Rohit", "Bond Street", "Nagpur"),
(5, "Saurabh", "Vine Street", "Nashik");

INSERT INTO branch VALUES
(1, "F.C Road", "Pune"),
(2, "M.G Road", "Mumbai"),
(3, "Shivajinagar", "Pune"),
(4, "Pashan", "Nashik"),
(5, "Aundh", "Akola");

INSERT INTO account VALUES
(1, "Savings", 200000, 1, 1),
(2, "Salary", 150000, 2, 3),
(3, "Current", 75000, 3, 1),
(4, "Business", 96750, 4, 2),
(5, "Checking", 325000, 5, 5),
(6, "Checking", 87000, 1, 5),
(7, "Business", 96000, 2, 3);

INSERT INTO loan VALUES
(1, 80000, 2, 1, 1),
(2, 500000, 1, 2, 3),
(3, 350000, 2, 3, 1),
(4, 900000, 3, 1, 1),
(5, 4000000, 6, 2, 3);

-- Create View
CREATE OR REPLACE VIEW CustomerAccountDetails AS
SELECT c.*, a.acc_type, a.balance, b.branch_name, b.branch_city
FROM account a
JOIN customer c USING(cust_no)
JOIN branch b USING(branch_no);

CREATE OR REPLACE VIEW FCRoadLoanDetails AS
SELECT l.loan_no, l.loan_amt, l.no_of_years, c.cust_name, b.branch_name 
FROM loan l
JOIN customer c USING(cust_no)
JOIN branch b USING(branch_no)
WHERE b.branch_name = "F.C Road";

-- Display View
SELECT *
FROM CustomerAccountDetails;

SELECT *
FROM FCRoadLoanDetails;


-- Drop Functions
DROP FUNCTION IF EXISTS branchTotalLoanAmount;
DROP FUNCTION IF EXISTS branchTotalCustomers;


-- Create Functions
delimiter //
CREATE FUNCTION branchTotalLoanAmount(branch_name CHAR(20))
RETURNS FLOAT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE totalLoanAmount FLOAT DEFAULT 0;
    SET totalLoanAmount = (SELECT SUM(l.loan_amt)
							FROM loan l
                            JOIN branch b USING(branch_no)
                            WHERE b.branch_name = branch_name); 
	RETURN totalLoanAmount;	
END//
delimiter ;


delimiter //
CREATE FUNCTION branchTotalCustomers(branch_name CHAR(20))
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE numberOfCustomers INT DEFAULT 0;
    SET numberOfCustomers = (SELECT COUNT(a.cust_no)
							FROM account a
                            JOIN branch b USING(branch_no)
                            WHERE b.branch_name = branch_name
                            GROUP BY b.branch_name);
	RETURN numberOfCustomers;
END//
delimiter ;


-- Display Function
SELECT BRANCHTOTALLOANAMOUNT("F.C Road");
SELECT BRANCHTOTALCUSTOMERS("F.C Road");