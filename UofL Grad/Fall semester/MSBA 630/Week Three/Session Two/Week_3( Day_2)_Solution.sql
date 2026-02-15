


--Practice Day 2

--1 Write a query to display the largest average product price of all brand.



--First find average product prices for each brand

SELECT BRAND_ID, Avg(PROD_PRICE) AS AVGPRICE
		 FROM	LGPRODUCT
		 GROUP BY BRAND_ID

--SELECT BRAND_ID, FORMAT(Avg(PROD_PRICE),'N2') AS AVGPRICE
--		 FROM	LGPRODUCT
--		 GROUP BY BRAND_ID
--Find the maximum of averages
SELECT	Max(AVGPRICE) AS "LARGEST AVERAGE"
FROM	(SELECT BRAND_ID, FORMAT(Avg(PROD_PRICE),'N2') AS AVGPRICE
		 FROM	LGPRODUCT
		 GROUP BY BRAND_ID) AS BRANDAVGS;

----ANOTHER WAY
	SELECT  AVGPRICE AS "LARGEST AVERAGE"
FROM (
    SELECT BRAND_ID, FORMAT(AVG(PROD_PRICE),'N2') AS AVGPRICE
    FROM LGPRODUCT
    GROUP BY BRAND_ID
) AS BRANDAVGS
WHERE AVGPRICE = (
    SELECT MAX(AVGPRICE)
    FROM (
        SELECT BRAND_ID, FORMAT(AVG(PROD_PRICE),'N2') AS AVGPRICE
        FROM LGPRODUCT
        GROUP BY BRAND_ID
    ) AS SUBQUERY
);
--------
--VIEW
-------
---------------------------------
--VIEW

CREATE VIEW NewBRANDAVERAGEE
AS
SELECT	BRAND_ID, FORMAT(Avg(PROD_PRICE),'N2') AS AVGPRICE
FROM	LGPRODUCT
GROUP BY BRAND_ID

SELECT	Max(AVGPRICE) AS [LARGEST AVERAGE]
FROM	NewBRANDAVERAGEE


--drop view NewBRANDAVERAGEE


--2 LIST THE NAME OF THE VENDOR WHO CARRIES THE MOST EXPENSIVE PRODUCT

SELECT V.V_NAME, P.P_PRICE
FROM PRODUCT P INNER JOIN VENDOR V
ON P.V_CODE=V.V_CODE
WHERE P.P_PRICE=(SELECT MAX (P_PRICE) FROM PRODUCT)

----ANOTHER WAY

SELECT V.V_NAME, MAX(P.P_PRICE) AS [MAXPRICE FOR VENDOR]
FROM PRODUCT P INNER JOIN VENDOR V 
ON P.V_CODE=V.V_CODE
GROUP BY V.V_NAME
HAVING MAX(P.P_PRICE)= (SELECT MAX(P.P_PRICE)
                          FROM PRODUCT P )

--Alternative solution
                        
SELECT V_NAME,P_PRICE  

		FROM PRODUCT INNER JOIN VENDOR 
				ON VENDOR.V_CODE=PRODUCT.V_CODE

					WHERE P_PRICE  in (SELECT max(P_PRICE ) from PRODUCT)

						GROUP BY V_NAME,P_PRICE
----ANOTHER WAY

SELECT V_NAME,P_PRICE from PRODUCT INNER JOIN VENDOR on VENDOR.V_CODE=PRODUCT.V_CODE
GROUP BY V_NAME,P_PRICE
HAVING P_PRICE=(SELECT MAX(P_PRICE) FROM PRODUCT)
--



----VIEW
CREATE VIEW MAXPRICEVENDOR
AS
SELECT V.V_NAME, MAX(P.P_PRICE) AS [MAXPRICE FOR VENDOR]
FROM PRODUCT P INNER JOIN VENDOR V 
ON P.V_CODE=V.V_CODE
GROUP BY V.V_NAME

--THIS CODE JUST THE MAX PRICE
--SELECT MAX([MAXPRICE FOR VENDOR]) AS MAXWANTED
--	FROM MAXPRICEVENDOR

--Since we need the name of vendor too

-- Select the vendor with the highest maximum price
SELECT V_NAME, [MAXPRICE FOR VENDOR]
FROM MAXPRICEVENDOR
WHERE [MAXPRICE FOR VENDOR] = (SELECT MAX([MAXPRICE FOR VENDOR]) FROM MAXPRICEVENDOR);

