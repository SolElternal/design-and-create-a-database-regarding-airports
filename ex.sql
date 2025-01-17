create database bookstore;

use bookstore;

create table if not exists typeBook(
	typeID int not null,
    typeName varchar(255) not null,
    primary key (typeID)
);

create table if not exists customerDetails (
	cusID int not null,
    cusName varchar(255) not null,
    cusLastname varchar(255) not null,
    homeID int not null,
    tumburon varchar(255) not null,
    aumper varchar(255) not null,
    jungwat varchar(255) not null,
    postID int not null,
    primary key (cusID)
);

create table if not exists bookDetails(
	bookID int not null,
    bookName varchar(255) not null,
    price int not null,
    typeID int not null,
    primary key (bookID),
    foreign key (typeID) references typeBook(typeID)
);

create table if not exists buying(
	cusID int not null,
    bookID int not null,
    sumOfbuy int not null,
    primary key (cusID,bookID)
);

alter table buying
add foreign key (cusID) references customerDetails(cusID),
add foreign key (bookID) references bookDetails(bookID)