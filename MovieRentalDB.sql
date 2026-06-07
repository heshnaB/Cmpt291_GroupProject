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

--                                       = Table Creation = 

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
	movieName VARCHAR(50) NOT NULL,
	releaseDate DATE,
	copiesAvailable SMALLINT,
	copiesTotal SMALLINT NOT NULL,
	copiesRented SMALLINT,
	copiesMissing SMALLINT,
	distributionPrice smallMoney
);

CREATE TABLE Genre (
	genreID NUMERIC(10) PRIMARY KEY,
	genreString VARCHAR(25)
);

CREATE TABLE GenreMovie (
	movieID NUMERIC (10) NOT NULL,
	genreID NUMERIC (10) NOT NULL,

	CONSTRAINT PK_GenreMovie PRIMARY KEY (movieID, genreID)
);


-- Customer, Movie Dependency Tables\
CREATE TABLE MovieQueue (
	queueID TINYINT NOT NULL PRIMARY KEY,
	queuePosition TINYINT NOT NULL,
	movieID NUMERIC(10) NOT NULL,
	customerID CHAR(11) NOT NULL,
	
	FOREIGN KEY (movieID) REFERENCES Movie(movieID),
	FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE CustomerMovieQueue(
	customerID CHAR(11) NOT NULL,
	queueID TINYINT NOT NULL,

	FOREIGN KEY (customerID) REFERENCES Customer(customerID),
	FOREIGN KEY (queueID) REFERENCES MovieQueue(queueID)
);


CREATE TABLE Ratings (
	ratingID NUMERIC(10) NOT NULL PRIMARY KEY,
	customerID CHAR(11) NOT NULL,
	
	FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE MovieRating (
	ratingID NUMERIC(10) NOT NULL PRIMARY KEY,
	movieID NUMERIC(10) NOT NULL,
	score NUMERIC(2,1),
	movieReview VARCHAR(250),
	
	FOREIGN KEY (movieID) REFERENCES Movie(movieID),
	FOREIGN KEY (ratingID) REFERENCES Ratings(ratingID),

	CONSTRAINT chkMovScore
		CHECK (score BETWEEN 1 AND 5)
);

-- Actor, Movie Dependency Tables/




-- Actor + Ratings Dependency/
CREATE TABLE Actor (
	actorID CHAR(11) NOT NULL PRIMARY KEY,
	gender CHAR(1),
	DOB DATE,
	firstName NVARCHAR(25),
	lastName NVARCHAR(25)
);



CREATE TABLE ActorRating (
	ratingID NUMERIC(10) NOT NULL PRIMARY KEY,
	actorID CHAR(11) NOT NULL,
	score NUMERIC(2,1),
	
	FOREIGN KEY(actorID) REFERENCES Actor(actorID),
	FOREIGN KEY(ratingID) REFERENCES Ratings(ratingID),

	CONSTRAINT chkActScore 
		CHECK (score BETWEEN 1 AND 5)
);

-- Actor + Ratings Dependency/


-- Movie, Actor Dependencies
CREATE TABLE Features (
	movieID NUMERIC(10) NOT NULL,
	actorID CHAR(11) NOT NULL,

	FOREIGN KEY(movieID) REFERENCES Movie(movieID),
	FOREIGN KEY(actorID) REFERENCES Actor(actorID)
);


-- Order Context
CREATE TABLE OrderContext (
	contextID NUMERIC(1) NOT NULL PRIMARY KEY,
	orderStatus VARCHAR(15) NOT NULL,
);

CREATE TABLE Orders (
	orderID NUMERIC(1) NOT NULL PRIMARY KEY,
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