--DROP VIEW MAXPRICEVENDOR

-----------------------------------------
SELECT * FROM LINE

--3 Identify the product code for the product that has the highest average number of units among all products.
CREATE VIEW PRODUCTAVERAGELINE AS

SELECT P_CODE, AVG(LINE_UNITS) AS AVGUNIT
FROM LINE 
GROUP BY P_CODE

--SELECT * FROM PRODUCTAVERAGELINE

SELECT  P_CODE,MAX(AVGUNIT) AS MAXIMUM
FROM PRODUCTAVERAGELINE

WHERE [AVGUNIT]=(SELECT MAX(AVGUNIT) FROM PRODUCTAVERAGELINE)
GROUP BY P_CODE

---ALTERNATIVE WITHOUT VIEW
SELECT P_CODE, AVERAGE
FROM (
    SELECT L.P_CODE,
           AVG(LINE_UNITS) AS AVERAGE
    FROM LINE L
    JOIN PRODUCT P ON L.P_CODE = P.P_CODE
    GROUP BY L.P_CODE
) AS LINETEST
WHERE AVERAGE = (
    SELECT MAX(AVERAGE)
    FROM (
        SELECT AVG(LINE_UNITS) AS AVERAGE
        FROM LINE
        GROUP BY P_CODE
    ) AS X
);

-------------------------------------------------------------------------------------------------------------------------


-- 4 Write the SQL code listing Invoice date, line units, line price,customer code, invoice number, and product description of
--all purchases made by the customers. 
--Sort the results by customer code, invoice number, and product description. (SalesCompany)

SELECT CUS_CODE, INVOICE.INV_NUMBER, INV_DATE, P_DESCRIPT, LINE_UNITS, LINE_PRICE
FROM INVOICE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER JOIN PRODUCT ON PRODUCT.P_CODE = LINE.P_CODE
ORDER BY CUS_CODE, INVOICE.INV_NUMBER, P_DESCRIPT;



--extra join==> don't do that-be effeceint
SELECT CUSTOMER.CUS_CODE, INVOICE.INV_NUMBER, INV_DATE, P_DESCRIPT, LINE_UNITS, LINE_PRICE
	FROM  CUSTOMER  INNER JOIN INVOICE  ON CUSTOMER.CUS_CODE=INVOICE.CUS_CODE INNER JOIN  LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER 
		INNER JOIN PRODUCT ON PRODUCT.P_CODE = LINE.P_CODE
			ORDER BY CUSTOMER.CUS_CODE, INVOICE.INV_NUMBER, P_DESCRIPT;

--5 Write an SQL query to generate a list of customer codes, including the units purchased (line_units), and the subtotal for 
--each line item on the invoice. The subtotal should be calculated by multiplying the number of units (LINE_UNITS) by 
--the unit price (LINE_PRICE). The results should be sorted by customer code, invoice number, and product description.

SELECT CUS_CODE, INVOICE.INV_NUMBER, P_DESCRIPT, LINE_UNITS AS "Units Bought", LINE_PRICE AS "Unit Price",
LINE_UNITS * LINE_PRICE AS Subtotal
	FROM INVOICE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER JOIN PRODUCT ON LINE.P_CODE = PRODUCT.P_CODE
		ORDER BY CUS_CODE, INVOICE.INV_NUMBER, P_DESCRIPT;



-- 6  Write a query to display the customer code, balance, and total purchases for each customer. Total purchase is calculated by summing the line subtotals
--(as calculated in Problem 5)for each customer. Sort the results by customer code, and use aliases.
SELECT 	CUSTOMER.CUS_CODE, CUS_BALANCE, SUM(LINE_UNITS * LINE_PRICE) AS "Total Purchases"
FROM CUSTOMER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER
GROUP BY CUSTOMER.CUS_CODE, CUS_BALANCE
ORDER BY CUSTOMER.CUS_CODE;

---TEST THE WORK

SELECT 	CUSTOMER.CUS_CODE, CUS_BALANCE, SUM(LINE_UNITS * LINE_PRICE) AS "Total Purchases"
FROM CUSTOMER  JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE  JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER
WHERE CUSTOMER.CUS_CODE=10015
GROUP BY CUSTOMER.CUS_CODE, CUS_BALANCE
ORDER BY CUSTOMER.CUS_CODE;



