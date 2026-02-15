
-- 1 Create EMPLOYEE_1 table based on the provided instructions:
CREATE TABLE EMPLOYEE1 (
EMP_NUM INT NOT NULL,
EMP_LNAME VARCHAR(30) NOT NULL,
EMP_FNAME VARCHAR(30)NOT NULL,
EMP_INITIAL CHAR(2),
EMP_HIREDATE DATE NOT NULL
);

ALTER TABLE EMPLOYEE1
ADD CONSTRAINT PK_EMPLOYEE1 PRIMARY KEY(EMP_NUM)

SELECT * FROM EMPLOYEE1

-- 2 Insert the first two rows into EMPLOYEE_1 Table

 INSERT INTO EMPLOYEE1 VALUES (101, 'NEWS', 'JOHN', 'G', '2000-11-08')
--OR


--CREATE THE TABLE WITH THE COPY OF YOUR EXISTING TABLE
--Copy everything from customer to new table called TEMPCUSTOMER

SELECT * INTO TEMPCUSTOOMER FROM CUSTOMER 

--Add a column into TEMPCUSTOMER; assignt integer as the data type

ALTER TABLE TEMPCUSTOOMER 
ADD NEWCOLUMN INT


--Update the value for newcolumn=55 in TEMPCUSTOMER for cus_code=10019
UPDATE TEMPCUSTOOMER
SET NEWCOLUMN = 55
WHERE CUS_CODE = 10010

--Update the last name of a customer to "Hatami" in the TEMPCUSTOMER table where the value in the NEWCOLUMN is 55

UPDATE TEMPCUSTOOMER
SET CUS_LNAME = 'Achara'
WHERE NEWCOLUMN = 55


--Delete from TEMPCUSTOMER  when CUS_CODE=10019
DELETE FROM TEMPCUSTOOMER
WHERE CUS_CODE = 10019


--DROP COLUMN NEWCOLUMN
ALTER TABLE TEMPCUSTOOMER
DROP COLUMN NEWCOLUMN


--Creat new column in TEMPCUSTOMER call it NEWCOLUMN2 and update the column based on following information: 
--if customer has invoice add 1 and if he/she doesn't , add zero.


--ALTER TABLE TEMPCUSTOOMER
--DROP COLUMN NEWCOLUMN2

--DROP TABLE TEMPCUSTOOMER
ALTER TABLE TEMPCUSTOOMER
ADD NEWCOLUMN2 INT

--SELECT * FROM TEMPCUSTOOMER

UPDATE TEMPCUSTOOMER
SET NEWCOLUMN2 = 1
WHERE CUS_CODE IN (SELECT CUS_CODE FROM INVOICE)

UPDATE TEMPCUSTOOMER
SET NEWCOLUMN2 = 0
WHERE CUS_CODE NOT IN (SELECT CUS_CODE FROM INVOICE)

SELECT * FROM TEMPCUSTOOMER



--Delete TABLE TEMPCUSTOMER
DELETE TEMPCUSTOOMER


--DROP table
DROP TEMPCUSTOOMER 




--SQL Practice Questions: Property Management Database
--1.Insert the following information into OWNER table 
--OWNER_NUM,   LAST_NAME,  FIRST_NAME,  ADDRESS,           CITY,    STATE, ZIP_CODE
--YO110,          Jones,     Tina,    123 Sunset Blvd,       Boise,   ID,    83702
--SELECT* FROM OWNER

INSERT INTO OWNER VALUES('YO110', 'Jones', 'Tina', '123 Sunset Blvd', 'Boise',' ID', '83702')

--OR

--2. Insert the following information into OFFICE table 
--OFFICE_NUM, OFFICE_NAME, CITY, STATE
--200, Uptown Office, San Diego, CA
SELECT * FROM OFFICE 

INSERT INTO OFFICE (OFFICE_NUM, OFFICE_NAME, CITY, STATE) 
VALUES ('200','Uptown Office', 'San Diego', 'CA')


--3. Update the monthly rent of a  property 12 and make it as 1850.$.
SELECT * FROM PROPERTY

UPDATE PROPERTY
SET MONTHLY_RENT = 1850
WHERE PROPERTY_ID = 12


--4. Delete a row from the OWNER table where owner number is Y0110.
SELECT * FROM OWNER 
DELETE FROM OWNER
WHERE OWNER_NUM = 'YO110'

--5. Add a new column email addresses in the RESIDENTS table.
ALTER TABLE RESIDENTS
ADD EMAIL_ADDRESS VARCHAR(30)

--6. Remove the AREA column from the OFFICE table.
SELECT * FROM OFFICE 

ALTER TABLE OFFICE
DROP COLUMN AREA


--7. Add a default value equal 1 for the FLOORS column in the PROPERTY table.




--Droping default Constraint


--8. Create a Copy of the OWNER table named OWNER_BACKUP.

--9. Insert a new service request with the following details: Service ID 10, Property ID 10, Category number 6, Office number 1
--Description "Leaking in the master bedroom", Status "open", Estimated Hours 4.00, Spent Hours 1.00, and Request Date '2019-11-03'?=.





--10. Update an owner's address of the owner with OWNER_NUM 'RE107' to "100 New Way Rd." in the city of Tacoma, 
--state of Washington, with ZIP code 98403?


--11. Insert a new resident into the RESIDENTS table with Resident ID 301, Last Name "Alex", First Name "Reed", and Property ID 12?


--12. Add a new column to track lease end dates in the RESIDENTS table.



--13. Change the office name of office number 200 to 'Downtown Hub'.

--14. Delete the RESIDENT with RESIDENT_ID 301.


--DELETE ALL DATA  FROM RESIDENTS


--15. Create a new table OFICE_COPY that copies the structure of OFFICE.

--DROP TABLE OFFICE_COPY


--Insert a row into Owner table with the following details: Owner Number 'WO200', Last Name 'Sgoore', First Name 'Sara', 
--Address '8006 W. Newport Ave.', City 'Sacramento', State 'CA', and ZIP Code '89508'



--Create copy of Owner table



--Test OwnerCopy


--UPDATE the first name of the owner with OWNER_NUM 'RE107' to "Maddy" in the OwnerCopy table?



--Add new Colum called NEWCOLUMN in OwnerCopy; Assign integer as its datatype


----Stored Procedure




--DROP PROCEDURE SELECTCUSTOMER




--Create procedure for finding vendors



--Add a stored procedure named SP_ADD_VENDOR to insert the new rows in the vendor table. The procedure need to add this values into Vendor table:
--15876,Brian,Steven,402,4024356,NE,Y
--DROP PROCEDURE SP_ADD_VENDOR



--OR





---------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TRIGGERS



--DROP TRIGGER NEWPRODUCT
--DELETE FROM PRODUCT WHERE P_CODE='67-DD'


--Write the trigger which send the message " NOT ALLOWED" for deleting invoice number in invoice table





--DROP TRIGGER SETINVOICE









