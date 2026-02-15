---WEEK#3- Day 1
--JOIN

--1- List product code, product description, along with vendor code and vendor name

SELECT P_CODE, P_DESCRIPT, PRODUCT.V_CODE, V_NAME
FROM PRODUCT INNER JOIN VENDOR ON PRODUCT.V_CODE=VENDOR.V_CODE


SELECT P_CODE, P_DESCRIPT, P.V_CODE, V_NAME
FROM PRODUCT P INNER JOIN VENDOR V ON P.V_CODE=V.V_CODE


--2- List product code, product description, along with vendor code and vendor name. Order by vendor name and product 
--description (decending)
SELECT P_CODE, P_DESCRIPT, P.V_CODE, V_NAME
FROM PRODUCT P INNER JOIN VENDOR V
ON P.V_CODE=V.V_CODE
ORDER BY V.V_NAME ,P.P_DESCRIPT DESC

--3- LIST ALL VENDOR NAMES, VENDOR CODE ALONG WITH THE MAX PRICE OF THE PRODUCTS BY EACH VENDOR

--SELECT * FROM PRODUCT
--ORDER BY V_CODE

	SELECT V.V_NAME,V.V_CODE, MAX(P.P_PRICE) AS [MAXPRICE FOR VENDOR]
	FROM PRODUCT P INNER JOIN VENDOR V 
	ON P.V_CODE=V.V_CODE
	GROUP BY V.V_NAME,V.V_CODE



--use of logical operators
--4- List vendor name and all products whose description contains 'painter' and are from the vendor Rubicon Systems.

SELECT P.P_DESCRIPT, V.V_NAME
FROM PRODUCT P INNER JOIN VENDOR V
ON P.V_CODE=V.V_CODE
WHERE P.P_DESCRIPT LIKE '%painter%'  AND V.V_NAME= 'Rubicon Systems'


--Joining more than two tables

--5 List customer Last name, invoice number, and product codes in each invoice

SELECT C.CUS_LNAME,I.INV_NUMBER,L.P_CODE
FROM CUSTOMER C INNER JOIN INVOICE I ON C.CUS_CODE=I.CUS_CODE
INNER JOIN LINE L ON I.INV_NUMBER=L.INV_NUMBER

--6 List customer Last name, invoice number, Product description and product codes in each invoice

SELECT C.CUS_LNAME,I.INV_NUMBER,L.P_CODE, P.P_DESCRIPT
FROM CUSTOMER C INNER JOIN INVOICE I ON C.CUS_CODE=I.CUS_CODE
INNER JOIN LINE L ON I.INV_NUMBER=L.INV_NUMBER 
INNER JOIN PRODUCT P ON L.P_CODE=P.P_CODE

--Different Joins

SELECT *FROM CUSTOMER
ORDER BY CUS_CODE

SELECT * FROM INVOICE
ORDER BY CUS_CODE
--INNER JOIN
SELECT C.CUS_CODE,I.INV_NUMBER
FROM CUSTOMER C INNER JOIN INVOICE I ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE
--RIGHT JOIN
SELECT C.CUS_CODE,I.INV_NUMBER
FROM  INVOICE I RIGHT JOIN CUSTOMER C  ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE
--LEFT JOIN
SELECT C.CUS_CODE,I.INV_NUMBER
FROM  INVOICE I LEFT JOIN CUSTOMER C  ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE
----------------SAME RESULT WITH LEFT & RIGHT JOIN
SELECT C.CUS_CODE,I.INV_NUMBER
FROM  INVOICE I RIGHT JOIN CUSTOMER C  ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE

SELECT C.CUS_CODE,I.INV_NUMBER
FROM CUSTOMER C LEFT JOIN INVOICE I ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE
----------------SAME RESULT WITH LEFT & RIGHT JOIN
SELECT C.CUS_CODE,I.INV_NUMBER
	FROM INVOICE I LEFT JOIN CUSTOMER C  ON C.CUS_CODE=I.CUS_CODE
		ORDER BY I.CUS_CODE

SELECT C.CUS_CODE,I.INV_NUMBER
	FROM CUSTOMER C RIGHT JOIN INVOICE I ON C.CUS_CODE=I.CUS_CODE
		ORDER BY I.CUS_CODE
--Left outer join: yields all of the rows in the first table, including those that do not have a matching value in the second table 
--Right outer join: yields all of the rows in the second table, including those that do not have matching values in the first table 

----------------------------------------------------

-----------------------------------------------FULL JOIN
SELECT C.CUS_CODE,I.INV_NUMBER
FROM CUSTOMER C FULL outer JOIN INVOICE I ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE


SELECT C.CUS_CODE,I.INV_NUMBER
FROM   INVOICE I FULL JOIN CUSTOMER C ON C.CUS_CODE=I.CUS_CODE
ORDER BY I.CUS_CODE

------------------------------------------------------ CROSS JOIN


SELECT *FROM CUSTOMER
ORDER BY CUS_CODE

SELECT * FROM INVOICE
ORDER BY CUS_CODE


SELECT C.CUS_LNAME,I.INV_NUMBER
FROM CUSTOMER C cross JOIN INVOICE I 

-----------------------------------------------------------------------------------------------------------------------
--PRACTICE
-------------------------------------------------------------------------------------------------------------------------
-- 1 Write the SQL code to display project number,value, balance, employee fist name, last name,
--initial, job code, job description and job charge per hour.(Construction Company) 

