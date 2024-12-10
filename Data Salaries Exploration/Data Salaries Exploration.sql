SELECT *
FROM SalaryDataset;

--Basic Overview of the Dataset
SELECT COUNT(*) AS total_rows, 
       COUNT(DISTINCT Company_Name) AS total_companies,
       COUNT(DISTINCT Job_Title) AS total_job_titles,
       COUNT(DISTINCT Location) AS total_locations
FROM SalaryDataset;

--Average Salary by Job Title
SELECT "Job Title", 
       AVG(Salary) AS avg_salary
FROM SalaryDataset
GROUP BY "Job Title"
ORDER BY avg_salary DESC;

--Average Salary by Location
SELECT Location, 
       AVG(Salary) AS avg_salary
FROM SalaryDataset
GROUP BY Location
ORDER BY avg_salary DESC;

--Top 10 Companies with the Highest Salaries
SELECT TOP 10 "Company Name", 
       AVG(Salary) AS avg_salary
FROM SalaryDataset
GROUP BY "Company Name"
ORDER BY avg_salary DESC;

-- Total Number of Salaries Reported by Company
SELECT "Company Name", 
       SUM("Salaries Reported") AS total_salaries_reported
FROM SalaryDataset
GROUP BY "Company Name"
ORDER BY total_salaries_reported DESC;

--Salary Distribution for a Specific Job Title
SELECT Salary
FROM SalaryDataset
WHERE "Job Title" = 'Data Analyst'
ORDER BY Salary;

--Max an Min Salary per job
SELECT "Job Title", 
       MAX(Salary) AS max_salary, 
       MIN(Salary) AS min_salary
FROM SalaryDataset
GROUP BY "Job Title";

--Salary Stats by location
SELECT Location, 
       COUNT(*) AS num_of_salaries, 
       AVG(Salary) AS avg_salary, 
       MAX(Salary) AS max_salary, 
       MIN(Salary) AS min_salary
FROM SalaryDataset
GROUP BY Location
ORDER BY num_of_salaries DESC;







