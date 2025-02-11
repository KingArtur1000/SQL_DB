-- Заполнение таблицы Brands
INSERT INTO Brands (BrandName, LoadCapacity) VALUES
('Volvo', 20.5),
('MAN', 25.0),
('Scania', 22.3);
GO

-- Заполнение таблицы Cars
INSERT INTO Cars (BrandID, YearOfManufacture, CarNumber) VALUES
(1, 2019, 'AA1234BX'),
(2, 2020, 'BB5678CX'),
(3, 2018, 'CC9101DX');
GO

-- Заполнение таблицы Drivers
INSERT INTO Drivers (LastName, FirstName, MiddleName, BirthDate) VALUES
('Ivanov', 'Ivan', 'Ivanovich', '1985-07-15'),
('Petrov', 'Petr', 'Petrovich', '1990-02-20'),
('Sidorov', 'Sidr', 'Sidorovich', '1983-11-05');
GO

-- Заполнение таблицы Trips
INSERT INTO Trips (CarID, DriverID, TripDate, TripTime, CargoWeight, Distance) VALUES
(1, 1, '2024-02-10', '08:30:00', 10.2, 120.5),
(2, 2, '2024-02-11', '09:15:00', 15.0, 150.0),
(3, 3, '2024-02-12', '07:45:00', 8.5, 95.3);
GO
