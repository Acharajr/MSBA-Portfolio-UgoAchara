
-- 1 Create EMPLOYEE_1 table based on the provided instructions:
CREATE TABLE EMPLOYEE_1 (
EMP_NUM       INT NOT NULL,
EMP_LNAME      VARCHAR(15) NOT NULL,
EMP_FNAME      VARCHAR(15) NOT NULL,
EMP_INITIAL    VARCHAR(1),
EMP_HIREDATE   DATE NOT NULL

)

ALTER TABLE EMPLOYEE_1
ADD CONSTRAINT PK_EMPLOYEE_1 PRIMARY KEY (EMP_NUM)


--SELECT * FROM EMPLOYEE_1
--DROP TABLE EMPLOYEE_1
-- 2 Insert the first two rows into EMPLOYEE_1 Table
INSERT INTO EMPLOYEE_1 VALUES ('101', 'News', 'John', 'G', '2000-11-08');

--OR
INSERT INTO EMPLOYEE_1 (EMP_NUM ,EMP_LNAME,EMP_FNAME,EMP_INITIAL,EMP_HIREDATE)
VALUES ('102', 'Senior', 'David', 'H', '1989-07-12');

--INSERT INTO EMPLOYEE_1 VALUES ('102', 'Senior', 'David', 'H', '1989-07-12'); 


--CREATE THE ATBLE WITH THE COPY OF YOUR EXISTING TABLE
--Copy everything from customer to new table called TEMPCUSTOMER


SELECT * INTO TEMPCUSTOMER
FROM CUSTOMER

SELECT * FROM TEMPCUSTOMER


--Add a column into TEMPCUSTOMER; assignt integer as the data type
ALTER TABLE TEMPCUSTOMER
ADD NEWCOLUMN INT

--SELECT * FROM TEMPCUSTOMER

--Update the value for newcolumn=55 in TEMPCUSTOMER for cus_code=10019
UPDATE TEMPCUSTOMER
SET NEWCOLUMN=55
where cus_code=10019
--SELECT * FROM TEMPCUSTOMER

--Update the last name of a customer to "Hatami" in the TEMPCUSTOMER table where the value in the NEWCOLUMN is 55

UPDATE TEMPCUSTOMER

SET CUS_LNAME='Hatami'

WHERE NEWCOLUMN=55 

--SELECT * FROM TEMPCUSTOMER


--Delete from TEMPCUSTOMER  when CUS_CODE=10019
DELETE FROM TEMPCUSTOMER

WHERE CUS_CODE='10019'


--DROP COLUMN NEWCOLUMN
ALTER TABLE TEMPCUSTOMER
DROP COLUMN NEWCOLUMN 
--SELECT * FROM TEMPCUSTOMER

--Creat new column in TEMPCUSTOMER call it NEWCOLUMN2 and update the column based on following information: 
--if customer has invoice add 1 and if he/she doesn't , add zero.
--Add column to TEMPCUSTOMER
ALTER TABLE TEMPCUSTOMER
ADD   NEWCOLUMN2  INT
--SELECT * FROM TEMPCUSTOMER
--SELECT CUS_CODE FROM INVOICE
UPDATE TEMPCUSTOMER
SET NEWCOLUMN2=1
WHERE  CUS_CODE IN (SELECT CUS_CODE FROM INVOICE)

UPDATE TEMPCUSTOMER
SET NEWCOLUMN2=0
WHERE CUS_CODE NOT IN (SELECT CUS_CODE FROM INVOICE)

--SELECT * FROM TEMPCUSTOMER


--Delete TABLE TEMPCUSTOMER
DELETE  TEMPCUSTOMER
--SELECT * FROM TEMPCUSTOMER

--DROP table
--Drop Table TEMPCUSTOMER

DROP TABLE TEMPCUSTOMER
--SELECT * FROM TEMPCUSTOMER

--SQL Practice Questions: Property Management Database
--1.Insert the following information into OWNER table 
--OWNER_NUM,   LAST_NAME,  FIRST_NAME,  ADDRESS,           CITY,    STATE, ZIP_CODE
--YO110,          Jones,     Tina,       123 Sunset Blvd, Boise, ID, 83702
--SELECT* FROM OWNER

INSERT INTO OWNER VALUES ('YO110', 'Jones', 'Tina', '123 Sunset Blvd', 'Boise', 'ID', '83702')
--OR
INSERT INTO OWNER (OWNER_NUM, LAST_NAME, FIRST_NAME, ADDRESS, CITY, STATE, ZIP_CODE)
VALUES ('YO110', 'Jones', 'Tina', '123 Sunset Blvd', 'Boise', 'ID', '83702');
DELETE FROM OWNER 
WHERE OWNER_NUM='YO110'


