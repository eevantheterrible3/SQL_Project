with jobs_skills as 
(
    select 
        job_postings_fact.job_id as job_id,
        job_postings_fact.job_title_short as job_title_short,
        job_postings_fact.salary_year_avg as salary_year_avg,
        skills_dim.skills as skill_name
        
    FROM
        job_postings_fact
        inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
        inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst') and (job_postings_fact.salary_year_avg is not null)
)

select 
    skill_name,
    round(avg(salary_year_avg), 0) as avg_salary
from jobs_skills
GROUP BY skill_name
ORDER BY avg_salary desc
limit 25

