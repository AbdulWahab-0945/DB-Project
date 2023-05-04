create database DBProject;
use DBProject;



create table StudentInfo
(
"Name" varchar (20),
"Password" varchar(20),
id int Primary key not null,
"Address" varchar(50),
Number varchar(15) unique
)

create table CurrentUsers
(
id int foreign key references StudentInfo(id)
)

create Table BooksIssued
(
BookID int foreign key references AllBooks(BookID),
BookName varchar (20),
id int not null
)

create table "login"
(
id  int Foreign key references StudentInfo(id) ,
"Password"  varchar(20)
)

Create table AllBooks
(
"Name" varchar(50),
BookID int primary key not null,
"NameOfAuthor" varchar(30),
"NameOfPublisher" varchar(30)
)


create Table BooksAvailable
(
"Name" varchar(50),
BookID int foreign key references AllBooks(BookID)
)

CREATE TABLE Membership
(
ID int foreign key references StudentInfo(id)
)

create Table DueDate
(
BookID int foreign key references AllBooks(BookID),
DueDate date
)

INSERT INTO StudentInfo
VALUES
('Ahmed','Ahmed12',01,'Faisal Town Lahore','01234'),
('Ali','Ali12',02,'Muslim Town Lahore','0011'),
('Amir','Amir1234',03,'DHA Phase 1','0122')
GO


INSERT INTO AllBooks
VALUES
('Theory of Automata',101,'Sipser','Cambridge'),
('Design and Algorithm',102,'Ali','IGCSE'),
('Cognitive Research',103,'Amir','Collins')
GO


INSERT INTO DueDate
values
(102,'2022-6-20'),
(103,'2022-6-17')
GO



Insert INTO BooksAvailable
values
('Theory of Automata',101)


INSERT INTO Membership
VALUES
(01),
(02)


------------PROCEDURES-----------


--Login Procedure

create procedure LoginProc @password varchar(20), @id int 
as begin

select id from StudentInfo where StudentInfo.id=@id and Password=@password
end
GO
execute LoginProc 'Ahmed12',1

DROP procedure LoginProc


---Membership

create Procedure ADDMEMBER @id int
as begin
INSERT INTO Membership
VALUES
(@id)
end
GO
Execute ADDMEMBER 03

--drop Procedure ADDMEMBER



--AddStudent
create Procedure ADDSTUDENTS @name varchar(20),@password varchar(20), @id int, @address varchar(50), @number varchar(15)
as begin
INSERT INTO StudentInfo
values
(@name,@password,@id,@address,@number)
end
GO
Execute ADDSTUDENTS 'Abdul','Abdul111',4,'DHA PHASE 7','030983'

--drop Procedure ADDSTUDENTS

create Procedure ShowIssuedBooks @id int
as begin
select BooksIssued.BookName,BooksIssued.BookID from BooksIssued where BooksIssued.id=@id 
end
GO

execute ShowIssuedBooks 01

--ShowMembers
create Procedure SHOWMEMBERS @id int
as begin
Select Name,id from StudentInfo where StudentInfo.id=@id
end 
GO
Execute SHOWMEMBERS 01

drop Procedure SHOWMEMBERS 



------------------VIEWS----------------------


---DUE DATE---

create view [DUE_DATE] 
AS
Select AllBooks.Name, AllBooks.BookID,DueDate.DueDate from AllBooks left join DueDate on DueDate.BookID=AllBooks.BookID
Intersect
Select AllBooks.Name, AllBooks.BookID,DueDate.DueDate from AllBooks  right join DueDate on DueDate.BookID=AllBooks.BookID 

--drop view [DUE_DATE]
--select * from [DUE_DATE]


select * from BooksAvailable

create view [IssuedBooks]
as 
select BooksIssued.BookName from BooksIssued where BooksIssued.id in (select CurrentUsers.id from CurrentUsers)

--select * from [IssuedBooks]
drop view [IssuedBooks]



create view [Available_Books]
AS
Select * from BooksAvailable

select * from [Available_Books]
drop view [Available_Books]







-------------TESTING----------


select * from CurrentUsers;
select * from BooksIssued;

truncate table BooksIssued
truncate table CurrentUsers

select * from StudentInfo