SELECT PROJ_NAME, PROJ_VALUE, PROJ_BALANCE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, JOB.JOB_CODE, JOB_DESCRIPTION, JOB_CHG_HOUR
FROM PROJECT JOIN EMPLOYEE ON PROJECT.EMP_NUM = EMPLOYEE.EMP_NUM JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
ORDER BY PROJ_VALUE;


-- 2 Write the SQL code that will yield the total number of hours worked for each employee,the total charges stemming from 
--those hours worked, and employee last name. sorted by employee number. (Construction Company) 

SELECT ASSIGNMENT.EMP_NUM, EMP_LNAME, Sum(ASSIGN_HOURS) AS SumOfASSIGN_HOURS, Sum(ASSIGN_CHARGE) AS SumOfASSIGN_CHARGE
FROM EMPLOYEE JOIN ASSIGNMENT ON EMPLOYEE.EMP_NUM = ASSIGNMENT.EMP_NUM
GROUP BY ASSIGNMENT.EMP_NUM, EMPLOYEE.EMP_LNAME
ORDER BY ASSIGNMENT.EMP_NUM;





--3- Find the average price for each vendor

--SELECT * FROM PRODUCT

SELECT V.V_CODE,V_NAME, AVG (P.P_PRICE) AVERAGE
FROM PRODUCT P JOIN VENDOR V
ON P.V_CODE=V.V_CODE

GROUP BY V.V_CODE,V_NAME

--4 List each product code and price along with the difference between price and average price

SELECT P_CODE, P_PRICE,(P_PRICE- (SELECT AVG(P_PRICE) FROM PRODUCT)) AS [DIFFERENCES FROM PRICE AND AVERAGE]
FROM PRODUCT



  --   select avg(p_price)  
	 --from product
   

--5 List all product codes, invoice number and line unites  where the units sold is greater than the average units for that product

SELECT L.INV_NUMBER, L.P_CODE, L.LINE_UNITS FROM 
LINE L WHERE L.LINE_UNITS > (SELECT AVG(L.LINE_UNITS) FROM LINE L)


--------------------------------------------Case-----------------------------------------------------
--Find different category for product prices
SELECT P_PRICE ,
CASE
    WHEN P_PRICE >90 THEN 'High Price'
    WHEN P_PRICE =50 THEN 'Med Price'
    WHEN P_PRICE <50 THEN 'Low Price'

   --ELSE 'No Category'
	
	END PriceCategory
	FROM PRODUCT

	
SELECT P_PRICE ,
CASE
    WHEN P_PRICE >90 THEN 'High Price'
    WHEN P_PRICE BETWEEN 40 AND 50 THEN 'Med Price'
    WHEN P_PRICE <50 THEN 'Low Price'

   --ELSE 'No Category'
	
	END
	FROM PRODUCT

--Use a CASE statement to list the site name, site depth, and a description of the depth.  If the depth is 0-50 feet, the depth is 'shallow'. 
--If the depth is >50 - 100, the depth is 'deep'.  If the depth is > 100 the depth is 'very deep'.
	
	SELECT  site_name, 
        site_depth, 
        CASE 
                WHEN    site_depth >= 0 
                    AND site_depth <= 50 
                THEN 'shallow' 
                WHEN    site_depth  >50 
                    AND site_depth <= 100 
                THEN 'deep' 
                WHEN    site_depth >100 
                THEN 'very deep' 
        END DeepCategory
FROM    site;

------------------------------------------------MORE PRACTICE



--1 List all vendors who DON'T  have products whose products' quantity on hand has above 8

SELECT *FROM VENDOR V
WHERE NOT EXISTS ( SELECT * FROM PRODUCT P 
               WHERE P.V_CODE=V.V_CODE AND P.P_QOH>8)    




SELECT * from VENDOR V
WHERE v.V_CODE NOT in ( SELECT V_CODE FROM PRODUCT P 
               WHERE P.V_CODE=V.V_CODE AND P.P_QOH>8)   

SELECT * from VENDOR V
WHERE v.V_CODE =ANY ( SELECT V.V_CODE FROM VENDOR V EXCEPT
SELECT P.V_CODE  FROM PRODUCT P 
               WHERE  P.P_QOH>8)  

SELECT V.*
FROM VENDOR V
LEFT JOIN PRODUCT P
    ON V.V_CODE = P.V_CODE AND P.P_QOH > 8
WHERE P.V_CODE IS NULL;
			   

--2 find product for ones that has price between 10 and 86
--Use BETWEEN
SELECT * FROM PRODUCT

SELECT P_CODE FROM PRODUCT
WHERE P_PRICE BETWEEN 10 AND 86

--3 list  vendor states that has more than two vendors from vendor table

SELECT V_STATE , count(*) AS COUNT_Vendor
FROM VENDOR
GROUP BY V_STATE
HAVING COUNT(*)>2
ORDER BY V_STATE DESC

--4 Find the min price for each vendor in product table

SELECT V_CODE, MIN(P_PRICE)
FROM PRODUCT
GROUP BY V_CODE


--5- lIST THE LAST NAME OF CUSTOMERS WHO HAS INVOICE

-- UNCORRELATED QUERY

SELECT CUS_LNAME FROM CUSTOMER C WHERE CUS_CODE IN
(SELECT CUS_CODE FROM INVOICE)

-- Exists- Correlated subquery

SELECT C.CUS_LNAME FROM CUSTOMER C WHERE EXISTS (SELECT * FROM INVOICE I WHERE C.CUS_CODE=I.CUS_CODE)

--use join


SELECT DISTINCT C.CUS_LNAME FROM CUSTOMER C INNER JOIN INVOICE I
ON C.CUS_CODE=I.CUS_CODE
