USE JFAutomobile
GO

--1
SELECT CarBrandCountry,
	   [Times Rent] = COUNT(trd.CarID)
FROM MsCarBrand mcb JOIN MsCar mc ON mcb.CarBrandID = mc.CarBrandID
	 JOIN TrRentalDetail trd ON mc.CarID = trd.CarID
WHERE YEAR(RentalStartDate) = 2022 AND DATENAME(QUARTER, RentalStartDate) = 2
GROUP BY CarBrandCountry 
ORDER BY [Times Rent] DESC

--2
SELECT mm.MechanicID,
       mm.MechanicName,
       [Email] = REPLACE(MechanicEmail, 'mail.com', 'mecha.com'),
       [Total Earning] = 'IDR' + CAST(SUM(ServicePrice) AS VARCHAR)
FROM TrServiceHeader tsh JOIN MsMechanic mm ON tsh.MechanicID = mm.MechanicID
JOIN TrServiceDetail tsd ON tsh.ServiceID = tsd.ServiceID
JOIN MsService mse ON tsd.ServiceNameID = mse.ServiceNameID
WHERE ServicePrice > 300000
GROUP BY mm.MechanicID, mm.MechanicName, mm.MechanicEmail
HAVING SUM(ServicePrice) > 3000000

--3
SELECT TOP 5 trh.RentalID,
       [Total Distance] = SUM(RentalDistanceTravelled)
FROM TrRentalHeader trh JOIN TrRentalDetail trd ON trh.RentalID = trd.RentalID 
WHERE YEAR(RentalStartDate) >= 2022
GROUP BY trh.RentalID
HAVING COUNT(CarID) = 2
ORDER BY [Total Distance] DESC

--4
SELECT mc.CarID,
	   [Car] = CONCAT(CONCAT(CarBrandName, '.'), CarName ),
	   [Country Code] = CONCAT(LEFT(CarBrandCountry, 1), RIGHT(CarBrandCountry, 1)),
	   [Time Rent] = COUNT(mc.CarID)
FROM MsCarBrand mcb JOIN MsCar mc ON mcb.CarBrandID = mc.CarBrandID
JOIN TrRentalDetail trd ON trd.CarID = mc.CarID,
(
	SELECT [Average] = AVG(mc2.CarEngineCapacity)
	FROM MsCar mc2
)AvgEngineCapacity
WHERE mc.CarEngineCapacity > AvgEngineCapacity.Average
GROUP BY mc.CarId, CONCAT(CONCAT(CarBrandName, '.'), CarName ), CONCAT(LEFT(CarBrandCountry, 1), RIGHT(CarBrandCountry, 1))
HAVING COUNT(mc.CarID) > 1

--5
SELECT 
 ServiceName,
 [Old Price] = ServicePrice,
 [New Price] = ServicePrice + (ServicePrice*.05)
FROM
 MsService ms,
(
 SELECT 
  ServiceNameID,
  [Service Used in week days] = COUNT(ServiceID)
 FROM
  TrServiceDetail
 WHERE
  DATENAME(WEEKDAY, ServiceDate) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
 GROUP BY
  ServiceNameID
 HAVING
  COUNT(ServiceID) < 5

) AS sub
WHERE
 ms.ServiceNameID = sub.ServiceNameID

UNION

SELECT 
 ServiceName,
 [Old Price] = ServicePrice,
 [New Price] = ServicePrice + (ServicePrice*.1)
FROM
 MsService ms,
(
 SELECT 
  ServiceNameID,
  [Service Used in week days] = COUNT(ServiceID)
 FROM
  TrServiceDetail
 WHERE
  DATENAME(WEEKDAY, ServiceDate) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
 GROUP BY
  ServiceNameID
 HAVING
  COUNT(ServiceID) BETWEEN 5 AND 10

) AS sub
WHERE
 ms.ServiceNameID = sub.ServiceNameID

UNION

SELECT 
 ServiceName,
 [Old Price] = ServicePrice,
 [New Price] = ServicePrice + (ServicePrice*.15)
FROM
 MsService ms,
(
 SELECT 
  ServiceNameID,
  [Service Used in week days] = COUNT(ServiceID)
 FROM
  TrServiceDetail
 WHERE
  DATENAME(WEEKDAY, ServiceDate) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
 GROUP BY
  ServiceNameID
 HAVING
  COUNT(ServiceID) > 10

) AS sub
WHERE
 ms.ServiceNameID = sub.ServiceNameID

--6
SELECT [TransactionId] = trd.RentalID,
	   [Customer Name] = LOWER(mcu.CustomerName),
	   [Start Date] = CONVERT(varchar, RentalStartDate, 107),
	   [CarId] = mca.CarID,
	   [Transaction Price] = (CarPricePerKM * RentalDistanceTravelled) 
