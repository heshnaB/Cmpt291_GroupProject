--									                                      == Report Queries  ==

-- TEAM 09 ; Alex, Esperanza, Heshna, Ryan



-- 1: Community Engagement Analysis

	-- A. Find All Customers who wrote a review, and list the movie they rated
	SELECT customerID, Movie.movieName, movie.movieID FROM Customer
	JOIN Ratings ON Ratings.FK_customerID = Customer.customerID
	JOIN MovieRating ON MovieRating.ratingID = Ratings.ratingID
	JOIN Movie ON Movie.movieID = MovieRating.FK_movieID

	-- B. Count the orders returned on Time from customers
	SELECT C0.customerID, CONCAT(P.firstName,P.lastName) as fullName, COUNT(*) as OrdersReturnedTimely
	FROM Customer as C0
	JOIN People as P ON P.peopleID = C0.peopleID
	JOIN Orders as O0 ON O0.customerID = C0.customerID
	WHERE NOT EXISTS ( -- Select Orders that are NOT overdue via not exists
		SELECT O1.orderID
		FROM Orders as O1
		WHERE contextID = 2 -- 2 is the code for overdue
			AND O1.orderID = O0.orderID
		)
	GROUP BY C0.customerID, CONCAT(P.firstName,P.lastName)
	ORDER BY customerID

	-- C. Find Employees who are also customers
	SELECT DISTINCT firstName+' '+lastName as EmployeesWhoPlacedOrders
	FROM People
	JOIN Employee E ON People.peopleID = E.peopleID
	JOIN Orders O ON E.employeeID = O.employeeID
	JOIN Customer C ON O.customerID = C.customerID



-- 2: Employee Productivity Analysis

	-- A. Count the Number of Orders an Employee Completed
	SELECT DISTINCT Employee.employeeID, COUNT(*) as OrdersHandled
	FROM Employee
	JOIN Orders O ON O.employeeID = Employee.employeeID
	GROUP BY Employee.employeeID

	-- B. Find the employee(s) with the highest orders handled
	SELECT E.employeeID, firstName+' '+lastName as FullName, count(*) as num_Orders
	FROM People
	JOIN Employee E ON People.peopleID = E.peopleID
	JOIN Orders O ON E.employeeID = O.employeeID
	GROUP BY E.employeeID, firstName, lastName
	HAVING count(*) = (
		SELECT max(order_count)
		FROM (
			SELECT count(*) as order_count
			FROM Orders
			GROUP BY Orders.employeeID
		) as subq
);



-- 3: Internal Systems Overview

	-- A. Count All Deactivated Accounts
	SELECT COUNT(*) as DeactivatedAccounts
	FROM People
	WHERE accountStatusID = 0


	-- B. Find all customer(s) who are in a queue for movie(s), How long are queues in general?
	SELECT firstName+' '+lastName AS Full_Name
	FROM People
	WHERE People.peopleID IN (SELECT peopleID
							FROM Customer
							WHERE  Customer.customerID IN ( 
									SELECT customerID
									FROM MovieQueue
									WHERE CustomerID IN (
										SELECT CustomerID
										FROM JoinQUeue
									)
							)
						);



-- 4: Information For Decision-Making

	-- A. Most popular movie rented
		SELECT movieName, COUNT(*) as TimesRented
		FROM Movie, Orders
		WHERE Movie.movieID = Orders.movieID
		GROUP BY movieName
		ORDER BY TimesRented DESC


-- 5: Filtering Query
	-- Find all the movies with the Epic Fantasy Genre
		SELECT movieName
		FROM Movie
		WHERE movieID IN (
			SELECT movieID
			FROM Genre
			WHERE genreString = 'Epic Fantasy'
		);