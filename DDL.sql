CREATE DATABASE JFAutomobile
GO
USE JFAutomobile
GO

CREATE TABLE [MsCustomer] (
	CustomerID CHAR(6) PRIMARY KEY CHECK (CustomerID LIKE 'CS-[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) CHECK (LEN(CustomerName) >= 5 AND LEN(CustomerName) <= 50) NOT NULL, --1
	CustomerEmail VARCHAR(255) NOT NULL,
	CustomerGender CHAR(6) CHECK (CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female') NOT NULL, --2
	CustomerAddress VARCHAR(255) NOT NULL,
	CustomerPhone VARCHAR(255) NOT NULL
);

CREATE TABLE [MsStaff] (
	StaffID CHAR(6) PRIMARY KEY CHECK (StaffID LIKE 'SF-[0-9][0-9][0-9]'),
	StaffName VARCHAR(255) NOT NULL,
	StaffEmail VARCHAR(255) CHECK (StaffEmail LIKE '%@%') NOT NULL, --3
	StaffGender CHAR(6) NOT NULL,
	StaffAddress VARCHAR(255) NOT NULL,
	StaffPhone VARCHAR(255) NOT NULL
);

CREATE TABLE [MsMechanic] (
	MechanicID CHAR(6) PRIMARY KEY CHECK (MechanicID LIKE 'MC-[0-9][0-9][0-9]'),
	MechanicName VARCHAR(50) NOT NULL,
	MechanicEmail VARCHAR(255) NOT NULL,
	MechanicGender CHAR(6) NOT NULL,
	MechanicAddress VARCHAR(255) CHECK (MechanicAddress LIKE '%street') NOT NULL, --4
	MechanicPhone VARCHAR(255) NOT NULL
);

CREATE TABLE [MsCarBrand] (
	CarBrandID CHAR(6) PRIMARY KEY CHECK (CarBrandID LIKE 'CB-[0-9][0-9][0-9]'),
	CarBrandName VARCHAR(255) NOT NULL,
	CarBrandCountry VARCHAR(13) CHECK(CarBrandCountry LIKE 'Japan' OR CarBrandCountry LIKE 'German' OR CarBrandCountry LIKE 'United States') NOT NULL --5
);

CREATE TABLE [MsCar] (
	CarID CHAR(6) PRIMARY KEY CHECK (CarID LIKE 'CR-[0-9][0-9][0-9]'),
	CarBrandID CHAR(6) FOREIGN KEY REFERENCES MsCarBrand(CarBrandID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CarName VARCHAR(255) CHECK (LEN(CarName) > 0) NOT NULL, --6
	CarPricePerKM FLOAT CHECK(CarPricePerKM >= 2000 AND CarPricePerKM <= 4000) NOT NULL, --7
	CarSeatCapacity INT CHECK(CarSeatCapacity >= 1 AND CarSeatCapacity <= 6) NOT NULL, --8
	CarEngineCapacity INT CHECK(CarEngineCapacity >= 1000 AND CarEngineCapacity <= 3000) NOT NULL, --9
	CarAvailability INT CHECK(CarAvailability = 0 OR CarAvailability = 1) NOT NULL --10
);

CREATE TABLE [TrRentalHeader] (
	RentalID CHAR(6) PRIMARY KEY CHECK (RentalID LIKE 'TR-[0-9][0-9][0-9]'),
	StaffID CHAR(6) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID CHAR(6) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
);

CREATE TABLE [TrRentalDetail] (
	RentalID CHAR(6) FOREIGN KEY REFERENCES TrRentalHeader(RentalID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CarID CHAR(6) FOREIGN KEY REFERENCES MsCar(CarID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	RentalStartDate DATE NOT NULL,
	RentalReturnDate DATE CHECK (DATEDIFF(DAY, RentalReturnDate, GETDATE()) <= 0) NOT NULL, --12
	RentalDistanceTravelled INT CHECK (RentalDistanceTravelled = 0 OR RentalDistanceTravelled > 0) NOT NULL --11
);

CREATE TABLE [MsService] (
	ServiceNameID CHAR(6) PRIMARY KEY CHECK (ServiceNameID LIKE 'SV-[0-9][0-9][0-9]'),
	ServiceName VARCHAR(255) NOT NULL,
	ServicePrice FLOAT CHECK (ServicePrice BETWEEN 100000 AND 1000000) NOT NULL --13
);

CREATE TABLE [TrServiceHeader] (
	ServiceID CHAR(6) PRIMARY KEY CHECK (ServiceID LIKE 'TS-[0-9][0-9][0-9]'),
	StaffID CHAR(6) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	MechanicID CHAR(6) FOREIGN KEY REFERENCES MsMechanic(MechanicID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
);

CREATE TABLE [TrServiceDetail] (
	ServiceNameID CHAR(6) FOREIGN KEY REFERENCES MsService(ServiceNameID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ServiceID CHAR(6) FOREIGN KEY REFERENCES TrServiceHeader(ServiceID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CarID CHAR(6) FOREIGN KEY REFERENCES MsCar(CarID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ServiceDate DATE CHECK (DATEDIFF(DAY, ServiceDate, GETDATE()) <= 0) NOT NULL --14
);



