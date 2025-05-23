/*
- Identify the top 10 highest-paying Data science roles that are avaliable remotely
- Focuses on jobs postings with specified salaries (remove nulls)
- Highlight the top-paying opportunities for Data scientist.
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN 
    company_dim USING(company_id)
WHERE 
    job_title_short = 'Data Scientist' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
