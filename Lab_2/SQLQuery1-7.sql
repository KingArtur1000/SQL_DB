-- 1. Вывести всю таблицу «Журнал выезда».
SELECT * FROM Trips

-- 2. Вывести список водителей с именем «Иван».
SELECT * FROM Drivers WHERE FirstName = 'Иван';

-- 3. Вывести список автомобилей с кодом марки 1, выпущенные после 2010 года.
SELECT * FROM Cars WHERE BrandID = 1 AND YearOfManufacture > 2010;

-- 4. Вывести список автомобилей, выпущенных в 2005, 2007 и 2012 году.
SELECT * FROM Cars WHERE YearOfManufacture IN (2005, 2007, 2012);

-- 5. Вывести коды автомобилей и водителей, выезжавших в рейс на расстояние от 1000 до 2000 километров.
SELECT CarID, DriverID FROM Trips WHERE Distance BETWEEN 1000 AND 2000;

-- 6. Вывести список марок автомобилей, не имеющих грузоподъемности.
SELECT * FROM Brands WHERE LoadCapacity IS NULL OR LoadCapacity = 0;

-- 7. Вывести список водителей, фамилии которых начинаются на "П" и заканчиваются на "ов".
SELECT * FROM Drivers WHERE LastName LIKE 'П%ов';
