--1-    List the first and last names, number of tours, and addresses (city and state) of all participants who 
--      have registered for more than three tours.
SELECT Part_Fname, Part_Lname, COUNT(R.Res_ID) 'NUMBER OF TOURS', Part_City, Part_State
FROM participant P
JOIN partres PA ON P.Part_ID = PA.Part_ID
JOIN reservation R ON PA.Res_ID = R.Res_ID
GROUP BY Part_Fname,Part_Lname,Part_City, Part_State
HAVING COUNT(R.Res_ID) > 3

--2-	List the date and departure time for all tours that go to the 'Golden X' wreck.   Use a subquery.
SELECT S.Site_Name, Tour_Date, Tour_DepartureTime
FROM tour T
JOIN site S ON T.Site_ID = S.Site_ID
WHERE S.Site_Name IN (SELECT Site_Name 
                        FROM site 
                        WHERE S.Site_Name = 'GOLDEN X')

--3-	For each reservation, list the reservation_id, reservation date, the tour date, the participant cost (Res_PartCost) 
-- and the gear cost (Res_GearCost).
--Note: Only include reservations that have a non-null value for Res_GearCost.

SELECT Res_ID, Res_Date, Tour_Date, Res_PartCost, Res_GearCost
FROM reservation R
JOIN tour T ON R.Tour_ID = T.Tour_ID
WHERE Res_GearCost IS NOT NULL 

--4-	List all tours scheduled for July, 2012 and the date of all reservations for that tour. #ASK ABOUT THIS 
--Include all tours, including those without any reservations.

SELECT S.Site_Name, Tour_Date, Res_Date
FROM TOUR T
LEFT JOIN reservation R ON T.Tour_ID = R.Tour_ID
JOIN site S ON T.Site_ID = S.Site_ID
WHERE Tour_Date BETWEEN '2012-07-01' AND '2012-07-31'

--5-	List the tour id, departure date and time for all tours whose participants are NOT from Nebraska (state code = NE).   Use a NOT EXISTS construct.
SELECT T.Tour_ID, Tour_Date,Tour_DepartureTime
FROM tour T
WHERE NOT EXISTS (SELECT *
                  FROM participant P
                  JOIN partres PA ON PA.Part_ID = P.Part_ID
                  JOIN reservation R ON R.Res_ID = PA.Res_ID
                  JOIN Tour ON T.Tour_ID = R.Tour_ID
                  WHERE P.Part_State = 'NE')

SELECT * FROM participant 
--6-	List the names and capacity of all boats that have been used on tours to a site in the 'Giant Kelp Forests'.  Use nested subqueries.
--why does this join function produce three results and the nested subqueiries only two
SELECT B.Boat_Name, B.Boat_Capacity
FROM boat B
WHERE B.boat_id IN (
    SELECT T.Boat_ID
    FROM Tour T
    WHERE T.Site_ID IN (
        SELECT S.Site_ID
        FROM site S
        WHERE S.Site_Area = 'Giant Kelp Forests'
       ))

--7- List the name of each site, the base cost, and a description of the cost.  If the cost is < $25, the cost is 'inexpensive'.  
--If the cost is $25-40, the cost is 'moderate'.  If the cost is > 40, the cost is 'expensive'.

SELECT Site_Name, Site_BaseCost,
CASE 
    WHEN Site_basecost < 25 
    THEN 'inexpensive'
    WHEN site_basecost BETWEEN 25 AND 40 
    THEN 'moderate'
    WHEN site_basecost > 40 
    THEN 'expensive'

    END COST_DESCRIPT
    FROM site S

--8-	For each boat, list the boat name, and the tour_id, date and departure time of the most recent tour to use that boat.
SELECT B.Boat_Name, Tour_ID, T.Tour_Date,Tour_DepartureTime
FROM boat B
JOIN tour T ON B.Boat_ID = T.Boat_ID
WHERE T.Tour_Date = (SELECT MAX(t.Tour_Date) 
                        FROM tour t
                        WHERE t.Boat_ID = B.Boat_ID)

--9-	List the first and last name of each participant who has made a reservation on a tour to a site at over 95 ft depth.
--Include in the output the name of the site and its depth.
SELECT Part_Fname, Part_Lname, Site_Name, Site_Depth
FROM participant P
INNER JOIN partres PA ON P.Part_ID = PA.Part_ID
INNER JOIN reservation R ON PA.Res_ID = R.Res_ID
INNER JOIN tour T ON R.Tour_ID = T.Tour_ID
INNER JOIN site S ON T.Site_ID = S.Site_ID
WHERE Site_Depth > 95
 
--10-	List the site, departure date, and boat name for each tour to a site in 'Wreck Alley'.  Include all tours,
--including those that have not yet been assigned a boat.
SELECT Site_Name, Tour_DepartureTime, Boat_Name
FROM site S
LEFT JOIN tour T ON T.Site_ID = S.Site_ID
LEFT JOIN boat B ON T.Boat_ID = B.Boat_ID
WHERE Site_Area = 'WRECK ALLEY'

--11-	List the first and last names of all participants who have registered for a tour to the 'Golden X' wreck.  Use nested subqueries.
SELECT Part_Fname, Part_Lname
FROM participant P
WHERE P.Part_ID IN (
           SELECT PA.PART_ID
            FROM partres PA
            WHERE PA.Res_ID IN (
               SELECT R.RES_ID
                FROM reservation R
                WHERE R.Tour_ID IN (
                   SELECT T.Tour_ID
                    FROM tour T
                    WHERE T.Site_ID IN (
                       SELECT S.Site_ID
                        FROM site S
                        WHERE S.Site_Name = 'Golden X'
                        ))))

--12-	List the names of sites visited by more than two large tours.  A large tour is defined as a tour with more than 10 participants.  
-- Include in the output the number of large tours.
CREATE VIEW LARGETOUR
AS 

SELECT T.TOUR_ID, S.Site_ID, S.Site_Name, COUNT(P.PART_ID) 'NUM OF PARTCIPANTS'
FROM SITE S
JOIN tour T ON S.Site_ID = T.Site_ID
JOIN reservation R ON T.Tour_ID = R.Tour_ID
JOIN partres PA ON R.Res_ID = PA.Res_ID
JOIN participant P ON PA.Part_ID = P.Part_ID
GROUP BY T.TOUR_ID, S.Site_ID, S.Site_Name
HAVING COUNT(P.PART_ID) > 10

SELECT * FROM LARGETOUR

SELECT LT.Site_Name, COUNT(LT.TOUR_ID) 'NUM OF LARGE TOURS'
FROM LARGETOUR LT
GROUP BY LT.Site_Name
HAVING COUNT(LT.TOUR_ID) > 2
