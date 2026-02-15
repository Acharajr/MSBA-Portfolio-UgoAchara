--list all the data in product table
SELECT * 
FROM product

--list all the data in customer table
SELECT * FROM CUSTOMER

--list customer first name and last name in customer table
SELECT CUS_FNAME, CUS_LNAME   
FROM customer

--list product description, product in hand in product table
SELECT P_DESCRIPT, P_QOH
FROM product


--list all the date in product table
SELECT P_INDATE 
FROM product

--Computed Column

--list product description, quantity in hand, price and result of price and product in hand (multipication) in product table
SELECT P_DESCRIPT, P_QOH, P_PRICE, P_PRICE*P_QOH AS PriceXPIN
FROM PRODUCT

SELECT P_DESCRIPT, P_QOH, P_PRICE, P_PRICE*P_QOH 'PriceXPIN'
FROM PRODUCT


--List product descriptions, the date they were received , and the warranty expiration date (90 days from receiving the product)
SELECT  P_DESCRIPT, P_INDATE,  P_INDATE+90  'Warranty Expiration'
FROM PRODUCT


--list customer first name and last name in customer table, order by customer first name
SELECT CUS_FNAME, CUS_LNAME 
FROM CUSTOMER
ORDER BY CUS_FNAME 

-- DEFAULT settings is to run it in ascending order so if you want descending order then in DESC

SELECT CUS_FNAME, CUS_LNAME 
FROM CUSTOMER
ORDER BY CUS_FNAME DESC

--List product descriptions,product price greater than 10 from product table
SELECT P_DESCRIPT, P_PRICE 
FROM PRODUCT
WHERE  P_PRICE>10


--List product descriptions, product in hand greater than 16  from product table

SELECT P_DESCRIPT, P_QOH 
FROM PRODUCT
WHERE  P_QOH>16

--List product descriptions,product price greater than 10 and product in hand greater than 16  from product table
SELECT P_DESCRIPT, P_PRICE, P_QOH
FROM PRODUCT
WHERE  P_PRICE>10 AND P_QOH>16

--List product descriptions,product price greater than 10 OR  product in hand greater than 16  from product table
SELECT P_DESCRIPT, P_PRICE, P_QOH
FROM PRODUCT
WHERE  P_PRICE>10 OR P_QOH>16

--list the product whose description satrts with H
SELECT P_DESCRIPT
	FROM PRODUCT
	WHERE P_DESCRIPT LIKE 'H%'



--list the product whose description ends with H
SELECT P_DESCRIPT
	FROM PRODUCT
	WHERE P_DESCRIPT LIKE '%H'

--list the product whose description contain  H
SELECT P_DESCRIPT
	FROM PRODUCT
	WHERE P_DESCRIPT LIKE '%H%'

---------------------------------------------------------------------------------------------------
--list the product whose description contain  CHAIN
SELECT P_DESCRIPT
	FROM PRODUCT
	WHERE P_DESCRIPT LIKE '%CHAIN%'


--The LIKE Operator in SQL is used to extract records where a particular pattern is present. In a WHERE clause, the LIKE operator is used to look for a certain pattern in a column.


-------------------------------------------------
--1 Write the SQL code required to list the employee number, 
--last name, first name, and middle initial of all employees whose last names start with Smith.
SELECT EMP_NUM, EMP_LNAME, EMP_FNAME, EMP_INITIAL
	FROM EMPLOYEE
	WHERE EMP_LNAME LIKE 'SMITH%'


-- 4 Write the SQL code that will list only the distinct project numbers in the ASSIGNMENT table, sorted by project number.
-- dISTINCT IS A FUNCTION THAT RETURNS ONLY THE UNIQUE NUMBER OR VALUES 
	SELECT DISTINCT PROJ_NUM 
		FROM ASSIGNMENT
		ORDER BY PROJ_NUM


-- 5 --Write the SQL code to retrieve the assignment number, employee number, project number, the stored assignment charge (ASSIGN_CHARGE), 
--and the calculated assignment charge (calculated by multiplying ASSIGN_CHG_HR by ASSIGN_HOURS). Sort the results by the assignment number.
	SELECT ASSIGN_NUM, EMP_NUM, PROJ_NUM, ASSIGN_CHARGE, ASSIGN_CHG_HR*ASSIGN_HOURS 'CAL_ASSIGN_CHARGE'
		FROM ASSIGNMENT
		ORDER BY ASSIGN_NUM

--------------------
-- 7 Write a query to produce the total number of hours and charges for each of the projects represented in the ASSIGNMENT table,
--sorted by project number
SELECT PROJ_NUM, SUM (ASSIGN_HOURS) 'SUMOFASSIGNEDHRS', SUM (ASSIGN_CHARGE) 'SUMOFASSIGNCHARGE'
FROM ASSIGNMENT
	GROUP BY PROJ_NUM
	ORDER BY PROJ_NUM



-- 8 Write the SQL code to generate the total hours worked and the total charges made by each employees.
SELECT  EMP_NUM,Sum(ASSIGN_HOURS) 'SumAssignHours', sum(ASSIGN_CHARGE) 'SumAssignharge'
FROM ASSIGNMENT
Group by EMP_NUM
Order by EMP_NUM

-- 9 Write a query to count the number of invoices.

Select COUNT(INV_NUMBER) 'Number of Invoices'
FROM INVOICE

-----------------------------
--COUNT(*) returns the number of rows in the table. 
--COUNT(COLUMN) returns the number of non-NULL values in the column.
--COUNT (DISTINCT COLUMN) returns the number of distinct non-NULL values in the column


-- 10  Write a query to count the number of customers with a balance of more than $500.
SELECT COUNT(CUS_BALANCE) 'CUSBAL GREATER THAN 500)'
FROM CUSTOMER
WHERE CUS_BALANCE > 500

