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