-- 7 Modify the query in Problem 6 to include the number of individual product purchases made by each customer. 
--(In other words, if the customer’s invoice is based on three products, one per LINE_NUMBER, you count three product purchases.
--Note that in the original invoice data,customer 10011 generated three invoices, which contained a total of six lines, each representing a product purchase.)

SELECT 	CUSTOMER.CUS_CODE, CUS_BALANCE, SUM(LINE_UNITS * LINE_PRICE) AS "Total Purchases", COUNT(*) AS "Number of Purchases"
FROM CUSTOMER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER
GROUP BY CUSTOMER.CUS_CODE, CUS_BALANCE
ORDER BY CUSTOMER.CUS_CODE;

-- 8 Write a query to display the employee number, last name, first name, salary “from” date, salary end date, and salary amount 
--for employees 83731, 83745, and 84039. 
--Sort the output by employee number and salary “from” date (LargeCompany).
SELECT EMP.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_FROM, SAL_END, SAL_AMOUNT
FROM LGEMPLOYEE EMP JOIN LGSALARY_HISTORY SAL ON EMP.EMP_NUM = SAL.EMP_NUM
WHERE EMP.EMP_NUM In (83731, 83745, 84039)
ORDER BY EMP.EMP_NUM, SAL_FROM;

----ANOTHER WAY
SELECT EMP.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_FROM, SAL_END, SAL_AMOUNT
FROM LGEMPLOYEE EMP JOIN LGSALARY_HISTORY SAL ON EMP.EMP_NUM = SAL.EMP_NUM
WHERE EMP.EMP_NUM ='83731'  or EMP.EMP_NUM = '83745'  or EMP.EMP_NUM ='84039'
ORDER BY EMP.EMP_NUM, SAL_FROM;



-- 9 Write a query to display the first name, last name, street, city, state, and zip code of any customer who purchased 
--a Foresters Best brand and  top coat between July 15, 2015, and July 31, 2015. If a customer purchased more than one such product,
--display the customer’s information only once in the output. Sort the output by state, last name, and then first name (LargeCompany).

SELECT DISTINCT CUST_FNAME, CUST_LNAME, CUST_STREET, CUST_CITY, CUST_STATE, CUST_ZIP
FROM LGCUSTOMER AS C JOIN LGINVOICE AS I ON C.CUST_CODE = I.CUST_CODE 
    INNER JOIN LGLINE AS L ON I.INV_NUM = L.INV_NUM INNER JOIN LGPRODUCT AS P ON L.PROD_SKU = P.PROD_SKU 
	INNER JOIN LGBRAND AS B ON P.BRAND_ID = B.BRAND_ID
WHERE BRAND_NAME = 'FORESTERS BEST'
      AND PROD_CATEGORY = 'Top Coat'
      AND INV_DATE BETWEEN '07/15/2015' AND '07/31/2015'
ORDER BY CUST_STATE, CUST_LNAME, CUST_FNAME;

---IF YOU TRY uning like: It might don't work because there might be Whitespace or Hidden Characters:

--Sometimes, there could be leading or trailing spaces in the BRAND_NAME column, or non-printable characters in the string you're matching


-- if you want to make it work you should use 	WHERE TRIM(B.BRAND_NAME) LIKE '%FORESTERS BEST%'



---Old fashion of Join

--SELECT DISTINCT CUST_FNAME, CUST_LNAME, CUST_STREET, CUST_CITY, CUST_STATE, CUST_ZIP
--FROM LGCUSTOMER AS C, LGINVOICE AS I , LGLINE AS L,LGPRODUCT AS P,  LGBRAND AS B
--where  C.CUST_CODE = I.CUST_CODE 
--    and   I.INV_NUM = L.INV_NUM and   L.PROD_SKU = P.PROD_SKU and  P.BRAND_ID = B.BRAND_ID
--and BRAND_NAME = 'FORESTERS BEST'
--      AND PROD_CATEGORY = 'Top Coat'
--      AND INV_DATE BETWEEN '07/15/2015' AND '07/31/2015'
--ORDER BY CUST_STATE, CUST_LNAME, CUST_FNAME;


-- 10 Write a query to display the employee number, last name, email address, title, and department name of each employee
--whose job title ends in the word “ASSOCIATE.” Sort the output by department name and employee title.(LargeCompany)

