-- Триггер для обеспечения целостности данных (проверка внешних ключей)
CREATE TRIGGER trg_IntegrityTrips
ON Trips
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @CarID INT;
    DECLARE @DriverID INT;
    
    -- Получаем значения для проверки целостности
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @CarID = CarID, @DriverID = DriverID FROM inserted;
    END
    
    -- Проверка наличия автомобиля и водителя
    IF NOT EXISTS (SELECT 1 FROM Cars WHERE CarID = @CarID)
    BEGIN
        RAISERROR('Автомобиль с таким ID не существует.', 16, 1);
        ROLLBACK;
    END

    IF NOT EXISTS (SELECT 1 FROM Drivers WHERE DriverID = @DriverID)
    BEGIN
        RAISERROR('Водитель с таким ID не существует.', 16, 1);
        ROLLBACK;
    END
END;
GO
