USE cafy21582;

-- Drop Tables
DROP TABLE IF EXISTS student2_competition;
DROP TABLE IF EXISTS student2;
DROP TABLE IF EXISTS competition;

-- Table creation
CREATE TABLE student2(
	sreg_no INT,
    name char(30),
    class char(10),
    PRIMARY KEY(sreg_no)
);

CREATE TABLE competition(
	c_no INT,
    name CHAR(20),
    type char(15),
    PRIMARY KEY(c_no)
);

CREATE TABLE student2_competition(
	sreg_no INT,
    c_no int,
    s_rank int,
    year int,
    PRIMARY KEY(sreg_no, c_no),
	foreign key (sreg_no) references student2(sreg_no) on delete cascade on update cascade,
    foreign key (c_no) references competition(c_no) on delete cascade on update cascade
);

-- Insert values