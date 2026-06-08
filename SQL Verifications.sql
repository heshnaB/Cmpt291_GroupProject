-- SQL Verifications

-- Show all customers
SELECT * FROM Customer;

-- Show all movies with type and copy/availability data
-- SELECT movieName, genreString, copiesAvailable
-- FROM Movie
-- INNER JOIN Genre ON Movie.movieID = Genre.movieID;

-- Show a selected customer's queue 
SELECT firstName+' '+lastName AS Full_Name, queuePosition
FROM People
INNER JOIN Customer ON People.peopleID = Customer.peopleID
INNER JOIN MovieQueue ON MovieQueue.customerID = Customer.customerID
WHERE firstName = 'Genevieve' AND lastName = 'Randolph';

-- Show active rentals 
SELECT *
FROM Orders
WHERE contextID = 0;

-- Find all customer who has movie(s) in their queues.
SELECT firstName+' '+lastName AS Full_Name
FROM People
WHERE peopleID IN (SELECT peopleID
                    FROM Customer
                    WHERE  customerID IN ( 
                        SELECT customerID
                        FROM MovieQueue)
                    );

-- Find all the customers with overdue rental(s).
SELECT firstName+' '+lastName AS Full_Name
FROM People
INNER JOIN Customer ON People.peopleID = Customer.peopleID
INNER JOIN Orders ON Orders.customerID = Customer.customerID
INNER JOIN OrderContext ON Orders.contextID = OrderContext.contextID
WHERE OrderContext.orderStatus = 'Overdue';

