use World
--1
select * from city
where CountryCode = 'EGY';

--2
select * 
from country co inner join city c
on co.Code = c.CountryCode 
where c.population > 5000000;

--3 
select *
from country co inner join countryLanguage cl
on co.Code = cl.CountryCode 
where Language = 'Dutch' and IsOfficial = 0;

--4
select co.Name, IsOfficial
from country co inner join countryLanguage cl
on IsOfficial = 1;

--5 
select * 
from city
where district in( select district from city 
				   group by district
				   having count(*) > 1)
order by district desc;

--6
select c.Name , count(ci.ID) as [Number Of Cities]
from country c inner join city ci
on continent = 'Africa' and c.Code = ci.CountryCode
group by c.Name;

--7
select co.Name, Language
from country co inner join countryLanguage cl
on co.code = cl.CountryCode and cl.IsOfficial = 0;

--8
select co.Name
from country co inner join countryLanguage cl
on co.code = cl.CountryCode and IsOfficial = 1
group by co.Name
having count(IsOfficial) > 1;

--9
select Name, LifeExpectancy
from country
where LifeExpectancy = (select Max(LifeExpectancy) from country  as Max_Expectancy);

--10
select co.Name,  count(c.countrycode) as [Number of Cities]
from country co inner join city c
on co.code = c.countryCode and c.Population > 100000000
group by co.Name;

--11
select co.Name, max(c.Population) as [Max Population]
from country co inner join city c 
on co.code = c.countrycode 
group by co.Name;

--12
create table WaterResource 
(
 ID int primary key identity(1,1),
 CountryCode char(3),
 TypeOf nvarchar(30) not null,
 Name nvarchar(30) not null
 foreign key(CountryCode) references Country(Code)
);
--13
insert into WaterResource(CountryCode, TypeOf, Name)
values
('EGY', 'River', 'El Nile');

