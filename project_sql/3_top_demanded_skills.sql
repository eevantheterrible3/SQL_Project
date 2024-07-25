with jobs_skills as 
(
    select 
        job_postings_fact.job_id,
        job_postings_fact.job_title_short,
        job_postings_fact.salary_year_avg,
        skills_dim.skills as skill_name
        
    FROM
        job_postings_fact
        inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
        inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
)

select 
    skill_name,
    count(skill_name) as skill_count
from jobs_skills
GROUP BY skill_name
ORDER BY skill_count desc
limit 10

