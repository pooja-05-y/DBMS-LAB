show databases;
create database bank2;
use bank2;
create table branch(branch_name varchar(100) primary key, branch_city varchar(100), assets real);
create table bankaccount(accno int(8) primary key,branch_name varchar(100),balance real,foreign key(branch_name) references branch(branch_name));
create table bankcustomer(customer_name varchar(100), customer_street varchar(100), customer_city varchar(100));
drop table bankcustomer;
create table depositer(customer_name varchar(100) primary key, accno int(8), foreign key(accno) references bankaccount(accno));
create table bankcustomer(customer_name varchar(100), customer_street varchar(100), customer_city varchar(100), foreign key(customer_name) references depositer(customer_name));
create table loan(loan_number int(8), branch_name varchar(100), amount int(8), foreign key(branch_name) references branch(branch_name));
insert into branch values
('SBI_Chamrajpet','Bangalore',50000),
('SBI_ResidencyRoad','Bangalore',100000),
('SBI_ShivajiRoad','Bombay',20000),
('SBI_ParlimentRoad','Delhi',100000),
('SBI_Jantarmantar','Delhi',20000);
select * from branch;
insert into bankaccount values
(1,'SBI_Chamrajpet',2000),
(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),
(4,'SBI_ParlimentRoad',9000),
(5,'SBI_Jantarmantar',8000),
(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),
(9,'SBI_ParlimentRoad',3000),
(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);
select * from bankaccount;
insert into depositer values
('Avinash',1),
('Dinesh',2),
('Nikil',4),
('Ravi',5),
('Avinash',8),
('Nikil',9),
('Dinesh',10),
('Nikil',11);
insert into bankcustomer values
('Avinash','Bull_Temple_Road','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),
('Nikil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');
insert into loan values
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParlimentRoad',4000),
(5,'SBI_Jantarmantar',5000);
drop table bankcustomer;
drop table depositer;
create table bankcustomer(customer_name varchar(100) primary key, customer_street varchar(100), customer_city varchar(100));
create table depositer(customer_name varchar(100), accno int(8), foreign key(accno) references bankaccount(accno), foreign key(customer_name) references bankcustomer(customer_name));
drop table branch;
update branch set assets=10000 where assets=100000;
select * from branch;
select * from bankaccount;
select * from bankcustomer;
select * from depositer;
select * from loan;
select branch_name,(assets/100000) from branch;
select branch_name,(assets/100000) as 'assets in lakhs' from branch;
select customer_name from depositer where count(customer_name)>1 group by customer_name;
select count(customer_name) from depositer group by customer_name;
select customer_name from depositer where count(customer_name)>(select count(customer_name) from depositer group by customer_name);
select d.customer_name,b.branch_name,count(*) as num_accounts
from depositer d join bankaccount b on d.accno=b.accno
group by d.customer_name,b.branch_name having count(*)>1;
select * from depositer;
select d.customer_name
select d.customer_name,b.branch_name,count(*) as 'no_of_accounts' from depositer d join bankaccount b on d.accno=b.accno group by d.customer_name,b.branch_name having count(*)>=2;

CREATE VIEW view_name
AS SELECT column1, column2.....
FROM table_name
WHERE [condition];

create view sum_amount as select branch_name, sum(amount) as total_amount from loan group by branch_name;
select * from sum_amount;

create view sum_amount2 as select branch_name, sum(balance) as total_amount from bankaccount group by branch_name;
select * from sum_amount2;