--Practice Day 2

--1 Write a query to display the largest average product price of all brand.
SELECT brand_id, AVG(prod_price) 'AVERAGE PRICE'
FROM lgproduct 
GROUP BY brand_id

SELECT MAX(AVERAGE PRICE) 'MAX AVG PRICE'
	FROM (SELECT brand_id, AVG(prod_price) 'Average Price'
FROM lgproduct
GROUP BY brand_id
) as TEST 


--------
--VIEW

CREATE VIEW AVERAGEBRAND1
AS

SELECT brand_id, AVG(prod_price) 'AVERAGEPRICE'
FROM lgproduct 
GROUP BY brand_id

SELECT * FROM AVERAGEBRAND

SELECT MAX(AVERAGEPRICE) 'MAX AVG PRICE'
FROM AVERAGEBRAND1


--2- LIST THE NAME OF THE VENDOR WHO CARRIES THE MOST EXPENSIVE PRODUCT

SELECT * FROM PRODUCTPRICE

CREATE VIEW PRODUCTPRICE
AS

SELECT V_NAME, MAX(P_PRICE) 'LARGESTPRICE'
FROM VENDOR V
JOIN PRODUCT P ON V.V_CODE = P.V_CODE
GROUP BY V.V_NAME

SELECT V_NAME, LARGESTPRICE
FROM PRODUCTPRICE
WHERE LARGESTPRICE=(SELECT MAX(LARGESTPRICE) FROM PRODUCTPRICE)


--3 Identify the product code for the product that has the highest average number of units among all products.

CREATE VIEW PRODUCTCODES
AS

SELECT P.P_CODE, AVG(L.LINE_UNITS) 'AVERAGEUNITS'
FROM PRODUCT P
JOIN LINE L ON P.P_CODE = L.P_CODE
GROUP BY P.P_CODE

SELECT * FROM PRODUCTCODES

SELECT P_CODE, AVERAGEUNITS
FROM PRODUCTCODES
WHERE AVERAGEUNITS = (SELECT MAX(AVERAGEUNITS) FROM PRODUCTCODES)





-------------------------------------------------------------------------------------------------------------------------


-- 4 Write the SQL code listing Invoice date, line units, line price,customer code, invoice number, and product description of all purchases made by the customers. 
--Sort the results by customer code, invoice number, and product description. (SalesCompany)

SELECT INV_DATE, LINE_UNITS, LINE_PRICE, CUS_CODE, I.INV_NUMBER, P_DESCRIPT
FROM INVOICE I
JOIN LINE L ON I.INV_NUMBER = L.INV_NUMBER
JOIN PRODUCT P ON L.P_CODE = P.P_CODE
ORDER BY CUS_CODE, INV_NUMBER, P_DESCRIPT




--5 Write an SQL query to generate a list of customer codes, including the units purchased (line_units), and the subtotal for 
--each line item on the invoice. The subtotal should be calculated by multiplying the number of units (LINE_UNITS) by 
--the unit price (LINE_PRICE). The results should be sorted by customer code, invoice number, and product description.

SELECT CUS_CODE, L.LINE_UNITS, (L.LINE_UNITS * L.LINE_PRICE) 'SUBTOTAL'
FROM INVOICE I 
JOIN LINE L ON I.INV_NUMBER = L.INV_NUMBER
JOIN PRODUCT P ON L.P_CODE = P.P_CODE
ORDER BY CUS_CODE, I.INV_NUMBER, P_DESCRIPT


-- 6  Write a query to display the customer code, balance, and total purchases for each customer. Total purchase is calculated by summing the line subtotals
--(as calculated in Problem 5)for each customer. Sort the results by customer code, and use aliases.

SELECT C.CUS_CODE, C.CUS_BALANCE, SUM(L.LINE_UNITS * L.LINE_PRICE) 'TOTAL PURCHASE'
FROM CUSTOMER C
JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY C.CUS_CODE, C.CUS_BALANCE
ORDER BY C.CUS_CODE


-- 7 Modify the query in Problem 6 to include the number of individual product purchases made by each customer. 
--(In other words, if the customer’s invoice is based on three products, one per LINE_NUMBER, you count three product purchases.
--Note that in the original invoice data,customer 10011 generated three invoices, which contained a total of six lines, each representing a product purchase.)

SELECT * FROM INVOICE

SELECT C.CUS_CODE, C.CUS_BALANCE, SUM(L.LINE_UNITS * L.LINE_PRICE) 'TOTAL PURCHASE', COUNT(I.INV_NUMBER) 'NUM PRODUCT PURCHASES'
FROM CUSTOMER C
JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L ON I.INV_NUMBER = L.INV_NUMBER
GROUP BY C.CUS_CODE, C.CUS_BALANCE
ORDER BY C.CUS_CODE


-- 8 Write a query to display the employee number, last name, first name, salary “from” date, salary end date, and salary amount 
--for employees 83731, 83745, and 84039. 
--Sort the output by employee number and salary “from” date (LargeCompany).

SELECT E.emp_num, emp_lname, emp_fname, sal_from, sal_end, sal_amount
FROM lgemployee E
JOIN lgsalary_history S ON E.emp_num = S.emp_num
WHERE E.emp_num IN (83731,83745,84039)
ORDER BY emp_num, sal_from




-- 9 Write a query to display the first name, last name, street, city, state, and zip code of any customer who purchased 
--a Foresters Best brand and  top coat between July 15, 2015, and July 31, 2015. If a customer purchased more than one such product,
--display the customer’s information only once in the output. Sort the output by state, last name, and then first name (LargeCompany).

SELECT cust_fname, cust_lname, cust_street, cust_city, cust_state, cust_zip
FROM lgcustomer C
INNER JOIN lginvoice I ON C.cust_code = I.cust_code
INNER JOIN lgline L ON I.inv_num = L.inv_num
INNER JOIN lgproduct P ON L.prod_sku = P.prod_sku
INNER JOIN lgbrand B ON P.brand_id = B.brand_id
WHERE B.brand_name = 'Foresters Best' 
	AND P.prod_category = 'TOP COAT' 
	AND I.inv_date BETWEEN '2015-07-15' AND '2015-07-31'
ORDER BY cust_state, cust_lname, cust_fname


SELECT *
FROM lgproduct

SELECT *
FROM lgbrand


SELECT *
FROM lginvoice

-- 10 Write a query to display the employee number, last name, email address, title, and department name of each employee
--whose job title ends in the word “ASSOCIATE.” Sort the output by department name and employee title.(LargeCompany)


-- 11 Write a query to display a brand name and the number of products of that brand that are in the database. Sort the output by the brand name.


-- 12 Write a query to display the brand ID, brand name, and average price of products of each brand. Sort the output by brand name. Results are shown with the average price rounded to two decimal places.




--13 List all products that have a higher price than products from Florida.




-------------------------------self join
--14 Using the sales company database, there are products that provide by vendors. list pairs of the products (side by side) offered by a vendor.
--The result should contain three columns <first product code, second product code, description for the 
-- product that has higher price.

