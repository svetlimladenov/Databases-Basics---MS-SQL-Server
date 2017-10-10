CREATE TABLE Employees(
	Id INT IDENTITY PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Projects (
	Id INT IDENTITY PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
)

CREATE TABLE EmployeesProjects(
	EmployeeId INT,
	ProjectId INT,

	CONSTRAINT PK_EmpProjects
	PRIMARY KEY (EmployeeId,ProjectId),

	CONSTRAINT FK_EmployeesProject_Employees
	FOREIGN KEY (EmployeeId)
	REFERENCES Employees(Id) ON DELETE CASCADE,

	CONSTRAINT FK_EmployeesProject_Project
	FOREIGN KEY (ProjectId)
	REFERENCES Projects(Id) ON DELETE CASCADE
)

INSERT INTO Employees (Name) VALUES
('Ivan'),
('Gosho na kirilica'),
('Svetlin')

INSERT INTO Projects(Name) VALUES
('MySQLProjet'),
('SuperJava2'),
('Microsoft Hell')


INSERT INTO EmployeesProjects VALUES
(1,1),
(1,3),
(2,3),
(3,1)

SELECT e.Name,p.Name FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeId = e.Id
JOIN Projects AS p ON p.Id = ep.ProjectId

DELETE FROM Employees
WHERE Id = 1