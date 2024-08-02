# Introduction
📊 Dive into the data job market! Focusing on data analyst
roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background:
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others to work to find optimal jobs.

It´s packed with insights on job titles, salaries, locations, and essential skills.

## The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn? 

# Tools I Used:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.

- **PostrgreSQL**: The chosen database management system, ideal for handling the job posting data.

- **Visual Studio Code**: My go-to for database management and executing SQL queries.

- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis:
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here´s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying  roles, I filtered data analyst posotions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_id,
    name AS company_name, -- From company_dim table
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
```
Here´s the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There´s a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](project_sql\assets\1_top_paying_roles.png)

*Bar Graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results.* 

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS ( -- CTE
        SELECT 
            job_id,
            name, -- From company_dim table
            job_title,
            salary_year_avg
        FROM
            job_postings_fact
            LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE
            job_title_short = 'Data Analyst'
            AND job_location = 'Anywhere' -- It can also be used the job_work_from_home = TRUE
            AND salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT 10)
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here´s the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8
- **Python** follows closely with a count of 7
- **Tableau** is also highly sought after, with a bold count of 6
- Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand

![Top Paying Skills based on Job Postings](project_sql\assets\2_top_paying_roles_skills.png)
*Bar Graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here´s the break down of the most demanded skills for data analysts in 2023:
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power Bi** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

|  Skills  | Demand Count |
|----------|--------------|
| SQL      |92628         |
| Excel    |67031         |
| Python   |57326         |
| Tableau  |46554         |
| Power Bi | 39468        |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highes paying.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary -- After the ROUND usage, add a comma and the number of decimal places
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here´s a breakdown of the results for top paying skills for Data Analysts:
- **High-Value Technical Skills**: Proficiency in advanced technical tools such as SVN (legacy systems), Solidity (blockchain), and various machine learning frameworks like Datarobot, Keras, PyTorch, and TensorFlow command top salaries, reflecting their critical role in modern data analysis.

- **DevOps and Data Management**: Expertise in DevOps tools like terraform, puppet, and ansible, alongside database management tools like couchbase and cassandra, is highly lucrative, emphasizing the integration of data analytics with efficient infrastructure management.

- **Collaborative and Communication Tools**: Skills in version control and collaboration platforms such as gitlab, bitbucket, atlassian, and twilio are in demand, highlighting the importance of teamwork and effective communication in data projects.

| Skill         | Average Salary ($) |
|---------------|--------------------|
| 1. svn           | 400,000            |
| 2. solidity      | 179,000            |
| 3. couchbase     | 160,515            |
| 4. datarobot     | 155,486            |
| 5. golang        | 155,000            |
| 6. mxnet         | 149,000            |
| 7. dplyr         | 147,633            |
| 8. vmware        | 147,500            |
| 9. terraform     | 146,734            |
| 10. twilio        | 138,500            |
*Table of average salary for the top 10 paying skills for data analysts

### 5. Most Optimal Skill to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

- **With the combination of two different CTEs**
```sql
WITH skills_demand AS ( -- First CTE
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id),  -- How to combine two different CTES ( , and space without another WITH clause)

average_salary AS ( --Second CTE
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary -- After the ROUND usage, add a comma and the number of decimal places
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT
    25;
```
- **Rewritten in a more concise manner**
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT
    25; 
```
| Skill ID | Skill       | Demand Count | Average Salary ($) |
|----------|-------------|--------------|--------------------|
| 8        | go          | 27           | 115,320            |
| 234      | confluence  | 11           | 114,210            |
| 97       | hadoop      | 22           | 113,193            |
| 80       | snowflake   | 37           | 112,948            |
| 74       | azure       | 34           | 111,225            |
| 77       | bigquery    | 13           | 109,654            |
| 76       | aws         | 32           | 108,317            |
| 4        | java        | 17           | 106,906            |
| 194      | ssis        | 12           | 106,683            |
| 233      | jira        | 20           | 104,918            |

*Table of the top 10 optimal skills for data analyst sorted by salary*

Here´s a breakdow of the most optimal skills for Data Analysts in 2023:
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available

- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.

- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.

- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned:
Throughout this project, I´ve significantly enhanced my SQL toolkit with intermediate-to-advanced capabilities:
- **Complex Query Crafting:** Acquired proficiency in advanced SQL techniques, including the proficient merging of tables and the effective use of WITH clauses for sophisticated temporary table operations.

- **Data Aggregation:** Gained in-depth experience with the GROUP BY statement and utilized aggregate functions such as COUNT and AVG for comprehensive data summarization.

- **Analytical Expertise:** Elevated my practical problem-solving skills by transforming complex questions into actionable and insightful SQL queries.

# Conclusions: 
### Insights
1. **Top Paying Data Analyst Jobs:** The highest-paying data analyst positions offer salaries ranging from $184,000 to $650,000, with prominent employers like SmartAsset, Meta, and AT&T providing diverse job titles and specializations.

2. **Skills for Top Paying Jobs:** SQL, Python, and Tableau are the most sought-after skills, with SQL appearing in 8 high-paying job listings, Python in 7, and Tableau in 6.

3. **In-Demand Skills for Data Analysts:** Core skills include SQL and Excel for foundational data processing, with increasing demand for programming and visualization tools like Python, Tableau, and Power BI, alongside other skills such as R and Snowflake.

4. **Skills Based on Salary:** High-value technical skills such as svn, solidity, and various machine learning frameworks (datarobot, keras, pytorch, tensorflow) command top salaries, while expertise in DevOps, data management tools, and collaborative platforms also yields high compensation.

5. **Most Optimal Skill to Learn:** Python and R are highly demanded programming languages with average salaries around $101,397 and $100,499 respectively; skills in cloud technologies like Snowflake, Azure, and AWS, business intelligence tools like Tableau and Looker, and database technologies are also highly valued.

### Closing Thoughts:
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring Data Analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.