-- --									                                         == Test Queries  ==

-- -- TEAM 09 ; Alex, Esperanza, Heshna, Ryan



-- /* Show all customers */
-- SELECT People.firstName||' '||People.lastName as Customer_Name, Customer.*
-- FROM People, Customer
-- WHERE (People.peopleID = Customer.peopleID)


-- /* Show all movies with type and copy/available data. */
-- SELECT M.movieName, STRING_AGG(G.genreString, ', ') as Genre, M.copiesAvailable
-- FROM Movie as M, Genre as G
-- WHERE M.movieID = G.MovieID
-- GROUP BY M.movieName, M.copiesAvailable


-- /* Show a selected customer's queue. */
-- SELECT movieName, queuePosition
-- FROM Movie, MovieQueue, JoinQueue
-- WHERE (JoinQueue.FK_customerID = 'C-000000001') and (JoinQueue.queueID = MovieQueue.queueID) and (MovieQueue.FK_movieID = Movie.movieID)


-- /* Show active rentals. */
-- SELECT movieName, issueDate, dueDate
-- FROM Orders, Movie
-- WHERE (Movie.movieID = Orders.movieID)


-- /* Show rental history for a selected customer. */
-- SELECT People.firstName||' '||People.lastName as Customer_Name, Movie.movieName, Orders.issueDate, Orders.dueDate, Orders.returnDate, OrderContext.orderStatus
-- FROM People, Customer, Orders, Movie, OrderContext
-- WHERE (Orders.customerID = Customer.customerID) and (Customer.peopleID = People.peopleID) and (Orders.movieID = Movie.movieID) and (Orders.contextID = OrderContext.contextID)
--     and (Orders.customerID = 'C-000000001')


/* Show movie availability. */
SELECT Movie.movieName, Movie.copiesAvailable
FROM Movie

/* Show at least one constraint test in comments */
-- SELECT movieName
-- 		FROM Movie
-- 		WHERE movieID IN (
-- 			SELECT movieID
-- 			FROM Genre
-- 			WHERE genreString = 1 /* The variable has to be a string*/
-- 		);