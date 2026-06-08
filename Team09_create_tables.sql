--									                                       == Create Tables ==

-- TEAM 09 ; Alex, Esperanza, Heshna, Ryan


USE master;
GO
IF DB_ID('CMPT291_Team09_MovieRental') IS NOT NULL
BEGIN
	ALTER DATABASE CMPT291_Team09_MovieRental SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE CMPT291_Team09_MovieRental;
END;
GO
CREATE DATABASE CMPT291_Team09_MovieRental;
GO
USE CMPT291_Team09_MovieRental;
GO


--									= Table Creation = 

-- People, Customer + Dependency Tables \
CREATE TABLE AcctStatus (
	accountStatusID NUMERIC(1) ,
	accountState VARCHAR(15),
	PRIMARY KEY (accountStatusID)
);


CREATE TABLE People (
	peopleID CHAR(11) NOT NULL PRIMARY KEY,
	firstName NVARCHAR(15),
	lastName VARCHAR(20),
	accountStatusID NUMERIC(1),

	FOREIGN KEY (accountStatusID) REFERENCES AcctStatus(accountStatusID)
);

CREATE TABLE Customer ( 
	customerID CHAR(11) NOT NULL PRIMARY KEY,
	city CHAR(32),
	province CHAR(4),
	email VARCHAR(50),
	phoneNumber NUMERIC(10),
	peopleID CHAR(11) NOT NULL,

	FOREIGN KEY (peopleID) REFERENCES People(peopleID)
);
-- People, Customer + Dependency Tables \


-- Employee + Dependency Tables \
CREATE TABLE Permanency (
	permanencyID numeric(1) PRIMARY KEY,
	permancyDesc VARCHAR(40)
);

CREATE TABLE EmployeeRole (
	roleID NUMERIC(1) PRIMARY KEY,
	jobTitle VARCHAR(35),
	roleDesc VARCHAR(125),
	permanencyID numeric(1),

	FOREIGN KEY (permanencyID) REFERENCES Permanency(permanencyID)
);

CREATE TABLE Employee (
	employeeID CHAR(11) NOT NULL PRIMARY KEY,
	peopleID CHAR(11) NOT NULL,
	SSN NUMERIC(9) NOT NULL,
	roleID NUMERIC(1) NOT NULL,

	FOREIGN KEY (roleID) REFERENCES EmployeeRole(roleID)
);
-- Employee + Dependency Tables/



-- Movie + Dependent
CREATE TABLE Movie (
	movieID NUMERIC(10) NOT NULL PRIMARY KEY,
	movieName VARCHAR(75) NOT NULL,
	releaseDate DATE,
	copiesAvailable SMALLINT,
	copiesTotal SMALLINT NOT NULL,
	copiesRented SMALLINT,
	copiesMissing SMALLINT,
	distributionPrice smallMoney
);

CREATE TABLE Genre (
	movieID NUMERIC(10) NOT NULL,
	genreString VARCHAR(25)
	
	FOREIGN KEY(movieID) REFERENCES Movie(movieID)
);

CREATE TABLE MovieQueue (
	queueID TINYINT NOT NULL PRIMARY KEY,
	movieID NUMERIC(10) NOT NULL,
	
	FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);


-- Customer, Movie Dependency Tables\
CREATE TABLE JoinQueue(
	customerID CHAR(11) NOT NULL,
	queueID TINYINT NOT NULL,
	queuePosition TINYINT NOT NULL
	
	FOREIGN KEY (customerID) REFERENCES Customer(customerID),
	FOREIGN KEY (queueID) REFERENCES MovieQueue(queueID)
);


CREATE TABLE Ratings (
	ratingID NUMERIC(10) NOT NULL PRIMARY KEY,
	FK_customerID CHAR(11) NOT NULL,
	
	FOREIGN KEY (FK_customerID) REFERENCES Customer(customerID)
);

CREATE TABLE MovieRating (
	ratingID NUMERIC(10) NOT NULL PRIMARY KEY,
	FK_movieID NUMERIC(10) NOT NULL,
	score NUMERIC(2,1),
	movieReview VARCHAR(250),
	
	FOREIGN KEY (FK_movieID) REFERENCES Movie(movieID),
	FOREIGN KEY (ratingID) REFERENCES Ratings(ratingID),

	CONSTRAINT chkMovScore
		CHECK (score BETWEEN 1 AND 5)
);

-- Actor, Movie Dependency Tables/




-- Actor + Ratings Dependency/
CREATE TABLE Actor (
	actorID NUMERIC(4) NOT NULL PRIMARY KEY,
	gender CHAR(1),
	DOB DATE,
	firstName NVARCHAR(25),
	lastName NVARCHAR(25)
);



CREATE TABLE ActorRating (
	ratingID NUMERIC(10) NOT NULL PRIMARY KEY,
	FK_actorID NUMERIC (4) NOT NULL,
	score NUMERIC(2,1),
	
	FOREIGN KEY(FK_actorID) REFERENCES Actor(actorID),
	FOREIGN KEY(ratingID) REFERENCES Ratings(ratingID),

	CONSTRAINT chkActScore 
		CHECK (score BETWEEN 1 AND 5)
);



-- Actor + Ratings Dependency/


-- Movie, Actor Dependencies
CREATE TABLE Features (
	FK_movieID NUMERIC(10) NOT NULL,
	FK_actorID NUMERIC (4) NOT NULL,

	FOREIGN KEY(FK_movieID) REFERENCES Movie(movieID),
	FOREIGN KEY(FK_actorID) REFERENCES Actor(actorID)
);


-- Order Context
CREATE TABLE OrderContext (
	contextID NUMERIC(1) NOT NULL PRIMARY KEY,
	orderStatus VARCHAR(15) NOT NULL,
);

CREATE TABLE Orders (
	orderID NUMERIC(4) NOT NULL PRIMARY KEY,
	issueDate DATE NOT NULL,
	dueDate DATE NOT NULL,
	employeeID CHAR(11) NOT NULL,
	customerID CHAR(11) NOT NULL,
	contextID NUMERIC(1) NOT NULL,
	movieID NUMERIC(10) NOT NULL,
	returnDate DATE,

	FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
	FOREIGN KEY (customerID) REFERENCES Customer(customerID),
	FOREIGN KEY (contextID) REFERENCES OrderContext(contextID),
	FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);
