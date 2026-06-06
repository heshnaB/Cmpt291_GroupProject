-- This is a simple Doc where we can combine all our insertion code



--                 Standardized Reference Tables

-- AcctStatus: 
INSERT INTO AcctStatus VALUES (0, 'Deactivated') --Allows for IF Acctstatus to yield F if deactivated, T if Non-deactivated
INSERT INTO AcctStatus VALUES (1, 'Active')
INSERT INTO AcctStatus VALUES (2, 'Inactive')
INSERT INTO AcctStatus VALUES (3, 'Suspended')

SELECT * FROM AcctStatus

-- Genre:

INSERT INTO Genre VALUES
    (1, 'Action')
    (2, 'Drama')
    (3, 'Historical')
    (4, 'Thriller')
    (5, 'Romance')
    (6, 'Comedy')
    (8,'Family')
    (9,'Horror')
    (10,'Hard Science Fiction')
);



INSERT INTO Permanency VALUES   
    (0, 'Full-Time')
    (1, 'Part-Time')
    (2, 'Seasonal/Temp')
);

-- EmployeeRole
INSERT INTO EmployeeRole VALUES
-- roleID, jobTitle, roledesc, permanencyID
    (0, 'Sales-Associate', 'Can: Checkout', 1)

    (1, 'Assistant Manager', 'Can: Checkout, Handles Overdue/Missing Cases, Deactivate Customer Accounts', 1)

    (2, 'IT Support & Operations', 'Can: Provide day-to-day troubleshooting for employees, Upgrades/Installs/Moniters the server and internal systems', 1)

    (3, 'Manager', 'Can: Waive Late Fees, Deactivate Accounts, Checkout', 1)
);
    


--                 = People Inserts = 

INSERT INTO People VALUES
    ('1', 'Oliver', 'Cromwell')
    ('2', 'Hari', 'Seldon')
    ('3', 'Mary', 'Beard')
    ('4', 'Jade', 'Bellevue', 1)
    ('14', 'Yasmin', 'Bellevue', 1)
    ('5', 'Richard', 'Feynman', 2)
    ('15', 'Albert', 'Einstein', 2)
    ('6', 'Genevieve', 'Randolph', 1)
    ('16', 'Sasha', 'Silvermist', 1)
    ('8', 'Patty', 'Anderson', 1)

--                 = Employee Inserts = 
/*              
Attributes:
    employeeID, peopleID
    SSN, roleID
*/
INSERT INTO Employee VALUES
    ('E-000000004', 'P-000000004', 100000000, 0)
    ('E-000000005', 'P-000000014', 100000001, 1)
    ('E-000000006', 'P-00000007', 100000007, 2);

--                 = Customer Inserts = 
/*
Attributes:
    customerID, city,
    province, email
    phoneNumber, peopleID
*/
INSERT INTO Customer VALUES
    ('4', 'Red Deer', 'AB', 'feynmanR@yahoo.ca', 7804564321, '5')
    ('5', 'Edmonton', 'AB', 'alberteinstein@gmail.com', 5879874321, '15')
    ('6', 'Calgary', 'AB', 'pgenevieve@gmail.ca', 7801231234, '6');

/*                = Ratings Inserts =
Attributes:
    ratingID, customerID
*/
INSERT INTO Ratings VALUES
    (4, '4')
    (5, '6')
    (6, '5');

/*                = ActorRating Inserts =
Attributes:
    ratingID, actorID,
    score
*/

INSERT INTO ActorRating VALUES
    (4, '4', 8.25)
    (5, '5', 9.50)
    (6, '6', 9.99);

/*                = MovieRating Inserts =
Attributes:
    ratingID, movieID,
    score, movieReview
*/

INSERT INTO MovieRating VALUES
    (4, '4', 7.35, 'Awesome Movie!')
    (5, '6', 9.00, 'Classic!')
    (6, '5', 10.00, 'Made me cry!');

/*                = Movie Inserts =
Attributes:
    id, name, releaseDate, copies avail, 
    copies total, copies rented, 
    copies missing, distribution price

CONSTRAINTS TO TEST: 
    Can we have more movies rented than we total?
*/


INSERT INTO Movie VALUES
    (4, 'Crazy Rich Asians', '2018-08-07', 10, 15, 5, 0, 5.75)

    (5, 'Ballerina', '2025', '2025-06-06', 2, 10, 7, 1, 6.66)

    (6, 'The Hangover', '2009-04-30', 0, 20, 18, 2, 4.50)

    (8, 'Ice Age', '2002-03-15', 4, 10, 1, 0, 5.55);

INSERT INTO Movie VALUES
    (9, 'Scary Movie', '2000-07-07', 2, 5, 2, 1, 1.25);

INSERT INTO Movie VALUES
    (9, 'Project Hail Mary', '2026-03-20', 2, 5, 2, 1, 1.25);


/*             = Actor Inserts =
Attributes:
    id, gender, DOB
    firstname, lastname
    actor rating
*/

INSERT INTO Actor VALUES
    ('4', 'F', '1988-04-30', 'Ana', 'de Armas', )
    ('5', 'F', '1982-03-22', 'Constance', 'Wu', )
    ('6', 'M', '1969-07-13', 'Ken', 'Jeong', )
    ('8','F', '1971-07-20', 'Sandra', 'Oh', );

INSERT INTO Actor VALUES
    ('8','F', '1954-03-04', 'Catherine', 'O''Hara', );

INSERT INTO Actor VALUES
    ('8','F', '1983-12-21', 'Steven', 'Yeun', );

/*             = Features Inserts =
Attributes:
    movieID, actorID
*/

INSERT INTO Features VALUES
(4, 5)
(4, 6)
(5, 4)
(6, 6);

/*          = Order & OrderContext Inserts =            */

/*
Orders Attributes:
    orderID, issueDate,
    dueDate, employeeID,
    customerID, contextID,
    movieID, returnDate
*/

INSERT INTO Orders VALUES
    (4, 2026-02-20, DATEADD(week, 2, issueDate), , , 0, 4,)
    (5, 2026-02-22, DATEADD(week, 2, issueDate), , , 3, 5,)
    (6, 2026-02-22, DATEADD(week, 2, issueDate), , , 2, 6,);

/*
OrderContext Attributes:
    contextID, orderStatus
*/

INSERT INTO OrderContext VALUES
    (0, 'Pending')
    (1, 'Completed')
    (2, 'Overdue')
    (3, 'Missing');

/*             = Joins Inserts =
Attributes:
    customerID, queueID
*/

INSERT INTO Joins VALUES
    ('4', 4)
    ('5', 5)
    ('6', 6);

/*             = MovieQueue Inserts =
Attributes:
    queueID, queuePostion,
    movieID, customerID
*/

INSERT INTO MovieQueue VALUES
    (4, 5, 5, '4')
    (5, 1, 4, '5')
    (6, 0, 6, '6');