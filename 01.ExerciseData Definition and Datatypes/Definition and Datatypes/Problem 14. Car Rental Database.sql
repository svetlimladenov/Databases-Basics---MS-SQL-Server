CREATE TABLE Categories(
Id INT IDENTITY PRIMARY KEY,
CategoryName NVARCHAR(100) NOT NULL,
DailyRate INT NOT NULL,
WeeklyRate INT NOT NULL,
MonthlyRate INT NOT NULL,
WeekendRate INT NOT NULL,
) 
INSERT INTO Categories(CategoryName,DailyRate,WeeklyRate,MonthlyRate,WeekendRate) VALUES
('Kombi',5,3,2,5),
('Jeep',7,2,5,1),
('Kabrio',2,5,1,5)

CREATE TABLE Cars(
Id INT IDENTITY PRIMARY KEY,
PlateNumber NVARCHAR(100) NOT NULL,
Manufacturer NVARCHAR(100) NOT NULL,
Model NVARCHAR(100) NOT NULL,
CarYear INT NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(id) NOT NULL,
Doors INT NOT NULL,
Picture BINARY,
Condition NVARCHAR(100),
Avaivable BIT NOT NULL
)

INSERT INTO Cars(PlateNumber,Manufacturer,Model,CarYear,CategoryId, Doors, Avaivable) VALUES
('KN5207AB','Honda','CR-V',2005,'2',5,1),
('KN7270AB','BMW','E36 COMPACT', 2001,1,3,1),
('KN9000AB','Honda','CR-V',2007,'2',5,1)


CREATE TABLE Employees (
Id INT IDENTITY PRIMARY KEY,
FirstName NVARCHAR(100) NOT NULL,
LastName NVARCHAR(100) NOT NULL,
Title NVARCHAR(100) NOT NULL,
Notes NVARCHAR(MAX),
) 

INSERT INTO Employees(FirstName,LastName,Title) VALUES
('Svetlin','Mladenov','WTF'),
('Emil','Mladenov','VIANOR'),
('Ivan','Petrov','KURWI')

CREATE TABLE Customers (
Id INT IDENTITY PRIMARY KEY,
DriverLicenceNumber INT NOT NULL,
FullName NVARCHAR(100) NOT NULL,
Adress NVARCHAR(100) NOT NULL,
City NVARCHAR(100) NOT NULL,
ZIPCity INT NOT NULL,
Notes NVARCHAR(MAX)
)
INSERT INTO Customers(DriverLicenceNumber,FullName,Adress,City,ZIPCity) VALUES
(25452,'GeorgiYosifov','StudenKladenec 9','Kyustendil',2500),
(91452,'EmilianTaskov','Rakovska 5','Kyustendil',2500),
(72315,'DanielKrumov','Elistaveta 7','Vartashevo',2500)


CREATE TABLE RentalOrders (
Id INT IDENTITY PRIMARY KEY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
TankLevel INT NOT NULL,
KilometrageStart INT,
KilometrageEnd INT,
TotalKilometrage INT,
StartDate DATE,
EndDate DATE,
TotalDays INT,
RateApplied INT,
TaxRate DECIMAL(15,2),
OrderStatus NVARCHAR(200),
Notes NVARCHAR(MAX)
)

INSERT INTO RentalOrders (EmployeeId,CustomerId,CarId,TankLevel) VALUES
(1,2,1,110),
(2,3,3,90),
(3,1,2,100)