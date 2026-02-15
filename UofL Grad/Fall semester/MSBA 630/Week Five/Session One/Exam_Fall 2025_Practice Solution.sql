--Write business Rules for provided ERD OR Draw the ERD based on the scenario
--Writing Sql Quesries
--Write SQL code to create tables
--Database Administration: 
--Add constraints
--drop tables
--Update values
--Copy tables
--insert values
--Delete one row
--Delete entire values
--Check your original tables




--1 Write the balance summary (min,max,avg,total,count) of customer balacnces.

SELECT * FROM CUSTOMER
select  count(CUS_BALANCE) countbalance, min(CUS_BALANCE) minbalance,max(CUS_BALANCE) maxbalance,
avg(CUS_BALANCE) avgbalance,
sum(CUS_BALANCE) summationofbalance
		from CUSTOMER 




--2 Write a query to display the brand ID, brand name, brand type, and average price of products for the
-- brand that has the largest average product price.

CREATE VIEW BRANDAVERAGE
AS
SELECT	BRAND_ID, FORMAT(Avg(PROD_PRICE),'N2') AS AVGPRICE
FROM	LGPRODUCT
GROUP BY BRAND_ID

--SELECT	Max(AVGPRICE) AS [LARGEST AVERAGE]
--FROM	BRANDAVERAGE

SELECT	B.BRAND_ID, B.BRAND_NAME, B.BRAND_TYPE, 
		AVGPRICE
FROM	LGBRAND AS B INNER JOIN BRANDAVERAGE A ON B.BRAND_ID = A.BRAND_ID
WHERE	A.AVGPRICE = (SELECT MAX(AVGPRICE) FROM	BRANDAVERAGE)



--ALTERNATE SOLUTION
	SELECT	P.BRAND_ID, B.BRAND_NAME, B.BRAND_TYPE, FORMAT(Avg(P.PROD_PRICE),'N2') AS AVGPRICE
FROM	LGPRODUCT AS P JOIN LGBRAND AS B ON P.BRAND_ID = B.BRAND_ID
GROUP BY P.BRAND_ID, B.BRAND_NAME, B.BRAND_TYPE
HAVING	FORMAT(Avg(PROD_PRICE),'N2') = 
		(SELECT	Max(AVGPRICE) AS 'LARGEST AVERAGE'
         FROM	(SELECT BRAND_ID, FORMAT(Avg(PROD_PRICE),'N2') AS AVGPRICE
                 FROM	LGPRODUCT P
                 GROUP BY BRAND_ID) AS BRANDAVGS
		)



--3 List the names (First and last name) and addresses(city and state) of all participants who have 
--registered for at least three tours.

SELECT  part_fname, 
        part_lname, 
        part_city, 
        part_state, 
        count(*) "Num tours" 
FROM    participant,
        partres 
WHERE   participant.part_id = partres.part_id 
GROUP BY part_fname, 
        part_lname, 
        part_city, 
        part_state 
HAVING count(*) > 2;



SELECT  part_fname, 
        part_lname, 
        part_city, 
        part_state, 
        count(*) "Num tours" 
FROM    participant p join 
        partres pr 
        on p.Part_ID=pr.Part_ID
GROUP BY part_fname, 
        part_lname, 
        part_city, 
        part_state 
HAVING count(*) > 2;




--4 Write a query to display the employee number, first name, last name, and largest salary 
--amount for each employee in department 200. Sort the output by largest salary in descending order.


SELECT	E.EMP_NUM, E.EMP_FNAME, E.EMP_LNAME, Max(S.SAL_AMOUNT) AS LARGESTSALARY
FROM	LGEMPLOYEE AS E INNER JOIN LGSALARY_HISTORY AS S ON E.EMP_NUM = S.EMP_NUM
WHERE	E.DEPT_NUM = 200
GROUP BY E.EMP_NUM, E.EMP_FNAME, E.EMP_LNAME
ORDER BY max(S.sal_amount) DESC;

--5 Write a query to display the customer code, first name, last name, and sum of all invoice totals for 
--customers with cumulative invoice totals greater than $1,500. Sort the output by the sum of invoice totals in descending order.


SELECT	C.CUST_CODE, C.CUST_FNAME, C.CUST_LNAME, Sum(I.INV_TOTAL) AS TOTALINVOICES
FROM	LGCUSTOMER AS C INNER JOIN LGINVOICE AS I ON  C.CUST_CODE = I.CUST_CODE
GROUP BY C.CUST_CODE, CUST_FNAME, CUST_LNAME
HAVING Sum(I.INV_TOTAL) > 1500
ORDER BY Sum(I.INV_TOTAL) DESC;