SELECT E.EMP_NUM, EMP_LNAME, EMP_EMAIL, EMP_TITLE, DEPT_NAME
FROM LGEMPLOYEE AS E JOIN LGDEPARTMENT AS D ON E.DEPT_NUM = D.DEPT_NUM
WHERE EMP_TITLE LIKE '%ASSOCIATE'
ORDER BY DEPT_NAME, EMP_TITLE;


-- 11 Write a query to display a brand name and the number of products of that brand that are in the database. Sort the output by the brand name.
SELECT BRAND_NAME, Count(PROD_SKU) AS NUMPRODUCTS
FROM LGBRAND AS B JOIN LGPRODUCT AS P ON B.BRAND_ID = P.BRAND_ID
GROUP BY BRAND_NAME
ORDER BY BRAND_NAME;

-- 12 Write a query to display the brand ID, brand name, and average price of products of each brand. Sort the output by brand name. Results are shown with the average price rounded to two decimal places.
SELECT P.BRAND_ID, BRAND_NAME, FORMAT(Avg(PROD_PRICE),'N2') AS AVGPRICE
FROM LGBRAND AS B JOIN LGPRODUCT AS P ON B.BRAND_ID = P.BRAND_ID
GROUP BY P.BRAND_ID, BRAND_NAME
ORDER BY BRAND_NAME;



--------
--Use ALL
--13 List all products that have a higher price than products from Florida.

--SELECT P_PRICE FROM VENDOR V JOIN PRODUCT P ON P.V_CODE=V.V_CODE WHERE V_STATE='FL'


--Subqueries
----ALL: Compares a value to all values returned by a subquery. ALL: True only if the condition is true for every value.
--SELECT * FROM PRODUCT WHERE P_PRICE > ALL ( SELECT P_PRICE 
--                                             FROM PRODUCT WHERE V_CODE IN (SELECT V_CODE FROM VENDOR 
--											 WHERE V_STATE='FL'))
--ANY: Compares a value to any value returned by a subquery. ANY: True if the condition is true for at least one value.
--SELECT * FROM  PRODUCT WHERE P_PRICE >ANY (SELECT P_PRICE 
--											FROM VENDOR V JOIN PRODUCT P ON P.V_CODE=V.V_CODE 
--											WHERE V_STATE='FL')
--IN: Checks if a value matches any value in a list or subquery. IN is like multiple OR conditions.
--SELECT * FROM  PRODUCT WHERE P_PRICE IN (SELECT P_PRICE 
--											FROM VENDOR V JOIN PRODUCT P ON P.V_CODE=V.V_CODE 
--											WHERE V_STATE='FL')


--ALTERNATE SOLUTION
--NESTED QUERIES IN THE WHERE CLAUSE

SELECT * FROM PRODUCT 
WHERE P_PRICE > ( SELECT MAX (P_PRICE) 
					FROM PRODUCT 
					WHERE V_CODE IN ( SELECT V_CODE FROM VENDOR WHERE V_STATE='FL'))

--ANOTHER WAY
SELECT * FROM PRODUCT P
WHERE P.P_PRICE >( SELECT MAX(P.P_PRICE) 
						FROM PRODUCT P INNER JOIN VENDOR V ON P.V_CODE=V.V_CODE
                         WHERE V.V_STATE LIKE '%FL%')

-------

--List the customer name in the format Lastname, MI, Firstname.
--+ SIGN IS STRING CONCATENATOR

SELECT * FROM CUSTOMER

SELECT CUS_LNAME + ','+CUS_INITIAL +','+ CUS_FNAME AS NEWNAME
FROM CUSTOMER


-------------------------------self join
--14 Using the sales company database, there are products that provide by vendors. list pairs of the products (side by side) offered by a vendor.
--The result should contain three columns <first product code, second product code, description for the 
-- product that has higher price.


SELECT * FROM PRODUCT
WHERE V_CODE IS NOT NULL
ORDER BY V_CODE


	SELECT P1.P_CODE,P2.P_CODE, P1.P_DESCRIPT,P1.V_CODE,P1.P_PRICE

	FROM PRODUCT P1 JOIN PRODUCT P2 ON
	 P1.V_CODE=P2.V_CODE 
	 
	 WHERE
	 
	 P1.P_PRICE>P2.P_PRICE
	 ORDER BY V_CODE