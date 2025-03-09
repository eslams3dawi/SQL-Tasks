	-- how to set the database in specific path
create database test
on
(
	name = test
	filename = 'C:\Sql path.MDF', -- Primary has tables
	size = 50 --MB -- initial 
	maxsize = 150,
	filegrowth = 5MB -- growth when full by 5MB
)
log on -- create the logs file 
(
	name = test
	filename = 'C:\Sql path.LDF',
	size = 50 --MB
	maxsize = 100,
	filegrowth = 5MB -- growth when full by 5MB
)
-- MDF → when is full → NDF (Secondary) 
-- LDF → store all logs 



--create the table in specific schema
create table schemaName.TableName ( );


-- references of FK 
foreign key DID references Employee(EID) on delete cascade on cascade -- on delete cascade on cascade delete and upadate easily 

-- unique keyword → email unique 

-- composite PK 
primary key(key1, key2)

-- case 
select price, productName -- case → if , else  
case
	when price > 500 then 'high'
	when price between 300 and 500 then 'low'
	else 'very low'
end as 'range'

from products 
order by 'range'


-- offset → magination → skip rows 
select price
from products 
order by price desc 
offset 5 rows fetch next 10 rows only
-- fetch → skip and show only the next rows


--


