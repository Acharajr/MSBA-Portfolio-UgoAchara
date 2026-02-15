---WEEK#3- Day 1
--JOIN

--1- List product code, product description, along with vendor code and vendor name
	SELECT P_CODE, P_DESCRIPT, V.V_CODE, V_NAME
	FROM PRODUCT P JOIN VENDOR V
	ON P.V_CODE = V.V_CODE



--2- List product code, product description, along with vendor code and vendor name. Order by vendor name and product 
--description (decending)
SELECT P_CODE, P_DESCRIPT, V.V_CODE, V_NAME
	FROM PRODUCT P 
	JOIN VENDOR V ON P.V_CODE = V.V_CODE
	ORDER BY V.V_NAME, P.P_DESCRIPT

--3- LIST ALL VENDOR NAMES, VENDOR CODE ALONG WITH THE MAX PRICE OF THE PRODUCTS BY EACH VENDOR

--SELECT * FROM PRODUCT
--ORDER BY V_CODE

SELECT V_NAME, V.V_CODE, MAX(P_PRICE) 'Max price'
	FROM PRODUCT P 
	JOIN VENDOR V ON P.V_CODE = V.V_CODE
	GROUP BY V_NAME, V.V_CODE
	ORDER BY V.V_CODE


--use of logical operators
--4- List vendor name and all products whose description contains 'painter' and are from the vendor Rubicon Systems.
SELECT V.V_NAME, P.P_DESCRIPT
	FROM PRODUCT P 
	JOIN VENDOR V ON P.V_CODE = V.V_CODE
	WHERE P.P_DESCRIPT LIKE '%PAINTER%' AND V.V_NAME LIKE '%RUBICON%'
	



--Joining more than two tables

--5 List customer Last name, invoice number, and product codes in each invoice

SELECT CUS_LNAME, I.INV_NUMBER, P_CODE
	FROM CUSTOMER C JOIN INVOICE I 
	ON C.CUS_CODE = I.CUS_CODE JOIN LINE L
	ON I.INV_NUMBER = L.INV_NUMBER

--6 List customer Last name, invoice number, Product description and product codes in each invoice

SELECT CUS_LNAME, I.INV_NUMBER, P.P_CODE, P_DESCRIPT
	FROM CUSTOMER C 
	JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE 
	JOIN LINE L ON L.INV_NUMBER = I.INV_NUMBER
	JOIN PRODUCT P ON P.P_CODE = L.P_CODE

--Different Joins

--INNER JOIN
-- refers to common things between the two specified table
-- List customers that have invoice

SELECT CUS_LNAME, I.INV_NUMBER
FROM CUSTOMER C 
JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE

--RIGHT JOIN
-- everything from right table and right table only regardless if it's common 

SELECT CUS_LNAME, I.INV_NUMBER
FROM INVOICE I 
RIGHT JOIN CUSTOMER C ON C.CUS_CODE = I.CUS_CODE


SELECT CUS_LNAME, I.INV_NUMBER
FROM CUSTOMER C
RIGHT JOIN INVOICE I  ON C.CUS_CODE = I.CUS_CODE

----------------SAME RESULT WITH LEFT & RIGHT JOIN

----------------SAME RESULT WITH LEFT & RIGHT JOIN

--Left outer join: yields all of the rows in the first table, including those that do not have a matching value in the second table 
--Right outer join: yields all of the rows in the second table, including those that do not have matching values in the first table 

----------------------------------------------------

-----------------------------------------------FULL JOIN


------------------------------------------------------ CROSS JOIN


-----------------------------------------------------------------------------------------------------------------------
--PRACTICE
-------------------------------------------------------------------------------------------------------------------------
-- 1 Write the SQL code to display project number,value, balance, employee fist name, last name,
--initial, job code, job description and job charge per hour.(Construction Company) 

SELECT PROJ_NUM, PROJ_VALUE, PROJ_BALANCE, EMP_FNAME, EMP_LNAME, EMP_INITIAL, J.JOB_CODE, JOB_DESCRIPTION, JOB_CHG_HOUR
FROM PROJECT P
JOIN EMPLOYEE E ON P.EMP_NUM = E.EMP_NUM
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE




-- 2 Write the SQL code that will yield the total number of hours worked for each employee,the total charges stemming from 
--those hours worked, and employee last name. sorted by employee number. (Construction Company) 

SELECT E.EMP_LNAME, SUM(ASSIGN_HOURS) 'TOTAL HOURS WORKED', SUM(ASSIGN_CHARGE) 'TOTAL CHARGES'
FROM ASSIGNMENT A
JOIN EMPLOYEE E ON A.EMP_NUM = E.EMP_NUM
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
GROUP BY E.EMP_NUM, E.EMP_LNAME
ORDER BY E.EMP_NUM




--3- Find the average price for each vendor

--SELECT * FROM PRODUCT
SELECT V.V_CODE, V.V_NAME, AVG(P_PRICE) 'AVG PRICE'
FROM VENDOR V
JOIN PRODUCT P ON V.V_CODE = P.V_CODE
GROUP BY V.V_CODE, V.V_NAME



--4 List each product code and price along with the difference between price and average price
SELECT P_CODE, P_PRICE, P_PRICE -(SELECT AVG(P_PRICE) FROM PRODUCT) 'DIFFERENCE'
FROM PRODUCT


   

--5 List all product codes, invoice number and line unites  where the units sold is greater than the average units for that product
SELECT P_CODE, INV_NUMBER, LINE_UNITS
FROM  LINE  
WHERE LINE_UNITS > (SELECT AVG(LINE_UNITS) 'AVG UNITS' FROM LINE) 


--------------------------------------------Case-----------------------------------------------------
--Find different category for product prices



--Use a CASE statement to list the site name, site depth, and a description of the depth.  If the depth is 0-50 feet, the depth is 'shallow'. 
--If the depth is >50 - 100, the depth is 'deep'.  If the depth is > 100 the depth is 'very deep'.

SELECT site_Name, Site_depth, 
CASE
	WHEN site_depth >=0
		AND 
		Site_Depth <= 50 
		THEN 'Shallow'
	WHEN site_depth 
		BETWEEN 50 AND 100 
		THEN 'Deep'
	WHEN site_depth > 100 
		THEN 'Very Deep'

	END Depth_descript
	FROM site

	

------------------------------------------------MORE PRACTICE



--1 List all vendors who DON'T  have products whose products' quantity on hand has above 8


--2 find product for ones that has price between 10 and 86
--Use BETWEEN


--3 list  vendor states that has more than two vendors from vendor table


--4 Find the min price for each vendor in product table


--5- lIST THE LAST NAME OF CUSTOMERS WHO HAS INVOICE

-- UNCORRELATED QUERY

-- Exists- Correlated subquery



--use join

