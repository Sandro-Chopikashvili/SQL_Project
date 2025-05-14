/* 
- Look at the avarage salary associated with each skill for Data science positions
- Focuses on roles with specified salaries, regardless of location
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
JOIN 
    skills_job_dim sjd USING(job_id)
JOIN 
    skills_dim sd USING(skill_id)
WHERE 
    job_title_short = 'Data Scientist' AND 
    salary_year_avg IS NOT NULL AND
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25