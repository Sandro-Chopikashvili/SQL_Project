CREATING temporary table (SUBQUERY)
SELECT * 
FROM (
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

#########################################################

WITH january_jobs AS (
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;

#########################################################


SELECT 
    company_id,
    name as company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY 
        company_id
 )

#########################################################


WITH company_job_count AS (
    SELECT 
        company_id,
        COUNT(*) as job_counts
    FROM
        job_postings_fact
    GROUP BY 
        company_id
    ORDER BY
        company_id
)

SELECT 
    cd.name AS company_name,
    cj.job_counts 
FROM 
    company_dim cd
LEFT JOIN 
    company_job_count cj ON cj.company_id = cd.company_id