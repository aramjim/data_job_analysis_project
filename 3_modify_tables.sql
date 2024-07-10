COPY company_dim
FROM '\\mac\iCloud\Education\SQL for Data Analytics\SQL_Project_Data_Job\4_csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM '\\mac\iCloud\Education\SQL for Data Analytics\SQL_Project_Data_Job\4_csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM '\\mac\iCloud\Education\SQL for Data Analytics\SQL_Project_Data_Job\4_csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM '\\mac\iCloud\Education\SQL for Data Analytics\SQL_Project_Data_Job\4_csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
