-- Триггер для проверки бизнес-правил (масса груза не должна превышать 5000)
CREATE TRIGGER trg_BusinessRuleCargoWeight
ON Trips
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @CargoWeight DECIMAL(10, 2);
    
    -- Получаем массу груза из вставляемых или обновляемых данных
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @CargoWeight = CargoWeight FROM inserted;
    END

    -- Проверяем бизнес-правило
    IF @CargoWeight > 5000
    BEGIN
        RAISERROR('Груз не может превышать 5000 кг.', 16, 1);
        ROLLBACK;
    END
END;
GO
