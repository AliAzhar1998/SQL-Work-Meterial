create database triggers;
use triggers;

show tables;
SET SQL_SAFE_UPDATES = 0;
# before insert trigger

create table customers
(cust_id int, age int, name varchar(30));

delimiter //
create trigger age_verify
before insert on customers
for each row
if new.age < 0 then set new.age = 0;
end if;//

insert into customers
values(101,27,"James"),
(102,-40,"Ammy"),
(103,32,"Ben"),
(104,-39,"Angela");

select * from customers;

#after insert trigger

create table customers1(
id int auto_increment primary key,
name varchar(40)not null,
email varchar(30),birthdate date);
select * from customers1;

select * from customers;

Delimiter //
create trigger
check_null_dob
after insert
on customers1
for each row
begin
if new.birthdate is null then
insert into message(messageId,message)
values(new.id,concat('Hi',new.name,', please update your data of birth.'));
end if;
end //
delimiter ;

insert into customers1(name,email,birthdate)
values("Nancy","nancy@abc.com",NULL),
("Ronald","ronald@xyz.com","1998-11-16"),
("Chris","chris@xyz.com","1997-08-20"),
("Alice","alice@anc.com",NULL);
select * from customers1;

#before update

create table employees
(emp_id int primary key,
emp_name varchar(25),age int,salary float);

insert into employees values
(101,'Jimmy',35,70000),
(102,'Shane',30,55000),
(103,'Marry',28,62000),
(104,'Dwayne',37,57000),
(105,'Sara',32,72000),
(106,'Ammy',35,80000),
(107,'Jack',40,100000);
select * from employees;

Delimiter //
create trigger upd_trigger
before update
on employees
for each row
begin
if new.salary = 10000 then
set new.salary = 85000;
elseif new.salary < 10000 then
set new.salary = 72000;
end if;
end//
delimiter ;

update employees
set salary = 8000;
select * from employees;

# before delete

create table salary
(e_id int primary key,
validfrom date not null,
amount float not null);

insert into salary 
values(101,'2005-05-01',55000),
(102,'2007-08-01',68000),
(103,'2006-09-01',75000);
select * from salary;

create table salary_del(id int primary key auto_increment,
e_id int,validfrom date not null,
amount float not null,
deletedat timestamp default now());

delimiter //
create trigger salary_delete
before delete
on salary
for each row
begin
insert into salarydel(e_id,validfrom,amount)
values(old.e_id,old.validfrom,old.amount);
end //
delimiter ;
delete from salary
where e_id =10;
select * from salary_del;