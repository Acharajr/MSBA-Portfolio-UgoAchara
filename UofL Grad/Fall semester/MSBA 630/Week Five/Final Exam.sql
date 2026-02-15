--a: Write a query to generate the total number of invoices, total purchases (Total purchase is calculated by summing the line subtotals for each customer), 
--the smallest of the customer purchase amounts, the largest of the customer purchase amounts, and the average of all the customer purchase amounts.

--Note: output should carry all customers even the ones that don't have a purchase.
SELECT * FROM LINE
SELECT * FROM INVOICE

SELECT SUM(I.INV_NUMBER) 'TOTAL NUM OF INVOICES', 
		SUM(L.LINE_UNITS*L.LINE_PRICE) 'TOTAL PURCHASES', 
		MIN(L.LINE_UNITS*L.LINE_PRICE ) 'SMALLEST CUSTOMER PURCHASE AMOUNT',
		MAX(L.LINE_UNITS*L.LINE_PRICE ) 'LARGEST CUSTOMER PURCHASE AMOUNT',
		AVG(L.LINE_UNITS*L.LINE_PRICE ) 'AVEAGE OF ALL CUSTOMER PURCHASES'
FROM CUSTOMER C
	JOIN invoice I on C.cus_code = I.cus_code
	JOIN LINE L on I.INV_NUMBER = L.INV_NUMBER

--b- List the last name for each customer who has more than one invoice.
select CUS_LNAME, count(I.CUS_CODE) 'Num of invoices'
from customer C
INNER JOIN invoice I on C.cus_code = I.cus_code
group by cus_lname
having count(I.CUS_CODE) > 1

--c: Write a query to display all purchases by customer if the unit price is greater than 10 dollar. Sort the output by customer code, invoice number and product description.
select C.CUS_CODE, I.INV_NUMBER, P_DESCRIPT
from CUSTOMER C
	join INVOICE I on C.CUS_CODE = I.CUS_CODE
	join LINE L on I.INV_NUMBER = L.INV_NUMBER
	JOIN PRODUCT P ON L.P_CODE = P.P_CODE
WHERE P_PRICE > 10
GROUP BY C.CUS_CODE, I.INV_NUMBER, P_DESCRIPT
ORDER BY C.CUS_CODE, I.INV_NUMBER, P_DESCRIPT



--d- List all customer last names of customers who have not bought any product. Use an outer join.
SELECT CUS_LNAME
FROM CUSTOMER C
	LEFT JOIN INVOICE I on C.CUS_CODE = I.CUS_CODE
WHERE I.INV_NUMBER = 0

--e: List the vendor code and vendor name who have price greater than 2 and quantity in hand (p_QOH) less than 8 and product date is after 2013-09-05 (using a join).
SELECT V.V_CODE, V_NAME
FROM VENDOR V
	JOIN PRODUCT P ON V.V_CODE = P.V_CODE
WHERE P_PRICE > 2 AND P_QOH < 8 AND P_INDATE > 2013-09-05


--f: Repeat the above question (part e) using a subquery.
SELECT V.V_CODE,V.V_NAME 
FROM VENDOR V
WHERE V.V_CODE IN( SELECT V.V_CODE 
					FROM  PRODUCT P 
					WHERE V.V_CODE= P.V_CODE AND P_PRICE > 2 AND P_QOH < 8 AND P_INDATE > 2013-09-05)

--g: Repeat the above question (part e) using a correlated subquery.

SELECT V.V_CODE,V.V_NAME 
FROM VENDOR V 
WHERE EXISTS( SELECT P.V_CODE 
				FROM PRODUCT P  
				WHERE V.V_CODE=P.V_CODE AND P_PRICE > 2 AND P_QOH < 8 AND P_INDATE > 2013-09-05)


--A
CREATE TABLE EMP_1 (
EMP_NUM INT NOT NULL, 
EMP_LNAME VARCHAR(40),
EMP_FNAME VARCHAR(40),
EMP_INITIAL CHAR(2),
EMP_HIREDATE DATE
)

ALTER TABLE EMP_1
ADD CONSTRAINT PK_EMP_1 PRIMARY KEY(EMP_NUM)

INSERT INTO EMP_1 VALUES (101,'News', 'John', 'G', '08-09-2000')
INSERT INTO EMP_1 VALUES(102,'Senior', 'David', 'H', '12-07-1989')

select * into COPYEMP_2 from EMP_1

