-- 1. Создание базы данных
CREATE DATABASE Transport;
GO
USE Transport;
GO

-- 2. Создание таблицы брендов
CREATE TABLE Brands (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(50) NOT NULL,
    LoadCapacity DECIMAL(10,2) NOT NULL
);
GO

-- 3. Создание таблицы автомобилей
CREATE TABLE Cars (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    BrandID INT NOT NULL,
    YearOfManufacture INT NOT NULL,
    CarNumber NVARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);
GO

-- 4. Создание таблицы водителей
CREATE TABLE Drivers (
    DriverID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(50) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50),
    BirthDate DATE NOT NULL
);
GO

-- 5. Создание таблицы поездок
CREATE TABLE Trips (
    TripID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT NOT NULL,
    DriverID INT NOT NULL,
    TripDate DATE NOT NULL,
    TripTime TIME NOT NULL,
    CargoWeight DECIMAL(10,2) NOT NULL,
    Distance DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);
GO