FROM TrRentalDetail trd JOIN TrRentalHeader trh ON trd.RentalID = trh.RentalID
JOIN MsCustomer mcu ON trh.CustomerID = mcu.CustomerID
JOIN MsCar mca ON trd.CarID = mca.CarID,
(
	SELECT [Average] = AVG(CarPricePerKM * RentalDistanceTravelled)
	FROM MsCar mc2 JOIN TrRentalDetail trd2 ON mc2.CarID = trd2.CarID 
	) AS AveragePrice
WHERE DATEDIFF(DAY, RentalStartDate, RentalReturnDate) <= 7 AND (CarPricePerKM * RentalDistanceTravelled) > AveragePrice.Average

--7
SELECT [StaffID] = REPLACE(msa.StaffID, 'SF', 'Employee'),
    [First Name] = LEFT(StaffName, CHARINDEX(' ', StaffName)),
    [Total Handled Transaction] = COUNT(tsh.ServiceID),
    [Gained Service Fee] =  SUM(0.05 * ServicePrice)
   FROM TrServiceDetail tsd 
JOIN TrServiceHeader tsh ON tsd.ServiceID = tsh.ServiceID
JOIN MsStaff msa ON tsh.StaffID = msa.StaffID
JOIN MsService mse ON tsd.ServiceNameID = mse.ServiceNameID,
(
 SELECT StaffID FROM MsStaff
 Where StaffGender = 'Male'
) AS sub
WHERE  msa.StaffID IN (sub.StaffID)
GROUP BY REPLACE(msa.StaffID, 'SF', 'Employee'), LEFT(StaffName, CHARINDEX(' ', StaffName)), (0.05 * ServicePrice)
HAVING COUNT(tsh.ServiceID) >= 4

--8
SELECT 
CustomerName,
CustomerPhone,
[Total Spent] = SUM(mca.CarPricePerKm * trd.RentalDistanceTravelled),
[Maximum Spent in 1 Transaction] = MAX(mca.CarPricePerKm * trd.RentalDistanceTravelled),
[Membership Status] = 'Member'

FROM TrRentalHeader trh 
JOIN TrRentalDetail trd ON trh.RentalID = trd.RentalID
JOIN MsCustomer mc ON mc.CustomerID = trh.CustomerID
JOIN MsCar mca ON mca.CarID = trd.CarID
JOIN MsStaff ms ON ms.StaffID = trh.StaffID,
(
 SELECT 
  mcu2.CustomerID,
  [Rental Transaction Price] = SUM(mca2.CarPricePerKm * trd2.RentalDistanceTravelled)

 FROM
  TrRentalDetail trd2 JOIN TrRentalHeader trh2 ON trd2.RentalID = trh2.RentalID
  JOIN MsCustomer mcu2 ON trh2.CustomerID = mcu2.CustomerID
  JOIN MsCar mca2 ON trd2.CarID = mca2.CarID

 WHERE
  mcu2.CustomerGender = 'Male'

 GROUP BY
  mcu2.CustomerID

 HAVING
  SUM(mca2.CarPricePerKM * trd2.RentalDistanceTravelled) < 3000000
) AS sub

WHERE
 mc.CustomerID = sub.CustomerID AND mca.CarPricePerKM * trd.RentalDistanceTravelled > 1500000

GROUP BY
 mc.CustomerID, mc.CustomerPhone, mc.CustomerName, REPLACE(mc.CustomerPhone, '+62','IDN - ')

HAVING
 MAX(mca.CarPricePerKM * trd.RentalDistanceTravelled) > 1500000

UNION

SELECT 
CustomerName,
CustomerPhone,
[Total Spent] = SUM(mca.CarPricePerKm * trd.RentalDistanceTravelled),
[Maximum Spent in 1 Transaction] = MAX(mca.CarPricePerKm * trd.RentalDistanceTravelled),
[Membership Status] = 'Silver Member'

FROM TrRentalHeader trh 
JOIN TrRentalDetail trd ON trh.RentalID = trd.RentalID
JOIN MsCustomer mc ON mc.CustomerID = trh.CustomerID
JOIN MsCar mca ON mca.CarID = trd.CarID
JOIN MsStaff ms ON ms.StaffID = trh.StaffID,
(
 SELECT 
  mcu2.CustomerID,
  [Rental Transaction Price] = SUM(mca2.CarPricePerKm * trd2.RentalDistanceTravelled)

 FROM
  TrRentalDetail trd2 JOIN TrRentalHeader trh2 ON trd2.RentalID = trh2.RentalID
  JOIN MsCustomer mcu2 ON trh2.CustomerID = mcu2.CustomerID
  JOIN MsCar mca2 ON trd2.CarID = mca2.CarID

 WHERE
  mcu2.CustomerGender = 'Male'

 GROUP BY
  mcu2.CustomerID

 HAVING
  SUM(mca2.CarPricePerKM * trd2.RentalDistanceTravelled) BETWEEN 3000000 AND 5000000
) AS sub

