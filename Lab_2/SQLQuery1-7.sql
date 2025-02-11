-- 1. ������� ��� ������� ������� ������.
SELECT * FROM Trips

-- 2. ������� ������ ��������� � ������ �����.
SELECT * FROM Drivers WHERE FirstName = '����';

-- 3. ������� ������ ����������� � ����� ����� 1, ���������� ����� 2010 ����.
SELECT * FROM Cars WHERE BrandID = 1 AND YearOfManufacture > 2010;

-- 4. ������� ������ �����������, ���������� � 2005, 2007 � 2012 ����.
SELECT * FROM Cars WHERE YearOfManufacture IN (2005, 2007, 2012);

-- 5. ������� ���� ����������� � ���������, ���������� � ���� �� ���������� �� 1000 �� 2000 ����������.
SELECT CarID, DriverID FROM Trips WHERE Distance BETWEEN 1000 AND 2000;

-- 6. ������� ������ ����� �����������, �� ������� ����������������.
SELECT * FROM Brands WHERE LoadCapacity IS NULL OR LoadCapacity = 0;

-- 7. ������� ������ ���������, ������� ������� ���������� �� "�" � ������������� �� "��".
SELECT * FROM Drivers WHERE LastName LIKE '�%��';
