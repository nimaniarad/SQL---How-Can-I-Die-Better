SELECT Year,State, SUM(CAST((GunDeathByYear.KilledbyGun) as int)) as TotalDeath
FROM GunDeathByYear
WHERE Year = 2017 OR Year = 2018 OR Year = 2019
GROUP BY State, Year
ORDER BY TotalDeath DESC

--- Texas at the Top - Three Years in a Row!  

SELECT Year,State, SUM(CONVERT(int,MassShootings.KilledByMassShooting)) as TotalDeath
FROM MassShootings
WHERE Year = 2017 OR Year = 2018 OR Year = 2019
GROUP BY State, Year
ORDER BY TotalDeath DESC

--- Texas at Top Again! 

SELECT Year,State, SUM(CAST((AccidentMortality.AccidentDeaths) as int)) as TotalDeath
FROM AccidentMortality
WHERE Year = 2017 OR Year = 2018 OR Year = 2019
GROUP BY State, Year
HAVING SUM(CAST((AccidentMortality.AccidentDeaths) as int)) > 10000
ORDER BY TotalDeath DESC

--- California, Florida, and Texas had the most number of deaths by accidents - More than 1000 each year. 


SELECT SUM(CAST((AccidentMortality.AccidentDeaths) as int)) as TotalAccidentDeath
FROM AccidentMortality 
WHERE Year = 2017 OR Year = 2018 OR Year = 2019

--- In just three years, 508,844 people are died in car accidents across the USA.  

SELECT SUM(CAST((MassShootings.KilledByMassShooting) as int)) as TotalMassDeath
FROM MassShootings
WHERE Year = 2017 OR Year = 2018 OR Year = 2019

SELECT SUM(CAST((GunDeathByYear.KilledbyGun) as int)) as TotalGunDeath
FROM GunDeathByYear
WHERE Year = 2017 OR Year = 2018 OR Year = 2019

--- 2,397 are killed by Gun (Either in a Mass or Accidental Shooting or some other way involving a Gun).   

SELECT State, MAX(CONVERT(int, StatePopulation.Population)) as TotalPop
FROM StatePopulation
WHERE Year = 2017 OR Year = 2018 OR Year = 2019
GROUP BY State
ORDER BY TotalPop DESC

--- Obviously, these three (CA, TX, FL) are the most populated states as well. But what about the other ones, like NY! It can be said
--- Crowded cities are likely to be safer than other places. It needs to be investigated further in this project. 
----------------------------------------------------------------------------------------------------------------------------------------

SELECT AccidentMortality.AccidentDeaths,
	   AccidentMortality.State,
       AccidentMortality.Year,
       GunDeathByYear.KilledbyGun
FROM AccidentMortality FULL OUTER JOIN GunDeathByYear 
ON AccidentMortality.State = GunDeathByYear.State

--- Let's Filter the Year - 2017, 2018, & 2019
SELECT *
FROM AccidentMortality AM 
JOIN MassShootings MShoot
ON AM.State = MShoot.State
AND AM.Year = MShoot.Year 
WHERE AM.Year = 2017 OR AM.Year = 2018 OR AM.Year = 2019
OR MShoot.KilledByMassShooting IS NOT NULL OR AM.AccidentDeaths IS NOT NULL
ORDER BY MShoot.KilledByMassShooting, AM.Year DESC

--- It is a little long. Some variables repeat twice. Shorten version can be like this: 

SELECT AM.Year, AM.State,AM.AccidentDeaths, GUN.Injured, GUN.KilledbyGun
FROM AccidentMortality AM
JOIN GunDeathByYear GUN
 ON AM.State = GUN.State
WHERE AM.Year= 2017 OR AM.Year= 2018 OR AM.Year= 2019
ORDER BY AM.AccidentDeaths, GUN.KilledbyGun DESC


SELECT GUN.Year, GUN.State,GUN.KilledbyGun, MShoot.KilledByMassShooting
FROM GunDeathByYear GUN
JOIN MassShootings MShoot
 ON GUN.State = MShoot.State
WHERE GUN.Year= 2017 OR GUN.Year= 2018 OR GUN.Year= 2019
ORDER BY GUN.State DESC



