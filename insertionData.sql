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
    (8,'Family')
    (9,'Horror')
    (10,'Hard Science Fiction')
);


--                 = People Inserts = 





/*                = Movie Inserts =
Attributes:
    id, name, releaseDate, copies avail, 
    copies total, copies rented, 
    copies missing, distribution price

CONSTRAINTS TO TEST: 
    Can we have more movies rented than we total?
*/


INSERT INTO Movie VALUES
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
    ('8','F', '1971-07-20', 'Sandra', 'Oh', );

INSERT INTO Actor VALUES
    ('8','F', '1954-03-04', 'Catherine', 'O''Hara', );

INSERT INTO Actor VALUES
    ('8','F', '1983-12-21', 'Steven', 'Yeun', );