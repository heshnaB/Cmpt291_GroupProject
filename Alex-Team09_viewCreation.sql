
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
    SELECT F.FK_movieID, STRING_AGG((A.firstName+' '+A.lastName), ', ') AS ActorList
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