--2. Insert the following information into OFFICE table 
--OFFICE_NUM, OFFICE_NAME, CITY, STATE
--200, Uptown Office, San Diego, CA
--SELECT* FROM OFFICE
INSERT INTO OFFICE VALUES(200, 'Uptown Office','500 W 135Th Ave ','WEST', 'San Diego', 'CA','56754')

--If you list the attributes following with insert values, if you missed a value in your insert statment, the "NULL" value 
--will be added instead in the table

INSERT INTO OFFICE (OFFICE_NUM, OFFICE_NAME, CITY, STATE)
VALUES (2000, 'Uptown Office', 'San Diego', 'CA');

--ERROR HERE
INSERT INTO OFFICE Values(20, 'Uptown Office', 'San Diego', 'CA');

--DELETE  OFFICE
--3. Update the monthly rent of a  property 12 and make it as 1850.$.

--SELECT* FROM PROPERTY
UPDATE PROPERTY
SET MONTHLY_RENT = 1850.00
WHERE PROPERTY_ID=12

--4. Delete a row from the OWNER table where owner number is Y0110.
--SELECT* FROM OWNER
DELETE FROM OWNER
WHERE OWNER_NUM = 'YO110';
--5. Add a new column email addresses in the RESIDENTS table.
--SELECT* FROM RESIDENTS
ALTER TABLE RESIDENTS
ADD EMAIL VARCHAR(100);
--6. Remove the AREA column from the OFFICE table.
--SELECT* FROM OFFICE
ALTER TABLE OFFICE
DROP COLUMN AREA;

--7. Add a default value equal 1 for the FLOORS column in the PROPERTY table.
--SELECT* FROM PROPERTY 
ALTER TABLE PROPERTY
ADD CONSTRAINT DF_Floors DEFAULT (1) FOR FLOORS;

INSERT INTO PROPERTY  VALUES ('2233', '1', '716 Ocean st', '2300', '2',DEFAULT ,1650.00,'RE107');

INSERT INTO PROPERTY (  PROPERTY_ID,OFFICE_NUM,ADDRESS, SQR_FT , BDRMS, MONTHLY_RENT,OWNER_NUM )
VALUES ('2003', '2', '456 Ocean Ave', '1200', '2', 1600.00,'RE107');

--Will add zero if you have value as ,'',

INSERT INTO PROPERTY VALUES('2004', '2', '456 Ocean Ave', '1200', '2','', 1600.00,'RE107');
--will add NULL if you add NULL as a value
INSERT INTO PROPERTY VALUES('2064', '2', '456 Ocean Ave', '1200', '2',NULL, 1600.00,'RE107');

--ALTER TABLE PROPERTY
--DROP CONSTRAINT DF_Floors;

--8. Create a Copy of the OWNER table named OWNER_BACKUP.
SELECT *
INTO OWNER_BACKUP
FROM OWNER;
--9. Insert a new service request with the following details: Service ID 10, Property ID 10, Category number 6, Office number 1
--Description "Leaking in the master bedroom", Status "open", Estimated Hours 4.00, Spent Hours 1.00, and Request Date '2019-11-03'?=.
--SELECT* FROM SERVICE_REQUEST
INSERT INTO SERVICE_REQUEST VALUES (10,10, 6, 1,'Leaking in the master bedroom','open', 4.00, 1.00, '2019-11-03');

SELECT * FROM SERVICE_REQUEST

--10. Update an owner's address of the owner with OWNER_NUM 'RE107' to "100 New Way Rd." in the city of Tacoma, 
--state of Washington, with ZIP code 98403?

SELECT * FROM OWNER 

UPDATE OWNER
SET ADDRESS = '100 New Way Rd.', CITY = 'Tacoma', STATE = 'WA', ZIP_CODE = '98403'
WHERE OWNER_NUM = 'RE107';

--11. Insert a new resident into the RESIDENTS table with Resident ID 301, Last Name "Alex", First Name "Reed", and Property ID 12?

INSERT INTO RESIDENTS (RESIDENT_ID,  LAST_NAME,FIRST_NAME, PROPERTY_ID)
VALUES (301, 'Alex', 'Reed',12);

--12. Add a new column to track lease end dates in the RESIDENTS table.

--SELECT* FROM RESIDENTS
ALTER TABLE RESIDENTS
ADD LEASE_END_DATE DATE;

--13. Change the office name of office number 200 to 'Downtown Hub'.
UPDATE OFFICE
SET OFFICE_NAME = 'Downtown Hub'
WHERE OFFICE_NUM = 200;
--14. Delete the RESIDENT with RESIDENT_ID 301.
DELETE FROM RESIDENTS
WHERE RESIDENT_ID = 301;

--DELETE ALL DATA  FROM RESIDENTS
DELETE FROM RESIDENTS

--15. Create a new table OFICE_COPY that copies the structure of OFFICE.
--SELECT * FROM OFFICE_COPY
SELECT *
INTO OFFICE_COPY
FROM OFFICE
--DROP TABLE OFFICE_COPY


