-- confused if M:M relationship of train and passenger, should it have third table or ticket2 is the linking table?
-- Have not created link table, instead created ticket2 table.

USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS ticket2;
DROP TABLE IF EXISTS passenger;
DROP TABLE IF EXISTS train;


-- Table creation
CREATE TABLE train(
	train_no INT,
    train_name VARCHAR(20),
    depart_time TIME,
    arrival_time TIME,
    source_stn VARCHAR(20),
    dest_stn VARCHAR(20),
    no_of_res_bogies INT,
    bogie_capacity INT,
    PRIMARY KEY(train_no)
);

CREATE TABLE passenger(
	passenger_id INT,
    passenger_name VARCHAR(20),
    address VARCHAR(30),
    age INT,
    gender CHAR,
    PRIMARY KEY(passenger_id)
);

CREATE TABLE ticket2(
	train_no INT,
    passenger_id INT,
    ticket2_no INT,
    bogie_no INT,
    no_of_berths INT,
    t_date DATE,
    ticket2_amt DECIMAL(7,2),
    status CHAR,
    PRIMARY KEY(train_no, passenger_id, ticket2_no),
    FOREIGN KEY (train_no) REFERENCES train(train_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert values