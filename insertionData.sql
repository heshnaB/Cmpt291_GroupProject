
--                     == Foundational Inserts ==



-- Dependencies for: Customer, Employee
INSERT INTO AcctStatus VALUES 
    (0, 'Deactivated'), --Allows for IF Acctstatus to yield F if deactivated, T if Non-deactivated
    (1, 'Active'),
    (2, 'Inactive'),
    (3, 'Suspended')
;
INSERT INTO Permanency VALUES   
    (0, 'Full-Time'),
    (1, 'Part-Time'),
    (2, 'Seasonal/Temp')
;

INSERT INTO EmployeeRole VALUES
-- roleID, jobTitle, roledesc, permanencyID
    (0, 'Sales-Associate', 'Checkout', 1),
    (1, 'Assistant Manager', 'Checkout, Handles Overdue/Missing Cases, Deactivate Customer Accounts', 1),
    (2, 'IT Support & Operations', 'Troubleshooting, Upgrades, Installs & Monitors server & other internal systems', 1),
    (3, 'Manager', 'Checkout, Waives Late Fees, Deactivates Accounts', 1)
;

-- Verifying Above Works
	SELECT * FROM AcctStatus
	SELECT * FROM EmployeeRole
	SELECT * FROM Permanency



INSERT INTO People VALUES
-- peopleID, Fname, Lname, AcctStatus

	--             = Active Accounts =
	
	-- Prospective Employees
    ('P-000000001', 'Yasmin', 'Bellevue', 1),
    ('P-000000002', 'Richard', 'Feynman', 1),
	('P-000000003', 'Billy', 'Bobby', 1),
    ('P-000000004', 'Micheal', 'Jackson', 1),

	-- Prospective Customers:
	('P-000000005', 'Oliver', 'Cromwell', 1),
	('P-000000006', 'Hari', 'Seldon',1),
    ('P-000000007', 'Mary', 'Beard',1),
    ('P-000000008', 'Jade', 'Bellevue', 1),


	--             = Inactive Accounts =
    ('P-000000009', 'Albert', 'Einstein', 2),
    ('P-000000010', 'Genevieve', 'Randolph', 2),

	--			  = Suspended Accounts
	('P-000000011', 'Albert', 'Einstein', 3),
    ('P-000000012', 'Genevieve', 'Randolph', 3),
    
	--             = Deactivated Accounts =
	('P-000000013', 'Sasha', 'Silvermist', 0),
    ('P-000000014', 'Patty', 'Anderson', 0)



INSERT INTO Employee VALUES
-- employeeID, peopleID, SSN, roleID
    ('E-000000001', 'P-000000001', 809248474, 0),
    ('E-000000002', 'P-000000002', 415701220, 1),
    ('E-000000003', 'P-000000003', 856186508, 2),
    ('E-000000004', 'P-00000004', 913018453, 2)

;
