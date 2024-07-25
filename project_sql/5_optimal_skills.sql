with jobs_skills as 
(
    select 
        job_postings_fact.job_id,
        job_postings_fact.job_title_short,
        job_postings_fact.salary_year_avg,
        skills_dim.skills as skill_name,
        skills_dim.skill_id as skill_id
        
    FROM
        job_postings_fact
        inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
        inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst') and (job_postings_fact.salary_year_avg is not null)
)

, skills_demand as (
    select 
        skill_id,
        skill_name,
        count(skill_name) as skill_count
    from jobs_skills
    GROUP BY skill_id, skill_name
)

, average_salary as (
    select 
        skill_id,
        skill_name,
        round(avg(salary_year_avg), 0) as avg_salary
    from jobs_skills
    GROUP BY skill_id, skill_name
)

select 
    skills_demand.skill_id,
    skills_demand.skill_name,
    skill_count,
    avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where skill_count > 10
order BY 
    skill_count desc,
    average_salary desc
limit 25
