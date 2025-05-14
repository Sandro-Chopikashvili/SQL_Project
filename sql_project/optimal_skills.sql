/*
- Identify skills in high demand and associated with high avarage salaries for Data science roles 
- Concentrates on remote positions with specified salaries
*/


WITH skills_demand AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM 
        job_postings_fact jpf
    JOIN 
        skills_job_dim sjd ON sjd.job_id = jpf.job_id
    JOIN 
        skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE 
        job_title_short = 'Data Scientist' AND 
        salary_year_avg IS NOT NULL AND 
        job_work_from_home = True
    GROUP BY 
        sd.skill_id
),
average_salary AS (
    SELECT 
        sjd.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact jpf
    JOIN 
        skills_job_dim sjd ON sjd.job_id = jpf.job_id
    JOIN 
        skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE 
        job_title_short = 'Data Scientist' AND 
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY 
        sjd.skill_id
)

SELECT 
    sd.skill_id,
    sd.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand sd
JOIN average_salary a ON sd.skill_id = a.skill_id
WHERE demand_count > 10
ORDER BY 
    demand_count DESC, 
    avg_salary DESC
LIMIT 25;



-- Rewriting this same query more concisely



SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.Job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;