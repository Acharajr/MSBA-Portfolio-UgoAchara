------------------REQUIRED CLAUSES----------------
/*
SELECT		COLUMNS, EXPRESSIONS
FROM		TABLENAME
*/


--list all the data in product table
SELECT * FROM PRODUCT
SELECT  TOP 5* FROM PRODUCT

------------------OPTIONAL CLAUSES----------------
/*WHERE		CONDITIONS
GROUP BY	COLUMNS
HAVING		CONDITIONS FOR GROUPS
ORDER BY	SORT KEY COLUMNS
*/



-- 27 Write a query to display the departments informations in the LGDEPARTMENT table sorted by department name.


SELECT *
FROM LGDEPARTMENT
ORDER BY DEPT_NAME;

-----For CHAR data type, use single quotation mark around 'value'

-- Write a query to display the department with department number 600 in the LGDEPARTMENT table.


SELECT *
	FROM LGDEPARTMENT
		WHERE dept_num = 600;


SELECT *
	FROM LGDEPARTMENT
		WHERE dept_num = '600';
-- Write a query to display the accounting department in the LGDEPARTMENT table.

SELECT *
	FROM LGDEPARTMENT
		WHERE dept_name = 'ACCOUNTING';

-- 28  Write a query to display the SKU (stock keeping unit), description, type, base, category, 
--and price for all products that have a PROD_BASE of Water and a PROD_CATEGORY of Sealer 

SELECT * FROM lgproduct

SELECT PROD_SKU, PROD_DESCRIPT,PROD_TYPE, PROD_BASE, PROD_CATEGORY, PROD_PRICE
FROM LGPRODUCT
WHERE PROD_BASE = 'Water' AND PROD_CATEGORY = 'Sealer'
------------------------

-- 29 Write a query to display the first name, last name,hiredate and email of employees hired 
--from January 1, 2005, to December 31, 2014. Sort the output by last name and then by first name 


SELECT * FROM lgemployee

SELECT EMP_FNAME, EMP_LNAME, EMP_EMAIL,EMP_HIREDATE
FROM LGEMPLOYEE
WHERE EMP_HIREDATE Between '2005-01-01' And '2014-12-31'
ORDER BY EMP_LNAME, EMP_FNAME;

SELECT EMP_FNAME, EMP_LNAME, EMP_EMAIL,EMP_HIREDATE
FROM LGEMPLOYEE
WHERE EMP_HIREDATE Between '01-01-2005' And '12-31-2014'
ORDER BY EMP_LNAME, EMP_FNAME;




SELECT EMP_LNAME,EMP_FNAME, EMP_EMAIL,EMP_HIREDATE
FROM LGEMPLOYEE
WHERE EMP_HIREDATE Between '2005-01-01' And '2014-12-31'
ORDER BY 1,2


----Print as months
SELECT EMP_FNAME, EMP_LNAME, EMP_EMAIL, 
       FORMAT(EMP_HIREDATE, 'MMM') AS HIRE_MONTH
FROM LGEMPLOYEE
WHERE EMP_HIREDATE BETWEEN '2005-01-01' AND '2014-12-31'
ORDER BY EMP_LNAME, EMP_FNAME;
-- 30 Write a query to display the first name, last name, phone number, title, 
--and department number of employees who work in department 300 or have the title “CLERK I” 
--Sort the output by last name and then by first name 


SELECT EMP_FNAME, EMP_LNAME, EMP_PHONE, EMP_TITLE, DEPT_NUM
FROM LGEMPLOYEE
WHERE DEPT_NUM=300 Or EMP_TITLE='CLERK I'
ORDER BY EMP_LNAME, EMP_FNAME;



SELECT EMP_FNAME, EMP_LNAME, EMP_PHONE, EMP_TITLE, DEPT_NUM
FROM LGEMPLOYEE
WHERE DEPT_NUM=300 Or EMP_TITLE='CLERK I'
ORDER BY 2, 1;

----------------------------------
-- 35 Write a query to display the number of products in each category that have a water base, sorted by category.

SELECT PROD_CATEGORY, Count(*) AS NUMPRODUCTS
FROM LGPRODUCT
WHERE PROD_BASE = 'Water'
GROUP BY PROD_CATEGORY
ORDER BY PROD_CATEGORY;


----------------------------------

-- 36 Write a query to display the number of products within each base and type combination, sorted by base and then by type 



SELECT PROD_BASE, PROD_TYPE, Count(*) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE, PROD_TYPE
ORDER BY PROD_BASE, PROD_TYPE;

-- 37 Write a query to display  number of products within each base and type combination,also when the number of product
--is greater than 70. Sorted by base and then by type

SELECT PROD_BASE, PROD_TYPE, Count(*) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE, PROD_TYPE
having Count(*) >70
ORDER BY PROD_BASE, PROD_TYPE;
-- 38 Write a query to display the number of products within each type, sorted by type 

SELECT PROD_BASE, PROD_TYPE, Count(prod_sku) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE, PROD_TYPE
ORDER BY PROD_BASE, PROD_TYPE;

