CREATE DATABASE Minions

CREATE TABLE Minions(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50),
Age INT
)
CREATE TABLE Towns(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50)
)

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

INSERT INTO Minions(Name,Age,TownId)
VALUES 
('Kevin' ,22,1),
('Bob',15,3),
('Steward',NULL,2)

INSERT INTO Towns(Id,Name)
VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna')

DROP TABLE Minions,Towns


CREATE TABLE People(
Id INT UNIQUE IDENTITY,
Name NVARCHAR(200) NOT NULL,
Picture VARBINARY(2),
Height DECIMAL(15,2),
Weight DECIMAL(15,2),
Gender VARCHAR(1) CHECK(Gender != 'm' OR Gender != 'f') NOT NULL,
Birthdate DATETIME NOT NULL,
Biography NVARCHAR(MAX)
);

INSERT INTO People(Name,Gender,Birthdate) VALUES ('Svetlin','m',1999-03-03);
INSERT INTO People(Name,Gender,Birthdate) VALUES ('Ivana','f',1999-05-05);
INSERT INTO People(Name,Gender,Birthdate) VALUES ('Ivan','m',1999-05-15);
INSERT INTO People(Name,Gender,Birthdate) VALUES ('Ivana','f',1999-11-30);
INSERT INTO People(Name,Gender,Birthdate) VALUES ('Pesho','m',1999-01-01);

USE Minions

CREATE TABLE Users(
Id BIGINT IDENTITY PRIMARY KEY,
UserName VARCHAR(30) UNIQUE NOT NULL,
Password VARCHAR(26) NOT NULL,
ProfilePicture  VARBINARY(MAX),
LastLoginTime DATETIME,
IsDeleted BIT
)

INSERT INTO Users(UserName,Password) VALUES ('WhySoSerious','qjmikura');
INSERT INTO USERS(UserName,Password) VALUES ('Kopele','tuaapo');
INSERT INTO USERS(UserName,Password) VALUES ('Rooney','obichakKurvi');
INSERT INTO USERS(UserName,Password) VALUES ('Ivan','tupoto');
INSERT INTO USERS(UserName,Password) VALUES ('Stavre','prizrako');

ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC07C99493E7]

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id,UserName)

USE Minions

ALTER TABLE Users
ADD CONSTRAINT CHK_PasswordSize
CHECK(Len(Password) >= 5)

ALTER TABLE Users
ADD CONSTRAINT CHK_ProfilePictureSize
CHECK(DATALENGTH(ProfilePicture) <= 900 * 1024)

ALTER TABLE Users
ADD DEFAULT GETDATE()
FOR LastLoginTime


ALTER TABLE Users
ADD CONSTRAINT PK_Id
PRIMARY KEY(Id)
TRUNCATE TABLE Users
SELECT * FROM Users