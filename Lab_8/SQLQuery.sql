-- Удаляем старые процедуры, если они существуют
IF OBJECT_ID('GetCarsByYearOfManufacture', 'P') IS NOT NULL
    DROP PROCEDURE GetCarsByYearOfManufacture;
GO

IF OBJECT_ID('GetDriversWithUpcomingBirthday', 'P') IS NOT NULL
    DROP PROCEDURE GetDriversWithUpcomingBirthday;
GO

IF OBJECT_ID('GetTripsByCarNumberLastMonth', 'P') IS NOT NULL
    DROP PROCEDURE GetTripsByCarNumberLastMonth;
GO

-- 2. Создаём процедуры заново
-- Хранимая процедура для формирования списка номеров автомобилей заданного года выпуска
CREATE PROCEDURE GetCarsByYearOfManufacture
    @Year INT
AS
BEGIN
    SELECT CarNumber
    FROM Cars
    WHERE YearOfManufacture = @Year;
END;
GO

-- Хранимая процедура для формирования списка водителей, у которых завтра день рождения
CREATE PROCEDURE GetDriversWithUpcomingBirthday
AS
BEGIN
    DECLARE @Tomorrow DATE = DATEADD(DAY, 1, GETDATE());
    
    SELECT LastName, FirstName, MiddleName, BirthDate
    FROM Drivers
    WHERE MONTH(BirthDate) = MONTH(@Tomorrow)
    AND DAY(BirthDate) = DAY(@Tomorrow);
END;
GO

-- Хранимая процедура для формирования списка поездок автомобиля с заданным номером за прошлый месяц с суммарным расстоянием
CREATE PROCEDURE GetTripsByCarNumberLastMonth
    @CarNumber NVARCHAR(20),
    @TotalDistance DECIMAL(10,2) OUTPUT
AS
BEGIN
    DECLARE @StartDate DATE = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()) - 1, 1);
    DECLARE @EndDate DATE = EOMONTH(@StartDate);

    -- Получаем список поездок
    SELECT TripID, TripDate, TripTime, CargoWeight, Distance
    FROM Trips
    INNER JOIN Cars ON Cars.CarID = Trips.CarID
    WHERE Cars.CarNumber = @CarNumber
    AND TripDate BETWEEN @StartDate AND @EndDate;

    -- Рассчитываем суммарное расстояние
    SELECT @TotalDistance = SUM(Distance)
    FROM Trips
    INNER JOIN Cars ON Cars.CarID = Trips.CarID
    WHERE Cars.CarNumber = @CarNumber
    AND TripDate BETWEEN @StartDate AND @EndDate;
END;
GO



EXEC GetCarsByYearOfManufacture @Year = 2020;

GO

EXEC GetDriversWithUpcomingBirthday;

GO

DECLARE @TotalDistance DECIMAL(10,2);

EXEC GetTripsByCarNumberLastMonth @CarNumber = 'AA1234BX', @TotalDistance = @TotalDistance OUTPUT;

-- Выводим суммарное расстояние
SELECT @TotalDistance AS TotalDistance;

GO
