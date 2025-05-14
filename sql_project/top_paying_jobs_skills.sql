/*
- Use the top 10 highest_paying Data science jobs from top_paying_jobs query
- Add the specific skills required for these roles
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
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
) 

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
JOIN skills_job_dim USING(job_id)
JOIN skills_dim USING(skill_id)
ORDER BY 
    salary_year_avg DESC 

/*
Most demanded skills for Data scientist in 2023, base on jobs_postings:
Pytho is leading.
SQL follows closely, ...
*/