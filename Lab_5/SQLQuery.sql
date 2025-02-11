-- 	*** Запросы с операцией соединения JOIN ***

-- 1) Составить полную информацию о поездках водителя с заданной фамилией
SELECT Trips.*, Drivers.LastName, Drivers.FirstName, Cars.CarNumber, Cars.YearOfManufacture FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
JOIN Cars ON Trips.CarID = Cars.CarID
WHERE Drivers.LastName = 'Петров';


-- 2) Получить полную информацию о транспорте и водителях, задействованных в поездках на прошлой неделе
SELECT Trips.*, Drivers.LastName, Drivers.FirstName, Cars.CarNumber, Cars.YearOfManufacture FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
JOIN Cars ON Trips.CarID = Cars.CarID
WHERE TripDate >= DATEADD(WEEK, -1, GETDATE()) - DATEPART(WEEKDAY, GETDATE()) + 1
	AND TripDate < DATEADD(WEEK, 0, GETDATE()) - DATEPART(WEEKDAY, GETDATE()) + 1;
	
	
-- 3) Составить список марок автомобилей, эксплуатирующихся более 10 лет
SELECT DISTINCT Brands.BrandName FROM Cars
JOIN Brands ON Cars.BrandID = Brands.BrandID
WHERE Cars.YearOfManufacture <= YEAR(GETDATE()) - 10;


-- 4) Составить список водителей, выезжавших на автомобиле заданной марки в прошлом месяце
SELECT DISTINCT Drivers.LastName, Drivers.FirstName FROM Trips
JOIN Drivers ON Trips.DriverID = Drivers.DriverID
JOIN Cars ON Trips.CarID = Cars.CarID
JOIN Brands ON Cars.BrandID = Brands.BrandID
WHERE Brands.BrandName = 'МАЗ'
	AND MONTH(Trips.TripDate) = MONTH(DATEADD(MONTH, -1, GETDATE()))
	AND YEAR(Trips.TripDate) = YEAR(DATEADD(MONTH, -1, GETDATE()));




-- 	*** Запросы с UNION, EXCEPT, INTERSECT ***

-- 1) Найти однофамильцев среди водителей
SELECT LastName FROM Drivers
GROUP BY LastName
HAVING COUNT(*) > 1;


-- 2) Составить список автомобилей, выезжавших в рейс с интервалом менее двух дней
SELECT DISTINCT T1.CarID FROM Trips T1
JOIN Trips T2 ON T1.CarID = T2.CarID
WHERE ABS(DATEDIFF(DAY, T1.TripDate, T2.TripDate)) < 2
	AND T1.TripID <> T2.TripID;
	

-- 3) Составить список автомобилей, одновременно выезжавших на прошлой неделе
SELECT T1.CarID FROM Trips T1
JOIN Trips T2 ON T1.TripDate = T2.TripDate AND T1.TripID <> T2.TripID
WHERE T1.TripDate BETWEEN DATEADD(WEEK, -1, GETDATE()) - DATEPART(WEEKDAY, GETDATE()) + 1
	AND DATEADD(WEEK, 0, GETDATE()) - DATEPART(WEEKDAY, GETDATE()) + 1;


