/* 
Question: What are the top-paying data analyst jobs?
    - Identify the top 10 highest-paying Data Analyst Roles that are available remotely
    - Focuses on job postings with specified salaries (remove data records without information)
    - Add the company name to identify which company is alligned with our interests
    - Why? Highlight the top-paying opportunities for Data Analysts
*/

SELECT 
    job_id,
    name, -- From company_dim table
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere' -- It can also be used the job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
