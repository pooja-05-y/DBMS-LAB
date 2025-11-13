show databases;
create database employee2;
create table dept(deptno int(8) primary key,dname varchar(30),dloc varchar(30));
create table employee(empno int(8) primary key, ename varchar(50), mgr_no int(5), hiredate date, sal decimal(10,2), deptno int(8), foreign key(deptno) references dept(deptno) on update cascade on delete cascade);
create table project(pno int(8) primary key,ploc varchar(30), pname varchar(30));
create table assigned_to(empno int(8), pno int(8), job_role varchar(30), primary key(empno,pno), foreign key(empno) references employee(empno)on update cascade on delete cascade, foreign key(pno) references project(pno)on update cascade on delete cascade);
create table incentives(empno int(8), incentive_date date primary key, incentive_amount decimal(10,2), foreign key(empno) references employee(empno)on update cascade on delete cascade);
drop table assigned_to;

 insert into dept values(01,'aa','bengaluru'),(02,'bb','hyderabad'),(03,'cc','mysuru'),(04,'dd','chenai'),(05,'ee','bengaluru');
 select * from dept;
insert into employee values(101,'abc',NULL,'2020-10-15',55000,01),(102,'def',101,'2021-04-15',62000,02),(103,'ghi',102,'2020-09-05',70000,03),(104,'jkl',101,'2019-11-19',58000,04),(105,'mno',102,'2022-01-01',50000,05);
use employee2;
show tables;
insert into project values(1,'bengaluru','p1'),(2,'hyderabad','p2'),(3,'mysuru','p3'),(4,'chennai','p4'),(5,'bengaluru','p5');
update dept set dloc='chennai' where dloc='chenai';
select * from dept;
insert into assigned_to values(101,1,'a1'),(102,2,'a2'),(103,3,'a3'),(104,4,'a4'),(105,5,'a5');
insert into incentives values(101,'2023-03-09',2000),(102,'2023-06-12',3000),(103,'2023-01-05',1500),(104,'2023-07-19',2500),(105,'2023-09-11',1800);

select m.ename, count(e.empno) as team_size from employee e join employee m on e.mgr_no = m.empno group by m.empno, m.ename order by team_size desc;

select e.empno from employee e, dept d where e.deptno=d.deptno and dloc in ('bengaluru','hyderabad','mysuru');

select e.empno from employee e left join incentives i on e.empno=i.empno where i.empno IS NULL;

select e.ename, e.empno, d.dname, a.job_role, d.dloc, p.ploc from employee e join dept d on e.deptno=d.deptno join assigned_to a on a.empno=e.empno join project p on p.pno=a.pno where d.dloc=p.ploc;


select m.ename, count(e.empno) as team_size from employee e join employee m on e.mgr_no = m.empno group by m.empno, m.ename order by team_size desc;
    
select d.deptno, d.dname, e.empno, e.ename from employee as e join dept as d on d.deptno = e.deptno where e.mgr_no in (select empno from employee where mgr_no IS NULL) order by d.deptno, e.empno;
    
select m.empno, m.ename, m.sal from employee m where m.empno in (select distinct mgr_no from employee) and m.sal > (select avg(e.sal) from employee e where e.mgr_no = m.empno);    

select empno, ename from employee where mgr_no in (select empno from employee where mgr_no IS NULL) order by empno;

select e.empno, e.ename, i.incentive_amount from employee e join incentives i on e.empno = i.empno where i.incentive_date between '2019-01-01' and '2019-01-31' order by i.incentive_amount desc limit 1 offset 1;    
    
insert into employee values(106,'pqr',101,'2019-01-02',25000,04);
select * from employee;

select * from incentives;
insert into incentives values(106,'2019-01-21',6000),(106,'2019-01-11',5000);
select e.empno, e.ename, i.incentive_amount from employee e join incentives i on e.empno = i.empno where i.incentive_date between '2019-01-01' and '2019-01-31' order by i.incentive_amount desc limit 1 offset 1;    

select e.empno, e.ename, e.deptno from employee e join employee m on m.empno = e.mgr_no where e.deptno = m.deptno;
insert into employee values(107,'stu',101,'2019-01-02',25000,01);