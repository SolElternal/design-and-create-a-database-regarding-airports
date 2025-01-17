CREATE DATABASE AirportLine;
USE AirportLine;

CREATE TABLE IF NOT EXISTS Airport(
	airportID varchar(255) not null,
    airportName varchar(255) not null,
    road varchar(255) not null,
    province varchar(255) not null,
    district varchar(255) not null,
    subdistrict varchar(255) not null,
    
	primary key (airportID)
);

CREATE TABLE IF NOT EXISTS Companies(
	companyID varchar(255) not null,
    companyName varchar(255) not null,
    road varchar(255) not null,
    province varchar(255) not null,
    district varchar(255) not null,
    subdistrict varchar(255) not null,
    
	primary key (companyID)
    
);

CREATE TABLE IF NOT EXISTS Involvement(
	companyID varchar(255) not null,
    airportID varchar(255) not null,
    
	primary key (companyID, airportID)
);

alter table Involvement
add foreign key (companyID) references Companies (companyID),
add foreign key (airportID) references Airport (airportID);

create table if not exists Airplanes  (
	airplaneID varchar(255) NOT NULL,
    airplaneName varchar(255) NOT NULL,
    Capacity int NOT NULL,
    companyID  varchar(255) NOT NULL,
    PRIMARY KEY (airplaneID),
    FOREIGN KEY (companyID) references Companies(companyID)
);


create table if not exists Flights   (
	flightID	 varchar(255) NOT NULL,
    destination varchar(255) NOT NULL,
    departureTime varchar(255) NOT NULL,
    arrivalTime   varchar(255) NOT NULL,
    airplaneID varchar(255) NOT NULL,
    PRIMARY KEY (flightID),
    FOREIGN KEY (airplaneID) references Airplanes(airplaneID)
);

create table if not exists Employees    (
	EmployeesID varchar(255) NOT NULL,
    EmployeesName varchar(255) NOT NULL,
    WorkSchcedule varchar(255) NOT NULL,
    salary   int NOT NULL,
    JobPositions  varchar(255) NOT NULL,
    PRIMARY KEY (EmployeesID)
);

CREATE TABLE if not exists EmployeesFlight  (
	EmployeesID varchar(255) NOT NULL,
    flightID varchar(255) NOT NULL,
    PRIMARY KEY (EmployeesID,flightID)
);

alter table EmployeesFlight
add foreign key(EmployeesID) references Employees(EmployeesID),
add foreign key(flightID) references Flights(flightID);

#....................................................

create table if not exists Passengers (
	passengerID varchar(10) not null,
    passengerName varchar(255) not null,
    nationality varchar(100) not null,
    weigthBeg int not null,
    primary key (passengerID)
);

create table if not exists Tickets(
	flightID varchar(10) not null,
    passengerID varchar(10) not null,
    check_in varchar(50) not null,
	gate_number int not null,
    type_seat varchar(50) not null,
    seat_number varchar(10) not null,
    Date_Time date not null,
    primary key (flightID,passengerID)
);

alter table Tickets
add foreign key (flightID) references Flights(flightID),
add foreign key (passengerID) references Passengers(passengerID);