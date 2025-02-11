-- Создание таблицы для журнала аудита
CREATE TABLE AuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ActionType NVARCHAR(50),
    ActionDate DATETIME DEFAULT GETDATE(),
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX),
    UserName NVARCHAR(50)
);
GO

-- Триггер для записи изменений в таблице Trips
CREATE TRIGGER trg_AuditTrips
ON Trips
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @ActionType NVARCHAR(50);
    DECLARE @OldValue NVARCHAR(MAX);
    DECLARE @NewValue NVARCHAR(MAX);
    
    -- Получаем информацию о действии
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @ActionType = 'INSERT';
        SET @NewValue = (SELECT * FROM inserted FOR JSON PATH);
    END
    
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @ActionType = 'DELETE';
        SET @OldValue = (SELECT * FROM deleted FOR JSON PATH);
    END
    
    -- Логируем действие
    INSERT INTO AuditLog (ActionType, OldValue, NewValue, UserName)
    VALUES (@ActionType, @OldValue, @NewValue, SYSTEM_USER);
END;
GO
