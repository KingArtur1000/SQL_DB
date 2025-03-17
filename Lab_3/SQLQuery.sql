USE Transport;

-- 1. Определить средний срок эксплуатации автомобилей (разница между текущим годом и годом выпуска)
SELECT AVG(YEAR(GETDATE()) - Cars.YearOfManufacture) AS Avg_Exploitation_Years FROM Cars;


-- 2. Отыскать количество автомобилей каждой марки
SELECT Brands.BrandName, COUNT(Cars.CarID) AS CarCount FROM Cars
JOIN Brands ON Cars.BrandID = Brands.BrandID
GROUP BY Brands.BrandName;


-- 2.1 (Через подзапросы)
SELECT BrandName, 
       (SELECT COUNT(*) FROM Cars WHERE Cars.BrandID = Brands.BrandID) AS CarCount
FROM Brands;



-- 3. Определить общий километраж поездок каждого водителя
SELECT Drivers.DriverID, Drivers.LastName, Drivers.FirstName, SUM(Trips.Distance) AS TotalDistance FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
GROUP BY Drivers.DriverID, Drivers.LastName, Drivers.FirstName;


-- 3.1 (Через подзапросы)
SELECT DriverID, LastName, FirstName, 
       (SELECT SUM(Distance) FROM Trips WHERE Trips.DriverID = Drivers.DriverID) AS TotalDistance
FROM Drivers;



-- 4. Определить, сколько водителей было отправлено в поездки в текущем месяце
SELECT COUNT(DISTINCT Trips.DriverID) AS DriversInCurrentMonth FROM Trips
WHERE MONTH(Trips.TripDate) = MONTH(GETDATE()) 
	AND YEAR(Trips.TripDate) = YEAR(GETDATE());


-- 5. Определить код водителя, который был в поездке с наибольшим расстоянием
SELECT TOP 1 Trips.DriverID, Trips.Distance FROM Trips
ORDER BY Trips.Distance DESC;


-- 6. Определить число поездок каждого водителя в прошлом месяце
SELECT Drivers.DriverID, Drivers.LastName, Drivers.FirstName, COUNT(Trips.TripID) AS TripCount FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
WHERE MONTH(Trips.TripDate) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
	AND YEAR(Trips.TripDate) = YEAR(DATEADD(MONTH, -1, GETDATE()))
GROUP BY Drivers.DriverID, Drivers.LastName, Drivers.FirstName;


-- 7. Определить среднее число машин ежедневно отправляющихся в поездки
SELECT AVG(TripCount) AS AvgTripsPerDay
FROM (
    SELECT Trips.TripDate, COUNT(DISTINCT Trips.CarID) AS TripCount
    FROM Trips
    GROUP BY Trips.TripDate
) AS DailyTrips;


-- Дополнительно для проверки 7 пункта:
SELECT TripDate, COUNT(DISTINCT CarID) AS TripCount FROM Trips
GROUP BY TripDate;

-- Если в каждой строке TripCount = 1, значит в базе данных
-- каждая машина выезжает в разные дни без пересечений.

-- SQL Shades is the perfect tool to shield my poor eyes from the evils of light mode