SELECT PROD_TYPE, Count(prod_sku) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_TYPE
ORDER BY PROD_TYPE;
-- 39 Write a query to display the number of products within each Base, sorted by base 
SELECT PROD_BASE, Count(prod_sku) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE
ORDER BY PROD_BASE;

-- 40 Write a query to display the total inventory. Total inventory is the sum of all products on hand.


SELECT  Sum(PROD_QOH) AS TOTALINVENTORY
FROM LGPRODUCT

-- 41 Write a query to display the total inventory. Total inventory is the sum of all products on hand for each brand ID. 
--Sort the output by brand ID in descending order 


SELECT BRAND_ID, Sum(PROD_QOH) AS TOTALINVENTORY
FROM LGPRODUCT
GROUP BY BRAND_ID
ORDER BY BRAND_ID DESC;

-- 42 Write a query to display the total inventory for the brand IDs that has more than 2000 inventory.
--Sort the output by brand ID in descending order 

SELECT BRAND_ID, Sum(PROD_QOH) AS TOTALINVENTORY
FROM LGPRODUCT
GROUP BY BRAND_ID
HAVING SUM(PROD_QOH)>2000
ORDER BY BRAND_ID DESC;
------
-- 43 Write a query to display the department number and most recent employee hire date for each department. 
--Sort the output by department number.


SELECT	DEPT_NUM, Max(EMP_HIREDATE) AS MOSTRECENT
FROM	LGEMPLOYEE
GROUP BY DEPT_NUM
ORDER BY DEPT_NUM;
-----



--======================IS NULL Operator=======================
--NULL DATA
--1. Show  product code and description without vendor (v_code null).


SELECT * FROM PRODUCT;
SELECT P_CODE,P_DESCRIPT
	FROM PRODUCT
		WHERE V_CODE IS  NULL;


--2.  Show  product code and description with vendor (v_code IS NOT null).
SELECT P_CODE,P_DESCRIPT
	FROM PRODUCT
		WHERE V_CODE IS not NULL;


-----------------USING NOT
--List the descriptions of all products that do not have price more than 8$.

select P_DESCRIPT,P_PRICE from product 
where P_PRICE<8


SELECT    P_DESCRIPT,P_PRICE FROM  PRODUCT
WHERE  NOT (P_PRICE>8)

--SUBQUERY
SELECT    P_DESCRIPT,P_PRICE FROM  PRODUCT
WHERE P_PRICE  NOT IN (SELECT P_PRICE FROM PRODUCT WHERE P_PRICE>8)


select P_DESCRIPT from PRODUCT 
where P_PRICE not in(select P_PRICE from PRODUCT where P_PRICE>8)



--======================IN Operator=======================
--1. List the customer ID, first name, last name, and BALANE  
--for each customer with a balance ARE  345.86, 221.19, or 768.93.





SELECT CUS_CODE, CUS_FNAME, CUS_LNAME, CUS_BALANCE
	FROM CUSTOMER
		WHERE CUS_BALANCE =345.86
			OR CUS_BALANCE =221.19
			OR CUS_BALANCE = 768.93;

SELECT CUS_CODE, CUS_FNAME, CUS_LNAME, CUS_BALANCE
	FROM CUSTOMER
		WHERE CUS_BALANCE
		 IN (345.86, 221.19, 768.93);

--2 List all vendors from TN, KY, OR FL

SELECT * FROM VENDOR

SELECT * FROM VENDOR 
WHERE V_STATE='TN' OR
V_STATE='KY' OR
V_STATE='FL'

--OR
SELECT * FROM VENDOR 
WHERE V_STATE IN('TN','KY','FL')


--3 list the name and code for customers who generate/have invoice.
-- UNCORRELATED QUERY

SELECT * FROM CUSTOMER 
SELECT * FROM INVOICE 

----WITHOUT APPLY RULES AND name
SELECT DISTINCT CUS_CODE FROM INVOICE

select CUS_LNAME,CUS_CODE from CUSTOMER  where CUS_CODE IN
( select cus_code from  INVOICE )



-- Exists- Correlated subquery
select C.CUS_LNAME,CUS_CODE from CUSTOMER C where exists 
( select * from  INVOICE I where  C.CUS_CODE=I.CUS_CODE )


select CUSTOMER.CUS_LNAME,CUS_CODE from CUSTOMER  where exists 
( select * from  INVOICE  where  CUSTOMER.CUS_CODE=INVOICE.CUS_CODE )






--4 list the name and code for customers who do not generate invoice.
-- UNCORRELATED QUERY
select CUS_LNAME,CUS_CODE from CUSTOMER  where CUS_CODE not IN
( select cus_code from  INVOICE )


-- Exists- Correlated subquery
select C.CUS_LNAME,CUS_CODE from CUSTOMER C where not exists ( select * from  INVOICE I where  C.CUS_CODE=I.CUS_CODE )




--5 List invoice number,line unites and product codes  where the units sold is greater than the average units for that product

SELECT L.INV_NUMBER, L.P_CODE, L.LINE_UNITS 
FROM LINE L 
WHERE L.LINE_UNITS > (SELECT AVG(L.LINE_UNITS) FROM LINE L)

--remove time from date in invoice table

select * from INVOICE

select  INV_NUMBER,cast (INV_DATE  as date)FORMATTEDDATE from INVOICE



