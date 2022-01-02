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
INSERT INTO train VALUES
(1, "Duronto Exp", "04:10:00", "04:00:00", "Pune", "H Nizamuddin", 20, 50),
(2, "Lucknow AC Exp", "10:15:00", "10:00:00", "Goa", "Lucknow", 40, 70),
(3, "Shatabdi Express", "20:20:00", "19:50:00", "Howrah", "Jodhpur", 10, 20),
(4, "Jammu Tawi", "22:10:00", "22:00:00", "Jammu Tawi", "Delhi", 15, 30),
(5, "Aug Kr Raj Express", "03:25:00", "03:00:00", "Mumbai Central", "H Nizamuddin", 40, 45);

INSERT INTO passenger VALUES
(1, "Deepak", "Panchavati", 21, "M"),
(2, "Hritik", "Sus Road", 22, "M"),
(3, "Fahed", "Dapodi", 20, "M"),
(4, "Saurabh", "Pashan", 21, "M"),
(5, "Rohit", "Baner", 22, "M");

INSERT INTO ticket2 VALUES
(1, 1, 1001, 1, 20, "2009-06-03", 5000, "C"),
(1, 2, 2001, 2, 10, "2009-06-03", 2300, "C"),
(2, 3, 3001, 3, 5, "2020-8-11", 3456, "W"),
(2, 4, 4001, 4, 6, "2020-7-12", 1247, "W"),
(3, 5, 5001, 5, 7, "2019-08-10", 9734, "W"),
(3, 1, 6001, 6, 8, "2021-5-30", 1734, "W"),
(4, 2, 7001, 7, 9, "2021-4-02", 1894, "W"),
(4, 3, 8001, 8, 7, "2021-3-19", 2500, "W"),
(5, 4, 9001, 9, 4, "2021-2-17", 3250, "C"),
(5, 5, 10001, 10, 3, "2021-1-28", 4000, "C");


-- Create View
CREATE OR REPLACE VIEW DurontoExpCustomerDetails AS
SELECT p.*, t.train_name, ti.t_date
FROM ticket2 ti
JOIN passenger p USING(passenger_id)
JOIN train t USING(train_no)
WHERE t.train_name = "Duronto Exp" AND ti.t_date = "2009-06-03";

CREATE OR REPLACE VIEW ShatabdiWaitingPassengerNames AS
SELECT p.passenger_name, t.train_name, ti.status, ti.t_date
FROM ticket2 ti
JOIN passenger p USING(passenger_id)
JOIN train t USING(train_no)
WHERE t.train_name = "Shatabdi Express" AND 
	  ti.t_date = "2019-08-10" AND
      ti.status = "W";
      
-- Display View
SELECT *
FROM DurontoExpCustomerDetails;

SELECT *
FROM ShatabdiWaitingPassengerNames;
