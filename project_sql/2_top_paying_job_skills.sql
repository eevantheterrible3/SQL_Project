
with top_paying_jobs AS
(
    select 
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name as company_name
    FROM    
        job_postings_fact
    left join company_dim on company_dim.company_id = job_postings_fact.company_id
    where   
        job_title_short = 'Data Analyst' and 
        job_location = 'Anywhere' AND
        salary_year_avg is not null
    ORDER BY
        salary_year_avg desc
    limit 10
)

select 
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
    INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC