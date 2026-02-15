--Assignment_4
--Ugochukwu Achara

--Individual Assignment

--1	Write the SQL code to create the table structures for the entities shown in Figure P8.47. The structures should contain the attributes specified in the ERD. Use data types appropriate for the data that will need to be stored in each attribute. Enforce primary key and foreign key constraints as indicated by the ERD. (25 POINTS)
--DONE IN CLASS

--2 Write the SQL command to change the movie year for movie number 1245 to 2018. (5 POINTS)
--SELECT * FROM MOVIE

UPDATE MOVIE
SET MOVIE_YEAR = 2018
WHERE MOVIE_NUM = 1245

--3 Write the SQL command to change the price code for all action movies to price code 3. (5 POINTS)
--SELECT * FROM PRICE
--SELECT * FROM MOVIE

UPDATE MOVIE
SET PRICE_CODE = 3
WHERE PRICE_CODE IN (SELECT PRICE_CODE 
						FROM MOVIE 
						WHERE MOVIE_GENRE = 'ACTION')

--4- Write a single SQL command to increase all price rental fee values in the PRICE table by $0.50. (5 POINTS)
--SELECT * FROM PRICE

UPDATE PRICE
SET PRICE_RENTFEE = PRICE_RENTFEE + 0.50

--5. Alter the DETAILRENTAL table to include a derived attribute named DETAIL_DAYSLATE to store integers of up to three digits. The attribute should accept null values. (5 POINTS)

ALTER TABLE DETAILRENTAL
ADD DETAIL_DAYSLATE INT
	CONSTRAINT CHK_DDAYLATE CHECK (DETAIL_DAYSLATE BETWEEN 0 AND 999)


--6- Alter the VIDEO table to include an attribute named VID_STATUS to store character data up to four characters long. 
--The attribute should have a constraint to enforce the domain (“IN,” “OUT,” and “LOST”) and have a default value of “IN.” (5 POINTS)
ALTER TABLE VIDEO 
ADD VID_STATUS CHAR(4), 
	CONSTRAINT DF_VID_STATUS DEFAULT 'IN' FOR VID_STATUS,
    CHECK (VID_STATUS IN ('IN', 'OUT', 'LOST'));

--7. Update the VID_STATUS attribute of the VIDEO table using a subquery to set the VID_STATUS to “OUT” for all videos that have a null value in the DETAIL_RETURNDATE attribute of the DETAILRENTAL table. (5 POINTS)
--select * from video 
--select * from DETAILRENTAL


UPDATE VIDEO
SET VID_STATUS = 'OUT'
WHERE VID_NUM IN (SELECT VID_NUM 
					FROM DETAILRENTAL 
					WHERE DETAIL_RETURNDATE IS NULL)

--8.  Update the PRICE table to place the values shown in the following table in the PRICE_ DAILYLATEFEE attribute. (5 POINTS)
--PRICE_CODE	PRICE_DAILYLATEFEE
--1	5
--2	3
--3	5
--4	7

--SELECT * FROM PRICE 

UPDATE PRICE
SET PRICE_DAILYLATEFEE =5
WHERE PRICE_CODE = 1

UPDATE PRICE
SET PRICE_DAILYLATEFEE =3
WHERE PRICE_CODE = 2

UPDATE PRICE
SET PRICE_DAILYLATEFEE =5
WHERE PRICE_CODE = 3

UPDATE PRICE
SET PRICE_DAILYLATEFEE =7
WHERE PRICE_CODE = 4




