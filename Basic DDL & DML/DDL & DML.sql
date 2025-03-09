-- Eslam Mohamed El Seadawi
--1
create database Library 

create Table Books
(
BookID int primary key identity(1,1),
Title nvarchar(50) not null,
Author nvarchar (50) not null,
PublishedYear int not null,
Price decimal not null
)

--2
insert into Books
values
('Story Book', 'Eslam Seadawi', 2020, 150.00),
('Science Book', 'Eyad Reda', 1988, 240.00),
('C# Book', 'Mina Adel', 2019, 500.30),
('History of Egypt', 'Zhran Mohemd', 2015, 80.00),
('SQL Server Book', 'Eng.Karim Essam', 2024, 750.50)

--3
update Books
set Price = 1000
where BookID = 5;

delete from Books
where BookID = 3;

select * from Books
order by PublishedYear;

select * from Books
where PublishedYear < 2000
order by PublishedYear desc;