ALTER TABLE COPYEMP_2
ADD PROJ_NUM CHAR(10)

UPDATE COPYEMP_2 
SET EMP_NUM = 4
WHERE EMP_NUM = 101


CREATE TABLE CUSTOMER1 (

CustomerID INT not null,
CustomerName VARCHAR (40),
CustomerDOB DATE

);

ALTER TABLE CUSTOMER1
ADD CONSTRAINT PK_CUSTOMER1 PRIMARY KEY (CustomerID)

CREATE TABLE AGENT (

AgentID INT NOT NULL,
AgentName VARCHAR(40)

);

ALTER TABLE AGENT
ADD CONSTRAINT PK_AGENT PRIMARY KEY (AgentID)

CREATE TABLE ASSIGNMENT1(

CustomerID INT NOT NULL,
AgentID INT NOT NULL,
AssignmentDate DATE,
YearlyCost decimal(10,2)

);

ALTER TABLE ASSIGNMENT1
ADD CONSTRAINT PK_ASSIGNMENT1_CUSTOMER_AGENT PRIMARY KEY(CustomerID, AgentID),
	CONSTRAINT FK_ASSIGNMENT1_CUSTOMER FOREIGN KEY (CustomerID) REFERENCES CUSTOMER1 (CustomerID),
	CONSTRAINT FK_ASSIGNMENT1_AGENT FOREIGN KEY (AgentID) REFERENCES AGENT (AgentID)

--Q5

--a. List the names of all sites not visited by any tours during July 2012. Use a NOT EXISTS construct.
SELECT S.Site_Name
	FROM site S 
	WHERE NOT EXISTS ( SELECT *
						FROM tour T 
						WHERE S.Site_ID = T.Site_ID
						AND T.Tour_Date BETWEEN '2012-07-01' AND '2012-07-30')


--b. List the name of each participant who has made a reservation on a tour to a site visibility greater than 90 and the site name contains "NT". Include in the output the name of the site and its visibility.
SELECT Part_Fname, Part_Lname, Site_Name, Site_Visibility
FROM participant P
	INNER JOIN partres PA ON P.Part_ID = PA.Part_ID
	INNER JOIN reservation R ON PA.Res_ID = R.Res_ID
	INNER JOIN tour T ON R.Tour_ID = T.Tour_ID
	INNER JOIN site S ON T.Site_ID = S.Site_ID
WHERE Site_Visibility > 90 AND Site_Name LIKE '%NT%'


--c. Create a view that shows for each tour the total number of participants in that tour.
CREATE VIEW TOUR_SIZE
AS 

SELECT T.TOUR_ID, S.Site_ID, S.Site_Name, COUNT(P.PART_ID) 'NUM OF PARTCIPANTS'
FROM SITE S
	JOIN tour T ON S.Site_ID = T.Site_ID
	JOIN reservation R ON T.Tour_ID = R.Tour_ID
	JOIN partres PA ON R.Res_ID = PA.Res_ID
	JOIN participant P ON PA.Part_ID = P.Part_ID
GROUP BY T.TOUR_ID, S.Site_ID, S.Site_Name


SELECT * FROM TOUR_SIZE


--d. List the tour date, site name, and participants' first name. Participants' first name should contain "N" and site name start with "H" and have a total of less than $100 in reservation gear cost.
SELECT T.Tour_Date, S.Site_Name, Part_Fname
FROM SITE S
	JOIN tour T ON S.Site_ID = T.Site_ID
	JOIN reservation R ON T.Tour_ID = R.Tour_ID
	JOIN partres PA ON R.Res_ID = PA.Res_ID
	JOIN participant P ON PA.Part_ID = P.Part_ID
WHERE Part_Fname LIKE '%N%' AND Site_Name LIKE '%H%' AND Res_GearCost < 100

--e. List the tour date, departure time, and site name for each tour with more than three participants.
SELECT T.Tour_Date, Tour_DepartureTime, Site_Name
FROM SITE S
	JOIN tour T ON S.Site_ID = T.Site_ID
	JOIN reservation R ON T.Tour_ID = R.Tour_ID
	JOIN partres PA ON R.Res_ID = PA.Res_ID
	JOIN participant P ON PA.Part_ID = P.Part_ID
GROUP BY T.Tour_Date, Tour_DepartureTime, Site_Name
HAVING COUNT(P.PART_ID) > 3
