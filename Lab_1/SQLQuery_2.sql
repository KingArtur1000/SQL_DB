-- Заполнение таблицы Brands
INSERT INTO Brands (BrandName, LoadCapacity) VALUES
('Volvo', 20.5),
('MAN', 25.0),
('Scania', 22.3),
('DAF', 23.7),
('Mercedes-Benz', 26.5),
('Iveco', 24.2),
('Renault', 21.8),
('Peterbilt', 27.0),
('Kenworth', 26.3),
('Freightliner', 28.0),
('Western Star', 27.5),
('Mack', 25.7),
('International', 26.1),
('Isuzu', 18.9),
('Hino', 19.5),
('Hyundai', 20.0);
GO

-- Заполнение таблицы Cars
INSERT INTO Cars (BrandID, YearOfManufacture, CarNumber) VALUES
(1, 2019, 'AA1234BX'),
(2, 2020, 'BB5678CX'),
(3, 2018, 'CC9101DX'),
(4, 2021, 'DD2345EX'),
(5, 2017, 'EE6789FX'),
(6, 2019, 'FF3456GX'),
(7, 2020, 'GG7890HX'),
(8, 2016, 'HH4567IX'),
(9, 2022, 'II8901JX'),
(10, 2018, 'JJ5678KX'),
(11, 2019, 'KK6789LX'),
(12, 2021, 'LL7890MX'),
(13, 2015, 'MM8901NX'),
(14, 2017, 'NN9012OX'),
(15, 2020, 'OO1234PX');
GO

-- Заполнение таблицы Drivers
INSERT INTO Drivers (LastName, FirstName, MiddleName, BirthDate) VALUES
('Ivanov', 'Ivan', 'Ivanovich', '1985-07-15'),
('Petrov', 'Petr', 'Petrovich', '1990-02-20'),
('Sidorov', 'Sidr', 'Sidorovich', '1983-11-05'),
('Kuznetsov', 'Nikolay', 'Nikolaevich', '1988-03-12'),
('Smirnov', 'Alexey', 'Alexeevich', '1992-06-25'),
('Popov', 'Dmitry', 'Dmitrievich', '1987-09-30'),
('Sokolov', 'Vladimir', 'Vladimirovich', '1991-01-14'),
('Lebedev', 'Sergey', 'Sergeevich', '1986-11-22'),
('Kozlov', 'Roman', 'Romanovich', '1993-08-19'),
('Novikov', 'Andrey', 'Andreevich', '1984-05-03'),
('Mikhailov', 'Igor', 'Igorevich', '1989-12-17'),
('Fedorov', 'Anton', 'Antonovich', '1990-10-08'),
('Morozov', 'Victor', 'Victorovich', '1982-04-29'),
('Volkov', 'Pavel', 'Pavlovich', '1985-02-11'),
('Alekseev', 'Kirill', 'Kirillovich', '1994-07-21');
GO

-- Заполнение таблицы Trips
INSERT INTO Trips (CarID, DriverID, TripDate, TripTime, CargoWeight, Distance) VALUES
(1, 1, '2024-02-10', '08:30:00', 10.2, 120.5),
(2, 2, '2024-02-11', '09:15:00', 15.0, 150.0),
(3, 3, '2024-02-12', '07:45:00', 8.5, 95.3),
(4, 4, '2024-02-13', '06:50:00', 12.3, 130.0),
(5, 5, '2024-02-14', '10:20:00', 16.7, 160.5),
(6, 6, '2024-02-15', '11:40:00', 9.0, 110.2),
(7, 7, '2024-02-16', '08:10:00', 14.5, 140.7),
(8, 8, '2024-02-17', '09:50:00', 11.8, 125.3),
(9, 9, '2024-02-18', '07:20:00', 13.6, 135.9),
(10, 10, '2024-02-19', '08:00:00', 10.0, 100.0),
(11, 11, '2024-02-20', '07:35:00', 12.9, 128.5),
(12, 12, '2024-02-21', '09:05:00', 14.2, 142.1),
(13, 13, '2024-02-22', '10:30:00', 11.0, 115.7),
(14, 14, '2024-02-23', '06:45:00', 13.3, 132.4),
(15, 15, '2024-02-24', '08:55:00', 15.5, 155.9);
GO
