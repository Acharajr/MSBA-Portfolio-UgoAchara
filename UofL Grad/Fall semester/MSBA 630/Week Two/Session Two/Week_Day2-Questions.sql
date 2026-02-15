------------------REQUIRED CLAUSES----------------
/*
SELECT		COLUMNS, EXPRESSIONS
FROM		TABLENAME
*/




------------------OPTIONAL CLAUSES----------------
/*WHERE		CONDITIONS
GROUP BY	COLUMNS
HAVING		CONDITIONS FOR GROUPS
ORDER BY	SORT KEY COLUMNS
*/



-- 27 Write a query to display the departments informations in the LGDEPARTMENT table sorted by department name.
SELECT *
FROM lgdepartment
ORDER BY dept_name

-- Write a query to display the department with department number 600 in the LGDEPARTMENT table.
SELECT *
FROM lgdepartment
WHERE dept_num = 600


-- Write a query to display the accounting department in the LGDEPARTMENT table.
SELECT *
FROM lgdepartment
WHERE dept_name = 'ACCOUNTING'


-- 28  Write a query to display the SKU (stock keeping unit), description, type, base, category, 
--and price for all products that have a PROD_BASE of Water and a PROD_CATEGORY of Sealer 

SELECT prod_sku, prod_descript, prod_type, prod_base, prod_category, prod_price
FROM lgproduct
WHERE prod_base = 'WATER' AND prod_category = 'SEALER'

------------------------

-- 29 Write a query to display the first name, last name,hiredate and email of employees hired 
--from January 1, 2005, to December 31, 2014. Sort the output by last name and then by first name 

SELECT emp_fname, emp_lname, emp_hiredate, emp_email
FROM lgemployee
WHERE emp_hiredate BETWEEN '2005-01-01' AND '2014-12-31'
--WHERE emp_hiredate >= 'January 1, 2005' and emp_hiredate <= 'December 31, 2014'
ORDER BY emp_lname

-- 30 Write a query to display the first name, last name, phone number, title, 
--and department number of employees who work in department 300 or have the title “CLERK I” 
--Sort the output by last name and then by first name 

SELECT emp_fname, emp_lname, emp_phone, emp_title,dept_num
FROM lgemployee
WHERE dept_num = 300 OR emp_title = 'CLERK I'
ORDER BY emp_lname, emp_fname

----------------------------------
-- 35 Write a query to display the number of products in each category that have a water base, sorted by category.
SELECT prod_category, COUNT(*) 'WATER BASED PRODUCT IN EACH CAT'
FROM lgproduct
WHERE prod_base = 'WATER'
GROUP BY prod_category
ORDER BY prod_category


----------------------------------

-- 36 Write a query to display the number of products within each base and type combination, sorted by base and then by type 
SELECT prod_base, prod_type, COUNT(*) 'combination'
FROM lgproduct
GROUP BY prod_type, prod_base
ORDER BY prod_type, prod_base;


-- 37 Write a query to display  number of products within each base and type combination,also when the number of product
--is greater than 70. Sorted by base and then by type
-- "having" is used to state a condition for the function
SELECT prod_base, prod_type, COUNT(*) 'combination'
FROM lgproduct
GROUP BY prod_type, prod_base
HAVING count(*) > 70
ORDER BY prod_type, prod_base;


-- 38 Write a query to display the number of products within each type, sorted by type 

SELECT prod_type, COUNT(*) 'NUM OF PRODUCT FR EACH TYPE'
FROM lgproduct
GROUP BY prod_type
ORDER BY prod_type

-- 39 Write a query to display the number of products within each Base, sorted by base 
SELECT prod_base, COUNT(*) 'NUM OF PRODUCT FR EACH TYPE'
FROM lgproduct
GROUP BY prod_base
ORDER BY prod_base


-- 40 Write a query to display the total inventory. Total inventory is the sum of all products on hand.
SELECT SUM(prod_qoh) 'NUM OF PRODT ON HAND'
FROM lgproduct

-- 41 Write a query to display the total inventory. Total inventory is the sum of all products on hand for each brand ID. 
--Sort the output by brand ID in descending order 
SELECT brand_id, SUM(prod_qoh) 'NUM OF PRODT ON HAND'
FROM lgproduct
GROUP BY brand_id
ORDER BY brand_id desc

-- 42 Write a query to display the total inventory for the brand IDs that has more than 2000 inventory.
--Sort the output by brand ID in descending order 

SELECT brand_id, SUM(prod_qoh) 'NUM OF PRODT ON HAND'
FROM lgproduct
GROUP BY brand_id
HAVING sum(prod_qoh) > 2000
ORDER BY brand_id desc

------
-- 43 Write a query to display the department number and most recent employee hire date for each department. 
--Sort the output by department number.
SELECT dept_num, emp_hiredate
FROM lgemployee
GROUP BY dept_num,emp_hiredate
ORDER BY dept_num,emp_hiredate DESC
-----



--======================IS NULL Operator=======================
--NULL DATA
--1. Show  product code and description without vendor (v_code null).
SELECT P_CODE, P_DESCRIPT
FROM PRODUCT
WHERE V_CODE IS null

--2.  Show  product code and description with vendor (v_code IS NOT null).
SELECT P_CODE, P_DESCRIPT
FROM PRODUCT
WHERE V_CODE IS NOT null
	

-----------------USING NOT
--List the descriptions of all products that do not have price more than 8$.


--SUBQUERY



--======================IN Operator=======================
--1. List the customer ID, first name, last name, and BALANE  
--for each customer with a balance ARE  345.86, 221.19, or 768.93.




--2 List all vendors from TN, KY, OR FL



--3 list the name and code for customers who generate/have invoice.
-- UNCORRELATED QUERY

SELECT CUS_FNAME, CUS_LNAME, CUS_CODE
FROM CUSTOMER
WHERE CUS_CODE IN (
	SELECT CUS_CODE FROM INVOICE
	)

	SELECT CUS_FNAME, CUS_LNAME, CUS_CODE
FROM CUSTOMER
WHERE CUS_CODE NOT IN (
	SELECT CUS_CODE FROM INVOICE
	)

-- Exists- Correlated subquery

SELECT C.CUS_LNAME, CUS_CODE
FROM CUSTOMER C
WHERE EXISTS (
	SELECT * FROM INVOICE I WHERE C.CUS_CODE = I.CUS_CODE)

SELECT CUSTOMER.CUS_LNAME, CUS_CODE
FROM CUSTOMER 
WHERE EXISTS (
	SELECT * FROM INVOICE WHERE CUSTOMER.CUS_CODE = INVOICE.CUS_CODE)


--4 list the name and code for customers who do not generate invoice.
-- UNCORRELATED QUERY


-- Exists- Correlated subquery





--5 List invoice number,line unites and product codes  where the units sold is greater than the average units for that product




