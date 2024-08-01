/*
Question: What are the top skills based on salary?
    - Look at the average salary associated with each skill for Data Analyst positions
    - Focuses on roles with specified salaries, regardless of location
    - Why? It reveals how different skills impact salary levels for Data Analysts and helps
    identify the most financially rewarding skills to acquire or improve
*/

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

/* Analytical Insights:

- High-Value Technical Skills: Proficiency in advanced technical tools such as svn (legacy systems),
solidity (blockchain), and various machine learning frameworks like datarobot, keras, pytorch, and
tensorflow command top salaries, reflecting their critical role in modern data analysis.

- DevOps and Data Management: Expertise in DevOps tools like terraform, puppet, and ansible, alongside
database management tools like couchbase and cassandra, is highly lucrative, emphasizing the integration
of data analytics with efficient infrastructure management.

- Collaborative and Communication Tools: Skills in version control and collaboration platforms such as
gitlab, bitbucket, atlassian, and twilio are in demand, highlighting the importance of teamwork
and effective communication in data projects.