select 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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