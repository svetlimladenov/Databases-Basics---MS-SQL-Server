--01. One-To-One Relationship
CREATE TABLE Persons(
PersonID INT PRIMARY KEY,
FirstName VARCHAR(50),
Salary decimal,
PassportID INT UNIQUE
)
CREATE TABLE Passports(
PassportID INT PRIMARY KEY,
PassportNumber NVARCHAR(255)
)

INSERT INTO Passports VALUES 
  (101, 'N34FG21B'), 
  (102, 'K65LO4R7'), 
  (103, 'ZE657QP2')

INSERT INTO Persons VALUES 
  (1, 'Roberto', 43330.00, 102),
  (2, 'Tom', 56100.00, 103),
  (3, 'Yana', 60200.00, 101)

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)


--Problem 2.	One-To-Many Relationship

CREATE TABLE Manufacturers (
ManufacturerID INT PRIMARY KEY,
Name NVARCHAR(100) NOT NULL,
EstablishedOn DATETIME,
)
CREATE TABLE Models(
ModelId INT PRIMARY KEY,
Name NVARCHAR(100) NOT NULL,
ManufacturerID INT,

CONSTRAINT FK_Models_Manufacturers
FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)
)



INSERT INTO Manufacturers(ManufacturerID,Name,EstablishedOn) VALUES
(1,'BMW','07/03/1916'), 
(2,'Tesla','01/01/2003'),
(3,'Lada','01/05/1966')

INSERT INTO Models VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3)

--Problem 3.	Many-To-Many Relationship
CREATE TABLE Students (
StudentId INT PRIMARY KEY,
Name VARCHAR(50)
)
CREATE TABLE Exams (
ExamId INT PRIMARY KEY,
Name VARCHAR(225)
)

CREATE TABLE StudentsExams(
StudentId INT,
ExamId INT,

CONSTRAINT PK_StudentExams
PRIMARY KEY (StudentId,ExamId),

CONSTRAINT FK_StudentsExam_Students
FOREIGN KEY (StudentId)
REFERENCES Students(StudentId),

CONSTRAINT FK_StudentsExam_Exams
FOREIGN KEY (ExamId)
REFERENCES Exams(ExamId)
)

INSERT INTO Students(StudentId,Name) VALUES
(1,'Mila'),
(2,'Toni'),
(3,'Ron')

INSERT INTO Exams(ExamId,Name) VALUES
(101,'SpringMVC'),
(102,'Neo4j'),
(103,'Oracle 11g')

INSERT INTO StudentsExams(StudentId,ExamId) VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

SELECT s.Name,e.Name FROM StudentsExams AS se
JOIN Students AS s ON s.StudentId = se.StudentId
JOIN Exams AS e ON e.ExamId = se.ExamId

--Problem 4.	Self-Referencing 

CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY,
Name NVARCHAR(255),
ManagerID INT,
CONSTRAINT FK_ManagerID_TeacherID 
FOREIGN KEY(ManagerID) 
REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers VALUES
  (101, 'John', NULL),
  (102, 'Maya', 106),
  (103, 'Silvia', 106),
  (104, 'Ted', 105),
  (105, 'Mark', 101),
  (106, 'Greta', 101)


SELECT 
  t.Name AS Teacher,
  m.Name AS Manager
FROM Teachers AS t 
LEFT JOIN Teachers AS m 
ON t.ManagerID = m.TeacherID

--Problem 5.	Online Store Database

CREATE TABLE Cities(
	CityID INT IDENTITY,
	Name VARCHAR(50),

	CONSTRAINT PK_Cities
	PRIMARY KEY (CityID)
)
CREATE TABLE Customers(
	CustomerID INT IDENTITY,
	Name VARCHAR(50) NOT NULL,
	Birthday date NOT NULL,
	CityId INT

	CONSTRAINT PK_Customers
	PRIMARY KEY (CustomerID),

	CONSTRAINT FK_Customers_Cities
	FOREIGN KEY (CityID)
	REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
	OrderID INT,
	CustomerID INT,

	CONSTRAINT PK_Orders
	PRIMARY KEY (OrderID),

	CONSTRAINT FK_Orders_Customers
	FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID)
)


CREATE TABLE ItemTypes(
	ItemTypeID INT,
	Name VARCHAR(50) NOT NULL,

	CONSTRAINT PK_ItemTypesId
	PRIMARY KEY (ItemTypeID)
)

CREATE TABLE Items(
	ItemID INT,
	Name VARCHAR(50) NOT NULL,
	ItemTypeID INT,

	CONSTRAINT PK_ItemId
	PRIMARY KEY (ItemID),
	
	CONSTRAINT FK_Items_ItemTypes
	FOREIGN KEY (ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)
)



CREATE TABLE OrderItems (
	OrderID INT,
	ItemID INT,

	CONSTRAINT PK_OrderId_ItemId
	PRIMARY KEY (OrderID,ItemID),

	CONSTRAINT FK_OrderItems_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),

	CONSTRAINT FK_OrderItems_Items
	FOREIGN KEY (ItemID)
	REFERENCES Items(ItemID),
)

SELECT * FROM INFORMATION_SCHEMA.TABLES


--Problem 6.	University Database

CREATE TABLE Subjects(
SubjectID INT,
SubjectName VARCHAR(100) NOT NULL,
CONSTRAINT PK_Subjects
PRIMARY KEY (SubjectID)
)

CREATE TABLE Majors(
MajorID INT,
Name VARCHAR(100) NOT NULL,
CONSTRAINT PK_Majors
PRIMARY KEY(MajorID)
)

CREATE TABLE Students(
StudentID INT,
StudentNumbers INT NOT NULL UNIQUE,
StudentName VARCHAR(100) NOT NULL,
MajorID INT,

CONSTRAINT PK_Students
PRIMARY KEY (StudentID),

CONSTRAINT FK_Students_Majors
FOREIGN KEY (MajorID)
REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
PaymentID INT,
PaymentDate DATETIME NOT NULL,
PaymentAmount DECIMAL(15,2) NOT NULL, 
StudentID INT NOT NULL,

CONSTRAINT PK_Payments
PRIMARY KEY (PaymentID),

CONSTRAINT FK_Payments_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)
)

CREATE TABLE Agenda(
StudentID INT NOT NULL,
SubjectID INT NOT NULL,

CONSTRAINT PK_Agenda 
PRIMARY KEY (StudentID,SubjectID),

CONSTRAINT FK_Agenda_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID),

CONSTRAINT FK_Agenda_Subjects
FOREIGN KEY (SubjectID)
REFERENCES Subjects(SubjectID)
)


SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT m.MountainRange,p.PeakName,p.Elevation FROM Peaks as p
JOIN Mountains as m ON m.Id =  p.MountainId
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC