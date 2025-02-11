--  1) Список водителей, выезжавших в рейс на прошлой неделе
SELECT DISTINCT Drivers.DriverID, Drivers.LastName, Drivers.FirstName FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
WHERE TripDate >= DATEADD(WEEK, -1, GETDATE()) - DATEPART(WEEKDAY, GETDATE()) + 1
	AND TripDate < DATEADD(WEEK, 0, GETDATE()) - DATEPART(WEEKDAY, GETDATE()) + 1;


--  2) Список автомобилей марки «МАЗ»
SELECT * FROM Cars
JOIN Brands ON Cars.BrandID = Brands.BrandID
WHERE Brands.BrandName = 'МАЗ';


-- 3) Список автомобилей, выезжавших в рейс на автомобилях МАЗ, ВАЗ или ГАЗ
SELECT DISTINCT * FROM Trips
JOIN Cars ON Trips.CarID = Cars.CarID
JOIN Brands ON Cars.BrandID = Brands.BrandID
WHERE Brands.BrandName IN ('МАЗ', 'ВАЗ', 'ГАЗ');


-- 4) Фамилия водителя, выезжавшего в рейс максимальной протяженности
SELECT TOP 1 Drivers.LastName, Drivers.FirstName, Trips.Distance FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
ORDER BY Trips.Distance DESC;


-- 5) Список водителей, не выезжавших в рейс за последние 3 дня
SELECT Drivers.DriverID, Drivers.LastName, Drivers.FirstName FROM Drivers
WHERE Drivers.DriverID NOT IN (
    SELECT DISTINCT DriverID
    FROM Trips
    WHERE TripDate >= DATEADD(DAY, -3, GETDATE())
);
