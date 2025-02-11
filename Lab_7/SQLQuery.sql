-- 1. Создание представления с информацией о выездах
CREATE VIEW FullTripInfo AS
SELECT 
    Trips.TripID,
    Drivers.LastName,
    Drivers.FirstName,
    Drivers.MiddleName,
    Cars.CarNumber,
    Brands.BrandName,
    Trips.TripDate,
    Trips.TripTime,
    Trips.CargoWeight,
    Trips.Distance
FROM Trips 
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
JOIN Cars ON Trips.CarID = Cars.CarID
JOIN Brands ON Cars.BrandID = Brands.BrandID;
GO

-- Поиск водителя с наибольшим километражем
SELECT TOP 1 
    LastName,
    SUM(Distance) as TotalDistance
FROM FullTripInfo
GROUP BY LastName
ORDER BY TotalDistance DESC;
GO

-- 2. Создание представления с количеством выездов по датам
CREATE VIEW TripsCount AS
SELECT 
    TripDate,
    COUNT(*) as DailyTrips
FROM Trips
GROUP BY TripDate;
GO

-- Поиск дат с количеством выездов выше среднего
SELECT 
    TripDate,
    DailyTrips
FROM TripsCount
WHERE DailyTrips > (SELECT AVG(CAST(DailyTrips AS FLOAT)) FROM TripsCount);
GO

-- 3. Создание представления со средним километражем водителей за месяц
CREATE VIEW DriversDistance AS
SELECT 
    Drivers.LastName,
    MONTH(Trips.TripDate) as Month,
    YEAR(Trips.TripDate) as Year,
    AVG(Trips.Distance) as AverageDistance
FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
GROUP BY 
    Drivers.LastName,
    MONTH(Trips.TripDate),
    YEAR(Trips.TripDate);
GO

-- Поиск водителей с минимальным и максимальным километражем
SELECT LastName, AverageDistance
FROM DriversDistance
WHERE AverageDistance = (SELECT MIN(AverageDistance) FROM DriversDistance)
   OR AverageDistance = (SELECT MAX(AverageDistance) FROM DriversDistance);
GO

-- 4. Создание представления с информацией об использовании автомобилей
CREATE VIEW CarUsage AS
SELECT 
    Cars.CarNumber,
    Brands.BrandName,
    COUNT(*) as TripCount,
    SUM(Trips.Distance) as TotalDistance
FROM Trips
JOIN Cars ON Trips.CarID = Cars.CarID
JOIN Brands ON Cars.BrandID = Brands.BrandID
WHERE Trips.TripDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY Cars.CarNumber, Brands.BrandName;
GO

-- Поиск автомобиля с максимальным числом выездов
SELECT TOP 1 
    CarNumber,
    BrandName,
    TripCount
FROM CarUsage
ORDER BY TripCount DESC;
GO