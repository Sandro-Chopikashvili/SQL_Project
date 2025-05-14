/*
- Join job postings to inner join table similar to top_paying_jobs_skills
- Identify the top 5 in-demand skills for a Data scientist
*/

SELECT 
    skills,
    COUNT(sjd.job_id) AS demand_count
FROM 
    job_postings_fact
JOIN 
    skills_job_dim sjd USING(job_id)
JOIN 
    skills_dim sd USING(skill_id)
WHERE 
    job_title_short = 'Data Scientist' AND 
    job_work_from_home = True
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5
