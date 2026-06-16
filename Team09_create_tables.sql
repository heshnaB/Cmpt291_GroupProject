--	
--							                                       == Create Tables ==

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

--									= Customers Usernames For Login =
CREATE TABLE UserLogin (
	customerID CHAR(11) PRIMARY KEY,
	userAlias VARCHAR(50) NOT NULL UNIQUE,
	

	passwordHash VARCHAR(128), -- configured to be 
	salt VARCHAR(64), -- configured to be 

	CHECK (LEN (passwordHash) <=44),

	FOREIGN KEY (customerID) REFERENCES Customer (customerID)
);
GO


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
	FK_movieID NUMERIC(10) NOT NULL,
	
	FOREIGN KEY (FK_movieID) REFERENCES Movie(movieID)
);


-- Customer, Movie Dependency Tables\
CREATE TABLE JoinQueue(
	FK_customerID CHAR(11) NOT NULL,
	queueID TINYINT NOT NULL,
	queuePosition TINYINT NOT NULL
	
	PRIMARY KEY (FK_customerID, queueID),
	FOREIGN KEY (FK_customerID) REFERENCES Customer(customerID),
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


--                        = Creating All Views =
--					Creating Views for the Project:
DROP VIEW IF EXISTS UserLoginAliases;
GO
CREATE VIEW UserLoginAliases AS
	SELECT customerID, userAlias
	FROM UserLogin;
GO


DROP VIEW IF EXISTS CustHashSalt;
GO
CREATE VIEW CustHashSalt AS
	SELECT customerID, passwordHash, salt
	FROM UserLogin;
GO


/* Create a view AllAccountStats */
DROP VIEW IF EXISTS AllAccountStats;
GO

CREATE VIEW AllAccountStats AS
SELECT 
    peopleID,
    firstName+' '+lastName as Full_Name,
    accountState,
    P.accountStatusID as accountStatus
FROM People P, AcctStatus Ac
WHERE P.accountStatusID = Ac.accountStatusID
GO

SELECT * FROM AllAccountStats;
/* Create a view CustomerPersonalInfo */
DROP VIEW IF EXISTS CustomerPersonalInfo;
GO

CREATE VIEW CustomerPersonalInfo AS
SELECT
    C.customerID,
    P.firstname as First_Name,
    P.lastName as Last_Name,
    C.city as City,
    C.province as Province,
    C.phoneNumber as Phone_Number,
    C.email as Email
FROM People P
INNER JOIN Customer C ON P.peopleID = C.peopleID;
GO

/* Create a view CustomerList */
DROP VIEW IF EXISTS CustomerList;
GO

CREATE VIEW CustomerList AS
SELECT
    C.customerID as customerID,
    P.firstname+' '+P.lastName as CustomerName
FROM People P
INNER JOIN Customer C ON P.peopleID = C.peopleID;
GO

/* Create a view EmployeeInfo */
DROP VIEW IF EXISTS EmployeeInfo;
GO

CREATE VIEW EmployeeInfo AS
SELECT
    E.employeeID,
    P.firstname+' '+P.lastName as Full_Name,
    jobTitle as Title,
    permancyDesc as Permanency
FROM People P
INNER JOIN Employee E ON P.peopleID = E.peopleID
INNER JOIN EmployeeRole ER ON E.roleID = ER.roleID
INNER JOIN Permanency Pe ON ER.permanencyID = Pe.permanencyID
GO

/* Create a vew OrderInfo */
DROP VIEW IF EXISTS OrderInfo;
GO

CREATE VIEW OrderInfo AS
SELECT
    O.customerID,
    O.orderID,
    M.movieName,
    O.issueDate,
    O.returnDate,
    OC.orderStatus
FROM Orders O
INNER JOIN OrderContext OC ON O.contextID = OC.contextID
INNER JOIN Movie M ON O.movieID = M.movieID;
GO

/* Create a view MovieListing */
DROP VIEW IF EXISTS MovieListing;
GO

CREATE VIEW MovieListing AS
SELECT
    movieName as Title,
    GenreList as Genre,
    ActorList as Actors,
    copiesAvailable as Available
FROM Movie M
INNER JOIN (
    SELECT movieID, STRING_AGG(genreString, ', ') AS GenreList
    FROM Genre
    GROUP BY movieID
) G ON M.movieID = G.movieID
INNER JOIN (
    SELECT F.FK_movieID, STRING_AGG(CONCAT(A.firstName, ' ', A.lastName), ', ') AS ActorList
    FROM Features F
    INNER JOIN Actor A ON F.FK_actorID = A.actorID
    GROUP BY F.FK_movieID
) A ON M.movieID = A.FK_movieID;
GO

/* Create a view MovieReviewList */
DROP VIEW IF EXISTS MovieReviewList;
GO

CREATE VIEW MovieReviewList AS
SELECT
    FK_customerID,
    movieName as Movie_Name,
    movieID,
    score as Score,
    movieReview as Review
FROM Ratings R
INNER JOIN (
    SELECT ratingID, movieName, score, movieReview, movieID
    FROM MovieRating MR
    INNER JOIN Movie M ON MR.FK_movieID = M.movieID
) _MR ON R.ratingID = _MR.ratingID
GO

/* Create a view ActorReviewList */
DROP VIEW IF EXISTS ActorReviewList;
GO

CREATE VIEW ActorReviewList AS
SELECT
    FK_customerID,
    firstName+' '+lastName as Actor_Name,
    score as Score
FROM Ratings R
INNER JOIN (
    SELECT ratingID, firstName, lastName, score
    FROM ActorRating AR
    INNER JOIN Actor A ON AR.FK_actorID = A.actorID
) _AR ON R.ratingID = _AR.ratingID
GO

/* Create a view CustomerQueue */
DROP VIEW IF EXISTS CustomerQueue;
GO

CREATE VIEW CustomerQueue AS
SELECT
    JQ.queueID as Queue_ID,
    FK_customerID,
    movieName,
    queuePosition
FROM JoinQueue JQ
INNER JOIN MovieQueue MQ ON JQ.queueID = MQ.queueID
INNER JOIN Movie M ON Mq.FK_movieID = M. movieID
GO

/* Create AllOrders view */
DROP VIEW IF EXISTS AllOrders;
GO

CREATE VIEW AllOrders AS
SELECT 
    orderID,
    issueDate,
    dueDate,
    customerID,
    employeeID,
    movieID,
    returnDate,
    orderStatus
FROM Orders O
INNER JOIN OrderContext OC ON O.contextID = OC.contextID
GO
