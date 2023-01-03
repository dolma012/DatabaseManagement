-- Database: DBCompany1

-- DROP DATABASE IF EXISTS "DBCompany1";

CREATE TABLE Employee
(EmployeeID INTEGER,
SSN INTEGER,
EmployeeName VARCHAR(255),
Phone VARCHAR(15),
Email VARCHAR(255),
Address VARCHAR(255),
CONSTRAINT PKEmployee PRIMARY KEY(EmployeeID));

CREATE TABLE Department
(DepartmentID INTEGER,
 DName VARCHAR(255),
 DLocation VARCHAR(255),
 Manager_EmployeeID INTEGER,
CONSTRAINT PKDepartment PRIMARY KEY (DepartmentID),
CONSTRAINT FKDepartment FOREIGN KEY(manager_employeeid) REFERENCES Employee);

ALTER TABLE Employee
ADD COLUMN DepartmentID INTEGER;
ALTER TABLE Employee
ADD CONSTRAINT FKEmployee FOREIGN KEY (DepartmentID) REFERENCES Department;

CREATE TABLE FullTimeEmployee
( EmployeeID INTEGER,
EmployeeSalary Decimal(15,2),
CONSTRAINT PKEmployee1 PRIMARY KEY (EmployeeID),
CONSTRAINT FKEmployee1 FOREIGN KEY (EmployeeID) REFERENCES Employee );
 
CREATE TABLE HourlyEmployee(
EmployeeID INTEGER,
BillinRatePerHour Decimal(15,2),
CONSTRAINT PKHourlyEmployee PRIMARY KEY(EmployeeID),
CONSTRAINT FKHourlyEmployee FOREIGN KEY(EmployeeID) REFERENCES Employee);

CREATE TABLE Consultant(
EmployeeID INTEGER,
PayRate Decimal(15,2),
CONSTRAINT PKConsultant PRIMARY KEY(EmployeeID),
CONSTRAINT FKConsultant FOREIGN KEY(EmployeeID) REFERENCES Employee);

CREATE TABLE Project(
ProjectID INTEGER,
DepartmentID INTEGER,
ProjectTitle VARCHAR(255),
CONSTRAINT PKProject PRIMARY KEY(ProjectID),
CONSTRAINT FKProject FOREIGN KEY(DepartmentID) REFERENCES Department);

CREATE TABLE WorksFor(
ProjectID INTEGER,
EmployeeID INTEGER,
CONSTRAINT PKWorksFor PRIMARY KEY(ProjectID, EmployeeID),
CONSTRAINT FKWorksFor FOREIGN KEY (ProjectID ) REFERENCES Project,
CONSTRAINT FKWorksFor1 FOREIGN KEY (EmployeeID) REFERENCES Employee);
	
CREATE TABLE Dependent(
EmployeeID INTEGER,
DependentName VARCHAR(255),
Gender VARCHAR(10),
Relationship VARCHAR(255),
CONSTRAINT PKDependent PRIMARY KEY(EmployeeID, DependentName),
CONSTRAINT FKDependent FOREIGN KEY(EmployeeID) REFERENCES Employee);