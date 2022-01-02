USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS bill;
DROP TABLE IF EXISTS cust_call_info;
DROP TABLE IF EXISTS customer2;
DROP TABLE IF EXISTS plan;	

-- Table creation
CREATE TABLE plan(
	plan_no INT,
    p_name VARCHAR(20),
    no_of_free_calls INT,
    rate_per_call_per_min DOUBLE,
    free_call_time INT,
    fixed_amt DOUBLE,
    PRIMARY KEY(plan_no)
);

CREATE TABLE customer2(
	cust_no INT,
    name VARCHAR(20),
    mobile_no VARCHAR(10),
    plan_no INT,
    PRIMARY KEY(cust_no),
	FOREIGN KEY (plan_no) REFERENCES plan(plan_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cust_call_info(
	rec_no INT,
    cust_no INT,
    no_of_calls INT,
    total_talktime INT,
    cycle_period VARCHAR(20),
    PRIMARY KEY(rec_no),
	FOREIGN KEY (cust_no) REFERENCES customer2(cust_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE bill(
	rec_no INT,
    bill_no INT,
    cust_no INT UNIQUE,
    final_bill_amt DOUBLE,
    cycle_date DATE,
    bill_due_date DATE,
    status VARCHAR(10),
    bill_pay_date DATE,
	PRIMARY KEY(bill_no),
	FOREIGN KEY (cust_no) REFERENCES customer2(cust_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values
INSERT INTO plan VALUES
(1, "Plan1", 100, 10, 20, 200),
(2, "Plan2", 200, 20, 30, 300),
(3, "Plan3", 300, 20, 40, 400),
(4, "Plan4", 400, 40, 50, 500),
(5, "Plan5", 500, 50, 60, 600);

INSERT INTO customer2 VALUES
(1, "Deepak", "9000000001", 1),
(2, "Saurabh", "9000000002", 2),
(3, "Hritik", "9000000003", 3),
(4, "Mrs. Joshi", "9000000004", 4),
(5, "Kshitij", "9000000005", 1),
(6, "Abhishek", "9000000006", 2);

INSERT INTO cust_call_info VALUES
(1, 1, 200, 250, "jan-feb"),
(2, 2, 300, 360, "feb-oct"),
(3, 3, 90, 435, "apr-nov"),
(4, 4, 150, 208, "oct-dec"),
(5, 5, 80, 285, "may-june");

INSERT INTO bill VALUES
(1, 1, 1, 250, "2020-01-01", "2020-02-1", "Not paid", "2020-01-30"),
(2, 2, 2, 350, "2020-02-01", "2020-10-1", "Paid", "2020-9-30"),
(3, 3, 3, 660, "2020-04-01", "2020-11-1", "Not paid", "2020-10-30"),
(4, 4, 4, 580, "2020-10-01", "2020-12-1", "Paid", "2020-11-30"),
(5, 5, 5, 210, "2020-05-01", "2020-06-1", "Not paid", "2020-5-30");

-- Create View
CREATE OR REPLACE VIEW MrsJoshiBillDetails AS
SELECT c.name, b.*
FROM bill b
JOIN customer2 c USING(cust_no)
WHERE c.name = "Mrs. Joshi";

CREATE OR REPLACE VIEW Plan1CustomerDetails AS
SELECT c.*, p.p_name
FROM customer2 c
JOIN plan p USING(plan_no)
WHERE p.p_name = "Plan1";

-- Display View
SELECT *
FROM MrsJoshiBillDetails;

SELECT *
FROM Plan1CustomerDetails;
