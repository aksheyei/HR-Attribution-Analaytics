use hr;
select * from hr_dataset;
-- total number of employees

select count(*) as totalemployees
from hr_dataset;
-- gender wise

select 
gender,
count(*) as employees
from hr_dataset
group by gender;

-- eductation level
select distinct education_level 
from hr_dataset;

-- states
select distinct state 
from hr_dataset;

-- department
select distinct department
from hr_dataset;

-- jon titles

select distinct job_title 
from hr_dataset;

-- number of active employees

select count(*) as active_employees
from hr_dataset
where Attribution ='no';

-- department wise employees
select 
department,
count(*) as employees
from hr_dataset
group by department
order by count(*) desc;

-- education level wise employees
select 
Education_Level,
count(*) as employees
from hr_dataset
group by Education_Level
order by count(*) desc;

-- average salary for each deparmt
select department,
avg(salary) as avg_salary
from hr_dataset
group by Department;

-- adding new column for age

ALTER TABLE hr_dataset
ADD age INT;

UPDATE hr_dataset
SET age = TIMESTAMPDIFF(YEAR, birthdate,'2024-12-31');

-- count of attributed employees

select count(*) as attributed_employees
from hr_dataset
where Attribution = 'yes';

-- department wise active and attributed employees count

select 
department,
count(*) as employees,
sum(case
when Attribution = 'yes' then'1'
when Attribution = 'no' then '0'
end) as attributed_employees
from hr_dataset
group by department
order by Department;

-- education level wise attributed and total employees

select 
Education_Level,
count(*) as employees,
sum(case
when Attribution = 'yes' then'1'
when Attribution = 'no' then '0'
end) as attributed_employees
from hr_dataset
group by Education_Level
order by Education_Level;

-- performance wise attribution

select performance_rating,
count(*) as attributed_employees
from hr_dataset
where Attribution = 'yes'
group by Performance_Rating;

-- minimum and maximum age
select min(age) as min_age,
max(age) as max_age
from hr_dataset;

-- creating age group

alter table hr_dataset
add age_group int;

ALTER TABLE hr_dataset
MODIFY age_group VARCHAR(10);

update hr_dataset
set age_group = 
case
when age<=35 then '20-35'
when age<=50 then '36-50'
when age>50  then '50+'
end;

select * from hr_dataset;

-- age group wise attributed employees

select age_group,
count(*) as attributed_employees
from hr_dataset
where Attribution = 'yes'
group by age_group;

-- minimum and maximum salary for each departments

select 
department,
min(salary) as min_salary,
max(salary) as max_salary
from hr_dataset
group by department;

-- number of years company hiring employees

select min(hiredate) as startdate,
max(hiredate) as latestdate,
timestampdiff(year,min(hiredate),max(hiredate) ) as hiring_years
from hr_dataset;

-- year wise attributed employees

select year(termdate) as years,
count(*) as attributed_employees
from hr_dataset
where Attribution ='yes'
group by years
order by years;

-- jobtitle wise attribution
select job_title,
count(*) as attributed_employees
from hr_dataset
where Attribution ='yes'
group by job_title
order by count(*) desc;

-- ranking top 3 departments which have high attributions

with rankwise as 
(
select department,
count(*) as attributed_employees
from hr_dataset
where Attribution ='yes'
group by department
order by count(*) desc)

select department,
rank() over(order by attributed_employees desc) as ranked
from rankwise
group by department
order by ranked 
limit 3;

-- educational level wise attribution rank

with educationrank as 
(
select Education_Level,
count(*) as attributed_employees
from hr_dataset
where Attribution ='yes'
group by Education_Level
order by count(*) desc)

select education_level,
rank() over (order by attributed_employees desc) as ranked
from educationrank
group by education_level
order by ranked ;

-- count of employees whos working more than 5 years in this company

with above5 as
(
select first_name,
last_name,
department,
hiredate,
timestampdiff(year,hiredate,'2024-12-31') as working_years
from hr_dataset
having working_years >5
)

select count(*) as above5_year_working
from above5;

-- ranking based on performance rating attribution

with rating as
(
select performance_rating,
count(*) attributed_employees
from hr_dataset
where Attribution ='yes'
group by Performance_Rating
)

select performance_rating,
rank() over (order by attributed_employees desc) as ranked
from rating;

-- attribution % by department

select department,
count(*) as total_employees,
sum(case
when Attribution = 'yes' then'1'
when Attribution = 'no' then '0'
end) as attributed_employees,
sum(case
when Attribution = 'yes' then'1'
when Attribution = 'no' then '0'
end)/count(*)*100 as attribution_rate
from hr_dataset
group by Department
;



with gap as
(
select termdate,
lag(termdate,1) over( order by termdate) as previous_term_date
from hr_dataset
where termdate is not null
order by termdate
)

select termdate,
previous_term_date,
timestampdiff(day,previous_term_date,termdate) as days_gap
from gap;



