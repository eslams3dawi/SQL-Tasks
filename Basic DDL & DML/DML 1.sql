use World
--1
select * from Country;

--2
select distinct * 
from CountryLanguage;

--3
select distinct * 
from Country
where Continent  = 'Africa'
order by Code;

--4
select distinct * 
from City 
where Population > 2000000
order by Name;

--5
select distinct *
from Country 
where IndepYear between '1920' and '1990' 
order by IndepYear;

--6
select distinct *
from Country
where IndepYear is NULL;

--7
select distinct *
from Country 
where GovernmentForm != 'Republic';

--8
select distinct * 
from Country
where Continent = 'Asia' and Population > 100000000;

--9
select distinct Code
from Country c inner join CountryLanguage cl
on c.code = cl.CountryCode and cl.IsOfficial = 1;

--10 
select CountryCode
from CountryLanguage 
group by CountryCode
having Count(Language) > 2;

--11
select sum(cast(Population as bigint))
from Country;

--12
select Continent, sum(cast(Population as bigint)) as Total_Population, count(Code) as Total_Countries
from Country
group by Continent
order by Total_Countries;

--13
insert into Country
values
('MTA', 'Meta', 'Europe', 'Southern Europe', 6018, 2024,5, 11.2, 101, NULL, 'Meta', 'Republic', 'Eslam Seadawi', 22, 'MV');

insert into City
values
(5000, 'Virtual Place', 'MTA', 'Virtual District', 3);

insert into CountryLanguage 
values
('MTA', 'Sharqawy', 0, 30.05)

--14
update Country
set LifeExpectancy += 5;

--15
delete from Country  
where Name = 'Egypt'
-- conflict with reference constraint FK_Citr_Country1 !




























