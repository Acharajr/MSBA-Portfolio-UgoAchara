--Assignment_2
-- Ugochukwu Achara

--1-	List the first and last name, city, and state of each participant.
SELECT Part_Fname, Part_Lname, Part_City, Part_State
	FROM participant

--2-	List the names of all sites that are located in the 'Cozumel Reef'.
SELECT Site_Area, Site_Name
	FROM site
	WHERE Site_Area LIKE '%Cozumel Reef%'

--3-	List the name and base cost of each site with a base cost of less than $40. and a principal interest contain 'Marine'.
SELECT Site_Name, Site_BaseCost
	FROM SITE
	WHERE Site_BaseCost < 40 AND Site_Interest LIKE '%Marine%'

--4-	List the minimum, maximum, and average depth of sites in 'Wreck Alley'.
SELECT site_Area, min(site_depth) AS 'Min_site_depth', max(site_depth) AS 'Max_site_depth', AVG(site_depth) AS 'AVG_site_depth'
	FROM site
	WHERE Site_Area LIKE '%Wreck Alley%'
	GROUP BY Site_Area


--5-	List the total number of sites at each skill level.
SELECT Site_SkillLevel, COUNT(site_skilllevel) 'Total number of site at each skill level'
	FROM site
	Group by Site_SkillLevel

--6-	List the name and depth of the site with the greatest depth.  
SELECT Site_Name, Site_Depth
	FROM site
	WHERE Site_Depth = (SELECT MAX(site_depth) FROM site);


--7- List the names and base cost of all sites not visited by any tours during June, 2012.  Use a NOT EXISTS construct.
SELECT S.Site_Name, S.Site_BaseCost
	FROM site S 
	WHERE NOT EXISTS ( SELECT *
						FROM tour T 
						WHERE S.Site_ID = T.Site_ID
						AND T.Tour_Date BETWEEN '2012-06-01' AND '2012-06-30')
	

--8-	List the name of each site with an 'Experienced' skill level but with a 'Mild' current.

SELECT Site_Name, Site_SkillLevel, Site_Current
	FROM site 
	WHERE Site_SkillLevel like '%Experienced%' and Site_Current like '%Mild%'

--9-	List the names of the sites and base cost that have an above-average base cost.

SELECT Site_Name, Site_BaseCost
	FROM site
	WHERE SITE_BASECOST > (SELECT AVG(SITE_BASECOST) FROM SITE)

--10-	List the name and site area  of all sites to which no tours were scheduled in July, 2014 and site current is 'Mild'.  
SELECT S.site_name, S.site_area, S.Site_Current
	FROM site S
	WHERE S.site_current = 'Mild'
	AND NOT EXISTS (
        SELECT *
        FROM tour t
        JOIN reservation R ON T.tour_id = R.tour_id
        WHERE T.site_id = S.site_id
          AND R.res_date BETWEEN '2014-07-01' AND '2014-07-31'
  );
