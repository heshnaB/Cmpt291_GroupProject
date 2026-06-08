-- This is a simple Doc where we can combine all our insertion code
USE Movie_Rental_DB;
GO

--                 Standardized Reference Tables

-- AcctStatus: 
INSERT INTO AcctStatus VALUES (0, 'Deactivated'); --Allows for IF Acctstatus to yield F if deactivated, T if Non-deactivated
INSERT INTO AcctStatus VALUES (1, 'Active');
INSERT INTO AcctStatus VALUES (2, 'Inactive');
INSERT INTO AcctStatus VALUES (3, 'Suspended');

--                 = People Inserts = 
INSERT INTO People VALUES
    ('P-000000001', 'Oliver', 'Cromwell', 1),
    ('P-000000002', 'Hari', 'Seldon', 1),
    ('P-000000003', 'Mary', 'Beard', 1),
    ('P-000000004', 'Jade', 'Bellevue', 1),
    ('P-000000014', 'Yasmin', 'Bellevue', 1),
    ('P-000000005', 'Richard', 'Feynman', 2),
    ('P-000000015', 'Albert', 'Einstein', 2),
    ('P-000000006', 'Genevieve', 'Randolph', 1),
    ('P-000000016', 'Sasha', 'Silvermist', 1),
    ('P-000000008', 'Patty', 'Anderson', 1);

INSERT INTO Permanency VALUES   
    (0, 'Full-Time'),
    (1, 'Part-Time'),
    (2, 'Seasonal/Temp');


-- EmployeeRole
INSERT INTO EmployeeRole VALUES
-- roleID, jobTitle, roledesc, permanencyID
    (0, 'Sales-Associate', 'Can: Checkout', 1),
    (1, 'Assistant Manager', 'Can: Checkout, Handles Overdue or Missing Cases, Deactivate Customer Accounts', 1),
    (2, 'IT Support & Operations', 'Can: Provide day-to-day troubleshooting for employees, Upgrades,Installs, and Moniters the server and internal systems', 1),
    (3, 'Manager', 'Can: Waive Late Fees, Deactivate Accounts, Checkout', 1);
    

--                 = Employee Inserts = 
INSERT INTO Employee VALUES
    ('E-000000004', 'P-000000004', 100000000, 0),
    ('E-000000005', 'P-000000014', 100000001, 1),
    ('E-000000006', 'P-00000007', 100000007, 2);


--                 = Customer Inserts = 

INSERT INTO Customer VALUES
    ('C-000000004', 'Red Deer', 'C-AB', 'feynmanR@yahoo.ca', 7804564321, 'P-000000005'),
    ('C-000000005', 'Edmonton', 'C-AB', 'alberteinstein@gmail.com', 5879874321, 'P-000000015'),
    ('C-000000006', 'Calgary', 'C-AB', 'pgenevieve@gmail.ca', 7801231234, 'P-000000006')

;


/*                = Movie Inserts =
Attributes:
    id, name, releaseDate, copies avail, 
    copies total, copies rented, 
    copies missing, distribution price

CONSTRAINTS TO TEST: 
    Can we have more movies rented than we total?
*/

INSERT INTO Movie VALUES -- tested and working
    (4, 'Crazy Rich Asians', '2018-08-07', 10, 15, 5, 0, 5.75),
    (5, 'Ballerina', '2025-06-06', 2, 10, 7, 1, 6.66),
	(6, 'The Hangover', '2009-04-30', 0, 20, 18, 2, 4.50),
	(7, 'Scary Movie', '2000-07-07', 2, 5, 2, 1, 1.25),
	(8, 'Ice Age', '2002-03-15', 4, 10, 1, 0, 5.55),
	(9, 'Project Hail Mary', '2026-03-20', 2, 5, 2, 1, 1.25)
	;

-- Genre:

INSERT INTO Genre VALUES
    (4, 'Comedy'),
    (4, 'Drama'),
    (4, 'Romance'),
    (5, 'Action'),
    (5, 'Thriller'),
    (5, 'Crime'),
    (5, 'Adventure'),
    (5, 'Drama'),
    (6, 'Comedy'),
    (7, 'Comedy'),
    (8, 'Comedy'),
    (8, 'Adventure'),
    (8, 'Animation'),
    (8, 'Survival'),
    (9, 'Sci-Fi'),
    (9, 'Comedy'),
    (9, 'Adventure'),
    (9, 'Drama')
;
/*             = Actor Inserts =
Attributes:
    id, gender, DOB
    firstname, lastname
*/

INSERT INTO Actor VALUES
    ('A-000000001', 'F', '1988-04-30', 'Ana', 'de Armas'),
    ('A-000000002', 'F', '1982-03-22', 'Constance', 'Wu'),
    ('A-000000003', 'M', '1969-07-13', 'Ken', 'Jeong'),
    ('A-000000004','F', '1971-07-20', 'Sandra', 'Oh'),
    ('A-000000005','F', '1954-03-04', 'Catherine', 'O''Hara'),
    ('A-000000006','F', '1983-12-21', 'Steven', 'Yeun')
    ;



/*             = Features Inserts =
Attributes:
    movieID, actorID
*/

INSERT INTO Features VALUES
(4, 'A-000000002'),
(4, 'A-000000003'),
(5, 'A-000000001'),
(6, 'A-000000003');

/*          = Order & OrderContext Inserts =            */
/*
OrderContext Attributes:
    contextID, orderStatus
*/

INSERT INTO OrderContext VALUES
    (0, 'Active'),
    (1, 'Completed'),
    (2, 'Overdue'),
    (3, 'Missing');

/*
Orders Attributes:
    orderID, issueDate,
    dueDate, employeeID,
    customerID, contextID,
    movieID, returnDate
*/

INSERT INTO Orders VALUES
    (4, '2026-02-20', DATEADD(week, 2, '2026-02-20'), 'E-000000004', 'C-000000004', 0, 4,NULL),
    (5, '2026-02-22', DATEADD(week, 2, '2026-02-22'), 'E-000000005', 'C-000000005', 3, 5,NULL),
    (6, '2026-02-22', DATEADD(week, 2, '2026-02-22'), 'E-000000005', 'C-000000006', 2, 6,NULL);

/*             = MovieQueue Inserts =
Attributes:
    queueID, queuePostion,
    movieID, customerID
*/

INSERT INTO MovieQueue VALUES
    (4, 5, 5, 'C-000000004'),
    (5, 1, 4, 'C-000000004'),
    (6, 0, 6, 'C-000000006');

/*             = Joins Inserts =
Attributes:
    customerID, queueID
*/

INSERT INTO Joins VALUES
    ('C-000000004', 4),
    ('C-000000005', 5),
    ('C-000000006', 6);



/*                = Ratings Inserts =                  */
INSERT INTO Ratings VALUES
    (4, 'C-000000004'),
    (5, 'C-000000006'),
    (6, 'C-000000005');

/*                = ActorRating Inserts =                  */
INSERT INTO ActorRating VALUES
    (4, 'A-000000004', 4.0),
    (5, 'A-000000005', 5.0),
    (6, 'A-000000006', 4.5);

/*                = MovieRating Inserts =              */
INSERT INTO MovieRating VALUES
    (4, 4, 5, 'Awesome Movie!'),
    (5, 6, 4.5, 'Classic!'),
    (6, 5, 5.0, 'Made me cry!');
