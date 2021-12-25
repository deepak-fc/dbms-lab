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