WHERE
 mc.CustomerID = sub.CustomerID AND mca.CarPricePerKM * trd.RentalDistanceTravelled > 1500000

GROUP BY
 mc.CustomerID, mc.CustomerPhone, mc.CustomerName, REPLACE(mc.CustomerPhone, '+62','IDN - ')

HAVING
 MAX(mca.CarPricePerKM * trd.RentalDistanceTravelled) > 1500000
 
UNION

SELECT 
CustomerName,
CustomerPhone,
[Total Spent] = SUM(mca.CarPricePerKm * trd.RentalDistanceTravelled),
[Maximum Spent in 1 Transaction] = MAX(mca.CarPricePerKm * trd.RentalDistanceTravelled),
[Membership Status] = 'Gold Member'

FROM TrRentalHeader trh 
JOIN TrRentalDetail trd ON trh.RentalID = trd.RentalID
JOIN MsCustomer mc ON mc.CustomerID = trh.CustomerID
JOIN MsCar mca ON mca.CarID = trd.CarID
JOIN MsStaff ms ON ms.StaffID = trh.StaffID,
(
 SELECT 
  mcu2.CustomerID,
  [Rental Transaction Price] = SUM(mca2.CarPricePerKm * trd2.RentalDistanceTravelled)

 FROM
  TrRentalDetail trd2 JOIN TrRentalHeader trh2 ON trd2.RentalID = trh2.RentalID
  JOIN MsCustomer mcu2 ON trh2.CustomerID = mcu2.CustomerID
  JOIN MsCar mca2 ON trd2.CarID = mca2.CarID

 WHERE
  mcu2.CustomerGender = 'Male'

 GROUP BY
  mcu2.CustomerID

 HAVING
  SUM(mca2.CarPricePerKM * trd2.RentalDistanceTravelled) > 5000000
) AS sub

WHERE
 mc.CustomerID = sub.CustomerID

GROUP BY
 mc.CustomerID, mc.CustomerPhone, mc.CustomerName, REPLACE(mc.CustomerPhone, '+62','IDN - ')

HAVING
 MAX(mca.CarPricePerKM * trd.RentalDistanceTravelled) > 1500000

--9
GO
CREATE VIEW ViewMinAndMaxDistance 
AS
SELECT [Min Distance] = CONCAT(CAST(MIN(RentalDistanceTravelled) AS VARCHAR), ' km'),
       [Max Distance] = CONCAT(CAST(MAX(RentalDistanceTravelled) AS VARCHAR), ' km')
FROM TrRentalDetail
WHERE YEAR(RentalStartDate) = 2022 AND DATENAME(QUARTER, RentalStartDate) = 1

--Untuk melihat data di ViewMinAndMaxDistance
SELECT *
FROM ViewMinAndMaxDistance

--10
GO
CREATE VIEW ViewAverageShortRentalEarning
AS
SELECT CONCAT('Rp. ' , AVG(X.RentalPrice), '.-') AS 'Average Earning'
FROM MsCar mc JOIN MsCarBrand mcb ON mc.CarBrandID = mcb.CarBrandID 
JOIN TrRentalDetail trd ON trd.CarID = mc.CarID,
(
	SELECT SUM(CarPricePerKM * Z.Quantity) 
	AS 'RentalPrice'
	FROM MsCar,
(SELECT RentalID,
COUNT(CarID) AS 'Quantity'
FROM TrRentalDetail
GROUP BY RentalID
)Z
)X,
(SELECT RentalID,
MIN (DATEDIFF(DAY, RentalStartDate, RentalReturnDate) +1 )AS 'Minimum Rental Duration'
FROM TrRentalDetail
GROUP BY RentalID) Y
WHERE CarBrandCountry = 'JAPAN'AND DATEDIFF(DAY, RentalStartDate, RentalReturnDate) <= Y.[Minimum Rental Duration]


--Untuk melihat data di ViewAverageShortRentalEarning
SELECT * 
FROM ViewAverageShortRentalEarning

--Untuk melihat data dari table-table
SELECT * FROM MsCar
SELECT * FROM MsCarBrand
SELECT * FROM MsCustomer
SELECT * FROM MsMechanic
SELECT * FROM MsService
SELECT * FROM MsStaff
SELECT * FROM TrRentalDetail
SELECT * FROM TrRentalHeader
SELECT * FROM TrServiceDetail
SELECT * FROM TrServiceHeader