--1
create database student;

create table students
(
StudentID int primary key,
FirstName varchar(50),
LastName varchar(50),
Age int,
Grade varchar(1)
)

--2
insert into students 
values(1,'Eslam','Seadawi',19,'A'),
(2,'Ahmed','Mohamed',19,'C'),
(3,'Eyad','Ali',20,'D'),
(4,'Khaled','Mansi',18,'A'),
(5,'Mona','Adel',20,'A');

--3
select * from students;

select * from students 
where Age < 18;

select * from students
where StudentID = (select Min(StudentID) from students)
union all
select * from students
where StudentID = (select Max(StudentID) from students)

select * from students
where Grade = 'A';
