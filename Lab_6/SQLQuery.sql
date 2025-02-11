-- 1) Создание таблицы "Дальние поездки":
-- Создание таблицы
CREATE TABLE LongTrips (
    TripID INT,
    CarNumber NVARCHAR(20),
    DriverFullName NVARCHAR(150),
    TripDate DATE,
    CargoWeight DECIMAL(10,2),
    Distance DECIMAL(10,2)
);

-- Заполнение данными (поездки более 3-х дней)
INSERT INTO LongTrips
SELECT 
    t.TripID,
    c.CarNumber,
    d.LastName + ' ' + d.FirstName + ' ' + ISNULL(d.MiddleName, ''),
    t.TripDate,
    t.CargoWeight,
    t.Distance
FROM Trips t
JOIN Cars c ON t.CarID = c.CarID
JOIN Drivers d ON t.DriverID = d.DriverID
WHERE DATEDIFF(day, t.TripDate, GETDATE()) > 3;

-- Вывод таблицы
SELECT * FROM LongTrips;

GO

-- 2) Добавление поля "Год поступления" и его заполнение:
-- Добавление нового поля
ALTER TABLE Cars
ADD ArrivalYear INT;

GO

-- Заполнение поля
UPDATE Cars
SET ArrivalYear = YearOfManufacture + 2;

-- Вывод обновленной таблицы
SELECT * FROM Cars;

GO

-- 3) Индексирование таблицы "Автомобили":
-- Создание индекса по году выпуска
CREATE INDEX IX_Cars_YearOfManufacture
ON Cars(YearOfManufacture);

-- Создание индекса по номеру
CREATE INDEX IX_Cars_CarNumber
ON Cars(CarNumber);

GO

-- 4) Удаление автомобилей со сроком эксплуатации более 20 лет:
DELETE FROM Cars
WHERE YEAR(GETDATE()) - YearOfManufacture > 20;

GO

-- 5) Удаление водителей старше 65 лет:
DELETE FROM Drivers
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 65;