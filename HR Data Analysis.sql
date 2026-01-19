-- 1. Finding gender breakdown of employees in the company;
select gender,count(*) as count
from hr
where age >= 18 and termdate is null
group by gender;


-- 2. Race/ ethnicity breakdown of employees in company
select race, count(*) as count 
from hr 
where age >= 18 and termdate is null
group by race
order by count(*) desc;

-- 3. Age distribution of employees in the company
select 
	min(age) as youngest,
    max(age) as oldest
from hr
where age >= 18 and termdate is null;

select 
	case
		when age >=18 and age <= 24 then '18-24'
        when age >=25 and age <= 34 then '25-34'
        when age >=35 and age <= 44 then '35-44'
        when age >=45 and age <= 54 then '45-54'
        when age >=55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,
count(*) as count
from hr
where age >= 18 and termdate is null
group by age_group
order by age_group;

select 
	case
		when age >=18 and age <= 24 then '18-24'
        when age >=25 and age <= 34 then '25-34'
        when age >=35 and age <= 44 then '35-44'
        when age >=45 and age <= 54 then '45-54'
        when age >=55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,gender,
count(*) as count
from hr
where age >= 18 and termdate is null
group by age_group,gender
order by age_group,gender;

-- 4. How many employees work at headquarter versus remote locations;
select location,count(*) as count
from hr
where age >= 18 and termdate is null
group by location;

-- 5. Average length of employement for employees who have been terminated;
select 
	round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
from hr
where termdate <= curdate() and termdate is not null and age >= 18;

-- 6. How does gender difference vary across departments and job titles;
select department,gender, count(*) as count
from hr
where age >= 18 and termdate is null
group by department,gender
order by department;

-- 7. what is distribution of job titles across the company ?
select jobtitle,count(*) as count
from hr
where age >= 18 and termdate is null
group by jobtitle
order by jobtitle desc;

-- 8. Which department has highest turnover rate?
select department,
	total_count,
    terminated_count,
    terminated_count/total_count as termination_rate
from(
	select department,
    count(*) as total_count,
    sum(case when termdate <= curdate() and termdate is not null then 1 else 0 end) as terminated_count
    from hr
    where age >= 18
    group by department
    ) as subquery
order by termination_rate desc;

-- 9. Distribution of employees across location by cities and state ;
select location_state, count(*) as count
from hr
where age >= 18 and termdate is null
group by location_state 
order by count desc;

-- 10. How has the company's employee count has changed over time based on hire and term dates;
select 
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    (hires - terminations)/hires * 100 as net_change_percent
from(
	select 
		year(hire_date) as year,
        count(*) as hires,
        sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminations
        from hr
        where age >= 18
        group by year(hire_date)
        ) as subquery 
	order by year asc;
    

-- 11 What is tenure distribution for each department;
select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate is not null and termdate <= curdate() and age >= 18
group by department;
