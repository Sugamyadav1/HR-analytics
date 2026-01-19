create database projects;
use projects;

select * from hr;

alter table hr
change column ï»¿id emp_id varchar(20) null;

select * from hr;

describe hr;

select birthdate from hr;

set sql_safe_updates = 0;

update hr
set birthdate = case
	when birthdate like '%/%' then date_format((str_to_date(birthdate,'%m/%d/%Y')),'%Y-%m-%d')
	when birthdate like '%-%' then date_format((str_to_date(birthdate,'%m-%d-%Y')),'%Y-%m-%d')
	else null
end;


alter table hr
modify column birthdate date;

describe hr;
select birthdate from hr;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format((str_to_date(hire_date,'%m/%d/%Y')),'%Y-%m-%d')
	when hire_date like '%-%' then date_format((str_to_date(hire_date,'%m-%d-%Y')),'%Y-%m-%d')
	else null
end;

select hire_date from hr;

alter table hr
modify column hire_date date;

select termdate from hr;

UPDATE hr
SET termdate = NULL
WHERE termdate = '';


UPDATE hr
SET termdate = STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')
WHERE termdate IS NOT NULL;


select termdate from hr;

ALTER TABLE hr 
MODIFY COLUMN termdate DATE;

select * from hr;

alter table hr add column age int;

update hr
set age = timestampdiff(YEAR,birthdate,CURDATE());

select birthdate,age from hr;

select 
	min(age) as youngest,
    max(age) as oldest 
    from hr;
    
select count(*) from hr where age < 18;
