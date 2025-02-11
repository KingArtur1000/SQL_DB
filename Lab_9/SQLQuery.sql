-- Удаляем старые скалярные функции, если они существуют
IF OBJECT_ID('GetCarAgeByCarNumber', 'FN') IS NOT NULL
    DROP FUNCTION GetCarAgeByCarNumber;
GO

-- Удаляем старую табличную функцию, если она существует
IF OBJECT_ID('GetCarsScheduledForTripOnDate', 'IF') IS NOT NULL
    DROP FUNCTION GetCarsScheduledForTripOnDate;
GO

-- Удаляем старую многострочную табличную функцию, если она существует
IF OBJECT_ID('GetTripScheduleForNextWeek', 'TF') IS NOT NULL
    DROP FUNCTION GetTripScheduleForNextWeek;
GO






--  1) Скалярная функция для вычисления возраста автомобиля по номеру
CREATE FUNCTION GetCarAgeByCarNumber (@CarNumber NVARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @CarYear INT;
    DECLARE @CurrentYear INT;

    -- Получаем год выпуска автомобиля
    SELECT @CarYear = YearOfManufacture
    FROM Cars
    WHERE CarNumber = @CarNumber;

    -- Получаем текущий год
    SET @CurrentYear = YEAR(GETDATE());

    -- Возвращаем возраст автомобиля
    RETURN (@CurrentYear - @CarYear);
END;
GO



--  2) Табличная функция для вывода списка автомобилей, запланированных в рейс на вводимую дату
CREATE FUNCTION GetCarsScheduledForTripOnDate (@TripDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT Cars.CarNumber, Brands.BrandName, Trips.TripDate
    FROM Trips
    INNER JOIN Cars ON Cars.CarID = Trips.CarID
    INNER JOIN Brands ON Brands.BrandID = Cars.BrandID
    WHERE Trips.TripDate = @TripDate
);
GO



--  3) Многострочная табличная функция для формирования графика выездов на следующую неделю с указанием фамилий водителей, марок и номеров автомобилей
CREATE FUNCTION GetTripScheduleForNextWeek()
RETURNS @Schedule TABLE 
(
    DriverLastName NVARCHAR(50),
    BrandName NVARCHAR(50),
    CarNumber NVARCHAR(20),
    TripDate DATE,
    TripTime TIME
)
AS
BEGIN
    DECLARE @StartDate DATE = DATEADD(DAY, 1, GETDATE());
    DECLARE @EndDate DATE = DATEADD(DAY, 7, @StartDate);

    -- Заполнение таблицы графика выездов
    INSERT INTO @Schedule
    SELECT 
        Drivers.LastName AS DriverLastName,
        Brands.BrandName,
        Cars.CarNumber,
        Trips.TripDate,
        Trips.TripTime
    FROM Trips
    INNER JOIN Cars ON Cars.CarID = Trips.CarID
    INNER JOIN Brands ON Brands.BrandID = Cars.BrandID
    INNER JOIN Drivers ON Drivers.DriverID = Trips.DriverID
    WHERE Trips.TripDate BETWEEN @StartDate AND @EndDate;

    RETURN;
END;
GO








SELECT dbo.GetCarAgeByCarNumber('BB5678CX') AS CarAge;


SELECT * 
FROM dbo.GetCarsScheduledForTripOnDate('2025-02-05');


SELECT * 
FROM dbo.GetTripScheduleForNextWeek();
