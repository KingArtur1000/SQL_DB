-- Триггер для аудита попыток удаления триггеров
CREATE TRIGGER trg_AuditDropTriggers
ON DATABASE
FOR DROP_TRIGGER
AS
BEGIN
    -- Логируем информацию о попытке удаления триггера
    INSERT INTO AuditLog (ActionType, OldValue, NewValue, UserName)
    VALUES ('DROP_TRIGGER', EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(100)'), NULL, SYSTEM_USER);
    
    -- Отмена удаления триггера
    RAISERROR('Удаление триггеров запрещено!', 16, 1);
    ROLLBACK;
END;
GO