--Insert a row into Owner table with the following details: Owner Number 'WO200', Last Name 'Sgoore', First Name 'Sara', 
--Address '8006 W. Newport Ave.', City 'Sacramento', State 'CA', and ZIP Code '89508'

INSERT INTO OWNER VALUES('WO200','Sgoore','Sara','8006 W. Newport Ave.','Sacramento','CA','89508');

--Create copy of Owner table


Select * into OwnerCopy
from OWNER

--Test OwnerCopy
SELECT * FROM OwnerCopy

--UPDATE the first name of the owner with OWNER_NUM 'RE107' to "Maddy" in the OwnerCopy table?

UPDATE OwnerCopy
SET FIRST_NAME='Maddy'
Where OWNER_NUM='RE107'

--Add new Colum called NEWCOLUMN in OwnerCopy; Assign integer as its datatype
ALTER TABLE OWNERCOPY
ADD NEWCOLUMN INT

----Stored Procedure

CREATE PROCEDURE SELECTCUSTOMER 
AS
SELECT * FROM CUSTOMER

EXECUTE SELECTCUSTOMER


--DROP PROCEDURE SELECTCUSTOMER




--Create procedure for finding vendors
SELECT * FROM PRODUCT

CREATE PROCEDURE SELECTVENDOR @V_CODE INT
AS
SELECT * FROM PRODUCT WHERE V_CODE=@V_CODE

EXECUTE SELECTVENDOR @V_CODE=21344

DROP PROCEDURE SELECTVENDOR



--Add a stored procedure named SP_ADD_VENDOR to insert the new rows in the vendor table. The procedure need to add this values into Vendor table:
--15876,Brian,Steven,402,4024356,NE,Y
--DROP PROCEDURE SP_ADD_VENDOR
CREATE PROCEDURE SP_ADD_VENDOR
@V_CODE INT,
@V_NAME VARCHAR(50),
@V_CONTACT CHAR(10),
@V_AREACODE CHAR(10),
@V_PHONE INT,
@V_STATE CHAR(10),
@V_ORDER CHAR(10)

AS
INSERT INTO VENDOR(V_CODE,V_NAME, V_CONTACT,V_AREACODE,V_PHONE,V_STATE,V_ORDER)
VALUES (@V_CODE,@V_NAME,@V_CONTACT,@V_AREACODE,@V_PHONE,@V_STATE,@V_ORDER)


EXECUTE SP_ADD_VENDOR'15878','Brian','Steven','402','4024356','NE','Y'

--OR

--CREATE PROCEDURE SP_ADD_VENDOR
--AS
--INSERT INTO VENDOR VALUES (15876,'Brian','Steven','402','4024356','NE','Y' );


--EXECUTE SP_ADD_VENDOR

--SELECT * FROM VENDOR

--DELETE FROM VENDOR
--WHERE V_CODE='15876'
--DROP PROCEDURE SP_ADD_VENDOR
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TRIGGERS
SELECT * FROM PRODUCT
ORDER BY P_CODE

CREATE TRIGGER NEWPRODUCT

ON PRODUCT 
AFTER INSERT AS

UPDATE PRODUCT
SET PRODUCT.P_PRICE=PRODUCT.P_PRICE+50
FROM inserted
WHERE PRODUCT.V_CODE=inserted.V_CODE

INSERT INTO PRODUCT VALUES('WR4/TT4','PowerBI','2013-05-27','20','35','500','0','25595')

--DROP TRIGGER NEWPRODUCT
--DELETE FROM PRODUCT WHERE P_CODE='67-DD'


--Write the trigger which send the message " NOT ALLOWED" for deleting invoice number in invoice table
CREATE TRIGGER SETINVOICE
ON INVOICE 

INSTEAD OF DELETE
AS
BEGIN 
SELECT 'NOT ALLOWED'AS [MESSAGE]
END

DELETE FROM INVOICE WHERE INV_NUMBER=1002
DELETE FROM INVOICE WHERE CUS_CODE=1008

SELECT * FROM INVOICE



--DROP TRIGGER SETINVOICE

SELECT * FROM VENDOR

CREATE TRIGGER UPDATINGVENDOR
ON VENDOR
INSTEAD OF UPDATE

AS

BEGIN
IF(UPDATE (V_NAME))
BEGIN
UPDATE VENDOR SET V_NAME=inserted.V_NAME 
FROM inserted 
WHERE
VENDOR.V_CODE=inserted.V_CODE

END

IF (UPDATE (V_CODE))

BEGIN

SELECT 'Not Allowed' as [Message]
END
END
--DROP TRIGGER UPDATINGVENDOR

UPDATE VENDOR
SET V_NAME='Zara' WHERE V_CODE='23119'

UPDATE VENDOR
SET V_CODE='35768' WHERE V_CODE='21225'

--DROP TRIGGER SETINVOICE









