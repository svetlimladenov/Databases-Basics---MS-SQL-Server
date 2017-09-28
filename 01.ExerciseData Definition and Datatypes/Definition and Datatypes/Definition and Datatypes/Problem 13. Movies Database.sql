CREATE DATABASE Movies

USE Movies

CREATE TABLE Directors(
Id INT IDENTITY PRIMARY KEY,
DirectorName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(MAX) 
)

CREATE TABLE Genres(
Id INT IDENTITY PRIMARY KEY,
GenreName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Categories(
Id INT IDENTITY PRIMARY KEY,
CategoryName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Movies(
Id INT IDENTITY PRIMARY KEY,
Title NVARCHAR(100) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
CopyrightYear INT NOT NULL,
Length INT NOT NULL,
GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Rating INT NOT NULL,
Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName) VALUES
('Svetlin'),
('Kalina'),
('Emil'),
('Ivan'),
('Gosho')

INSERT INTO Genres(GenreName) VALUES
('Action'),
('Drama'),
('Comedy'),
('Sci-fy'),
('Crime')

INSERT INTO Categories(CategoryName) VALUES
('Animation'),
('Anime'),
('Horror'),
('Funny'),
('Historical')


INSERT INTO Movies(Title,DirectorId,CopyrightYear,Length,GenreId,CategoryId,Rating) VALUES 
(' The Shawshank Redemption',1,1994,134,1,5,10),
('Fight Club',2,1999,124,1,4,9),
('Forrest Gump',3,1994,165,3,3,10),
('Inception ',4,2002,111,5,1,7),
('The Matrix',5,1999,155,4,3,10)