---WEEK#3- Day 1
--JOIN

--1- List product code, product description, along with vendor code and vendor name
SELECT P.P_CODE, P.P_DESCRIPT, V.V_CODE, V.V_NAME
FROM PRODUCT P
JOIN VENDOR V ON P.V_CODE = V.V_CODE



--2- List product code, product description, along with vendor code and vendor name. Order by vendor name and product 
--description (decending)

--3- LIST ALL VENDOR NAMES, VENDOR CODE ALONG WITH THE MAX PRICE OF THE PRODUCTS BY EACH VENDOR

--SELECT * FROM PRODUCT
--ORDER BY V_CODE




--use of logical operators
--4- List vendor name and all products whose description contains 'painter' and are from the vendor Rubicon Systems.




--Joining more than two tables

--5 List customer Last name, invoice number, and product codes in each invoice



--6 List customer Last name, invoice number, Product description and product codes in each invoice


--Different Joins

--INNER JOIN

--RIGHT JOIN


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




-- 2 Write the SQL code that will yield the total number of hours worked for each employee,the total charges stemming from 
--those hours worked, and employee last name. sorted by employee number. (Construction Company) 






--3- Find the average price for each vendor

--SELECT * FROM PRODUCT



--4 List each product code and price along with the difference between price and average price


   

--5 List all product codes, invoice number and line unites  where the units sold is greater than the average units for that product



--------------------------------------------Case-----------------------------------------------------
--Find different category for product prices



--Use a CASE statement to list the site name, site depth, and a description of the depth.  If the depth is 0-50 feet, the depth is 'shallow'. 
--If the depth is >50 - 100, the depth is 'deep'.  If the depth is > 100 the depth is 'very deep'.
	

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

