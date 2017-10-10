CREATE TABLE Mountains(
Id INT IDENTITY PRIMARY KEY,
NAME VARCHAR(50) NOT NULL,
)
CREATE TABLE Peaks(
Id INT IDENTITY PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
MountainId INT FOREIGN KEY REFERENCES Mountains(Id) NOT NULL,
)

INSERT INTO Mountains(Name) VALUES
('Rila'),
('Mountains')


INSERT INTO Peaks(Name,MountainId) VALUES
('Musala',1),
('Malyovica',1),
('Vihren',2),
('Kutelo',2)