--6 list vendor code and vendor name who produce a product
--JOIN
select distinct v.V_CODE,v.V_NAME from vendor v INNER  join product p 
on v.V_CODE=p.V_CODE
order by v.V_CODE


--SUBQUERY
select  DISTINCT V.V_CODE,V.V_NAME from VENDOR V WHERE V.V_CODE 
IN( SELECT V.V_CODE FROM  PRODUCT P where V.V_CODE=P.V_CODE)


--OR
select  DISTINCT V.V_CODE,V.V_NAME from VENDOR V WHERE V.V_CODE 
IN( SELECT V.V_CODE FROM  PRODUCT P INNER JOIN VENDOR V ON V.V_CODE=P.V_CODE)

--CORRELATED QUERY

SELECT V.V_CODE,V.V_NAME FROM VENDOR V  WHERE
EXISTS( SELECT P.V_CODE FROM PRODUCT P  WHERE V.V_CODE=P.V_CODE)


--7 SELECT PRODUCT CODE AND VENDOR NAME FOR PRODUCTS THAT THEY DON'T HAVE VENDOR?(USING PROPER JOIN)
--SELECT P_CODE,P_DESCRIPT,V_CODE FROM PRODUCT
select distinct P.P_CODE,v.V_NAME from vendor v RIGHT  join product p 
on v.V_CODE=p.V_CODE WHERE V.V_CODE IS NULL

--OR
select distinct P.P_CODE,v.V_NAME from   product p LEFT  JOIN  vendor v
on v.V_CODE=p.V_CODE WHERE V.V_CODE IS NULL

--8  table employee2:

CREATE TABLE employee2 (
    EMPLOYEE_ID INT NOT NULL,
    FIRST_NAME VARCHAR(100),
    LAST_NAME VARCHAR(100),
    JOB_TITLE VARCHAR(100),
   HIRE_DATE DATE,
    SALARY DECIMAL(10, 2),
    MANAGER_ID INT
);

ALTER TABLE EMPLOYEE2
ADD CONSTRAINT PK_EMPLOYEE2 PRIMARY KEY (EMPLOYEE_ID) ,
CONSTRAINT FK_EMPLOYEE FOREIGN KEY (MANAGER_ID) REFERENCES  EMPLOYEE2(EMPLOYEE_ID)

select * from employee2
--drop table employee2
----Create table
--CREATE TABLE CUSTOMER_Test (
--CUST_NUM     INTEGER PRIMARY KEY,
--CUST_LNAME   VARCHAR(30),
--CUST_FNAME   VARCHAR(30),
--CUST_BALANCE DECIMAL(10,2));


--9 insert Some values into employee table based on provided instruction:
--Smith Jeanne with employee id 5000 as a Financial Manager hired in 1/1/2008 with 100000 salary. Smith does not have the manager.
INSERT INTO employee2 VALUES (5000, 'Smith', 'Jeanne','Financial Manager','2008-01-01','100000',null);

--10 insert Some values into employee table based on provided instruction:John Mayer with employee id 5001 is a staff hired in 10/06/2008 
--with 65000 salary. Smith is his manager

INSERT INTO employee2 VALUES (5001, 'John', 'Mayer','Staff Member','10-06-2008','65000','5000');

--11 insert Some values into employee table based on provided instruction:Jeanne Smith with employee id 5002 is a Financial Manager
--hired in 01/01/2008 with 100000 salary. John Mayer is her manager
INSERT INTO employee2 VALUES (5002, 'Smith', 'Jeanne','Financial Manager','2008-01-01','100000','5001');


--12 Copy the table EMPLOYEE2 and call it EMPLOYEE2TESTCOPY
SELECT * INTO EMPLOYEE2TESTCOPY
FROM EMPLOYEE2


--SELECT * FROM EMPLOYEE2TESTCOPY

--13 ADD NEW COLUMN INTO EMPLOYEE2TESTCOPY with DECIMAL AS IT'S DATATYPE (9,2)
 ALTER TABLE EMPLOYEE2TESTCOPY
 ADD NEWATTRIBUTE DECIMAL (9,2)

 --14 UPDATE THE NEW COLUMN AND MAKE IT EQUAL  TO 5
UPDATE  EMPLOYEE2TESTCOPY 
SET NEWATTRIBUTE=5  



--15 DELETE ALL DATA FROM EMPLOYEE2TESTCOPY
DELETE FROM EMPLOYEE2TESTCOPY

--16 DROP TABLE EMPLOYEE2TESTCOPY

DROP TABLE EMPLOYEE2TESTCOPY