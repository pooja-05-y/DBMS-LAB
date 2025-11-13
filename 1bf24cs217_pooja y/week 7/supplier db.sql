show databases;
create database supplier;
use supplier;
create table supplier(sid int primary key, sname varchar(50), city varchar(50));

create table parts(pid int primary key, pname varchar(50), color varchar(50));

create table catalog(sid int, pid int, cost decimal(10,2), primary key(sid,pid), 
foreign key(sid) references supplier(sid), foreign key(pid) references parts(pid));

show tables;

insert into supplier values
(10001,'Acme Widget','Bangalore'),(10002,'Johns','Kolkata'),(10003,'Vimal','Mumbai'),
(10004,'Reliance','Delhi');

insert into parts values
(20001,'Book','Red'),(20002,'Pen','Red'),(20003,'Pencil','Green'),
(20004,'Mobile','Green'),(20005,'Charger','Black');

insert into catalog values
(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),
(10001,20005,10),(10002,20001,10),(10002,20002,20),(10003,20003,30),(10004,20003,40);

select * from supplier;
select * from parts;
select * from catalog;

select distinct p.pname from parts p join catalog c on p.pid=c.pid;

select s.sname from supplier s where not exists(select * from parts p where not exists
(select * from catalog c where c.sid=s.sid and c.pid=p.pid));

select s.sname from supplier s where not exists(select * from parts p where p.color='Red' and not exists
(select * from catalog c where c.sid=s.sid and c.pid=p.pid));

select p.pname from parts p where p.pid in(select c.pid from catalog c 
join supplier s on s.sid=c.sid where s.sname='Acme Widget') and 
p.pid not in(select c2.pid from catalog c2 join supplier s2 on s2.sid=c2.sid where s2.sname!='Acme Widget');

select distinct c.sid from catalog c where c.cost>(select avg(c2.cost) from 
catalog c2 where c2.pid=c.pid);

select p.pid, s.sname from parts p join catalog c on p.pid=c.pid join supplier s on 
s.sid=c.sid where c.cost=(select max(c2.cost) from catalog c2 where c2.pid=p.pid);
