# Workforce Attrition Intelligence: HR Data Analysis
## 📊 Project Overview
This project provides a comprehensive diagnostic of an organization's workforce, analyzing a dataset of 8,950 employees. The primary objective was to identify the root causes of employee attrition and provide data-driven insights to improve retention strategies. Using SQL, I performed extensive data cleaning, demographic segmentation, and advanced performance-linked turnover analysis.

## 🛠️ Technical Stack & Skills
Database: MySQL.

Key SQL Techniques:

Data Cleaning: Used ALTER and UPDATE to engineer new features like age and age_group.

Advanced Logic: Implemented CTEs, Window Functions (RANK(), LAG()), and complex CASE statements.

Aggregations: Performed multi-level grouping to calculate department and education-wise metrics.

## 🔍 Key Insights & Findings
### 1. Workforce Composition
Total Headcount: 8,950 employees.

Gender Split: 4,801 Male and 4,149 Female employees.

Education Profile: The majority of the workforce (5,416) holds a Bachelor's degree.

Active Status: There are currently 7,984 active employees within the organization.

### 2. Attrition Analysis (The "Why")
Top Attrition Departments: Operations (289) and Sales (201) experienced the highest volume of departures.

The Performance Paradox: Employees rated as "Good" showed the highest attrition count (362), surpassing even the "Excellent" and "Satisfactory" categories.

Age Risk Group: The 36-50 age bracket is the most volatile, with 397 attributed employees.

Education Impact: Bachelor's degree holders represent the highest volume of attrition at 607 individuals.

## 💻 Featured SQL Logic
One of the most impactful queries in this project was the Attribution Rate by Department, which identifies the percentage of turnover relative to department size:

SQL
select department,
count(*) as total_employees,
sum(case
    when Attribution = 'yes' then 1
    when Attribution = 'no' then 0
end) as attributed_employees,
(sum(case when Attribution = 'yes' then 1 else 0 end)/count(*))*100 as attribution_rate
from hr_dataset
group by Department;
## 📂 Repository Structure
hr_analytics_sql.sql: The complete SQL script containing data cleaning, transformation, and analytical queries.

Screenshots/: Folder containing visual evidence of query result grids and data outputs.

## 📌 Strategic Recommendations
Retention Focus: HR should investigate the "Good" performance tier, as mid-to-high potential employees are leaving at the highest rate.

Operations Audit: Conduct stay interviews within the Operations department to address the high volume of exits (289 employees).

Mid-Career Engagement: Develop specific benefits or growth paths for the 36-50 age group to reduce their high turnover rate (397 employees).
