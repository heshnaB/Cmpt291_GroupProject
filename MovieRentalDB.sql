-- Initialize Database ------------------------------------------------------------------------------

USE master;
GO
IF DB_ID('Movie_Rental_DB') IS NOT NULL
BEGIN
	ALTER DATABASE Movie_Rental_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Movie_Rental_DB;
END;
GO
CREATE DATABASE Movie_Rental_DB;
GO
USE Movie_Rental_DB;
GO

-- Initialize Tables --------------------------------------------------------------------------------

CREATE TABLE AcctStatus (
	accountStatusID NUMERIC(1) NOT NULL,
	accountState VARCHAR(15) NOT NULL,
	PRIMARY KEY (accountStatusID)
);

CREATE TABLE People (
	peopleID CHAR(11) NOT NULL,
	firstName NVARCHAR(15) NOT NULL ,
	lastName VARCHAR(20) NOT NULL,
	accountStatusID NUMERIC(1) NOT NULL,
	PRIMARY KEY (peopleID),
	FOREIGN KEY (accountStatusID) REFERENCES AcctStatus(accountStatusID)
);


CREATE TABLE Permanency (
	permanencyID numeric(1) PRIMARY KEY NOT NULL,
	permancyDesc VARCHAR(40)
);

CREATE TABLE EmployeeRole (
	roleID NUMERIC(1) PRIMARY KEY NOT NULL,
	jobTitle VARCHAR(35) NOT NULL,
	roleDesc VARCHAR(50),
	permanencyID numeric(1) NOT NULL,

	FOREIGN KEY (permanencyID) REFERENCES Permanency(permanencyID)
);


CREATE TABLE Employee (
	employeeID CHAR(11) NOT NULL,
	peopleID CHAR(11) NOT NULL,
	SSN NUMERIC(9) NOT NULL,
	roleID NUMERIC(1) NOT NULL,
	PRIMARY KEY (employeeID),
	FOREIGN KEY (roleID) REFERENCES EmployeeRole(roleID)
);
CREATE TABLE Customer (
	customerID CHAR(11) NOT NULL,
	city CHAR(20),
	province CHAR(4),
	email VARCHAR(50),
	phoneNumber NUMERIC(10),
	peopleID CHAR(11) NOT NULL,
	PRIMARY KEY (customerID),
	FOREIGN KEY (peopleID) REFERENCES People(peopleID)
);

CREATE TABLE Movie (
	movieID NUMERIC(10) NOT NULL,
	movieName VARCHAR(50) NOT NULL,
	releaseDate DATE,
	copiesAvailable SMALLINT,
	copiesTotal SMALLINT NOT NULL,
	copiesRented SMALLINT,
	copiesMissing SMALLINT,
	distributionPrice smallMoney,
	PRIMARY KEY (movieID)
);
CREATE TABLE MovieQueue (
	queueID TINYINT NOT NULL,
	queuePosition TINYINT NOT NULL,
	movieID NUMERIC(10) NOT NULL,
	customerID CHAR(11) NOT NULL,
	PRIMARY KEY (queueID),
	FOREIGN KEY (movieID) REFERENCES Movie(movieID),
	FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Joins (
	customerID CHAR(11) NOT NULL,
	queueID TINYINT NOT NULL,
	FOREIGN KEY (customerID) REFERENCES Customer(customerID),
	FOREIGN KEY (queueID) REFERENCES MovieQueue(queueID)
);

CREATE TABLE OrderContext (
	contextID NUMERIC(1) NOT NULL,
	orderStatus VARCHAR(10) NOT NULL,
	PRIMARY KEY (contextID)
);

CREATE TABLE Orders (
	orderID NUMERIC(1) NOT NULL,
	issueDate DATE NOT NULL,
	dueDate DATE NOT NULL,
	employeeID CHAR(11) NOT NULL,
	customerID CHAR(11) NOT NULL,
	contextID NUMERIC(1) NOT NULL,
	movieID NUMERIC(10) NOT NULL,
	returnDate DATE NULL,
	PRIMARY KEY (orderID),
	FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
	FOREIGN KEY (customerID) REFERENCES Customer(customerID),
	FOREIGN KEY (contextID) REFERENCES OrderContext(contextID),
	FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);

CREATE TABLE Actor (
	actorID CHAR(11) NOT NULL,
	gender CHAR(1),
	DOB DATE,
	firstName NVARCHAR(25),
	lastName NVARCHAR(25),
	PRIMARY KEY (actorID)
);

CREATE TABLE Ratings (
	ratingID NUMERIC(10) NOT NULL,
	customerID CHAR(11) NOT NULL,
	PRIMARY KEY (ratingID),
	FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE MovieRating (
	ratingID NUMERIC(10) NOT NULL,
	movieID NUMERIC(10) NOT NULL,
	score NUMERIC(2,1),
	movieReview VARCHAR(250),
	PRIMARY KEY (ratingID),
	FOREIGN KEY (movieID) REFERENCES Movie(movieID),
	FOREIGN KEY (ratingID) REFERENCES Ratings(ratingID),

	CONSTRAINT chkMovScore
		CHECK (score BETWEEN 1 AND 5)
);

CREATE TABLE ActorRating (
	ratingID NUMERIC(10) NOT NULL,
	actorID CHAR(11) NOT NULL,
	score NUMERIC(2,1),
	PRIMARY KEY (ratingID),
	FOREIGN KEY(actorID) REFERENCES Actor(actorID),
	FOREIGN KEY(ratingID) REFERENCES Ratings(ratingID),

	CONSTRAINT chkActScore 
		CHECK (score BETWEEN 1 AND 5)
);


CREATE TABLE Features (
	movieID NUMERIC(10) NOT NULL,
	actorID CHAR(11) NOT NULL,
	FOREIGN KEY(movieID) REFERENCES Movie(movieID),
	FOREIGN KEY(actorID) REFERENCES Actor(actorID)
);

CREATE TABLE Genre (
	movieID NUMERIC(10) NOT NULL,
	genreString VARCHAR(25) NOT NULL,
	FOREIGN KEY(movieID) REFERENCES Movie(movieID)
);




--                     == Demonstrating Tables ==
SELECT * FROM AcctStatus
SELECT * FROM People
SELECT * FROM EmployeeRole
SELECT * FROM Employee
SELECT * FROM Customer


SELECT * FROM Movie
SELECT * FROM MovieQueue
SELECT * FROM Joins

SELECT * FROM OrderContext
SELECT * FROM Orders

SELECT * FROM Actor

SELECT * FROM Ratings
SELECT * FROM ActorRating
SELECT * FROM MovieRating
SELECT * FROM Features
SELECT * FROM Genre





--             = Constraint Testing = 

-- Can we add a rating that is >0 , =0, OR <5?
