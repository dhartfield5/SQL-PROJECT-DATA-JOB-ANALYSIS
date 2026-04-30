/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Anlaysts and
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary  
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;


/*
Final Insight (Most Important)

This isn’t random.

The highest-paying “data analyst” skills are actually skills that are hardest to automate with AI.

AI can:

    Build dashboards
    Write SQL
    Clean data

But it struggles with:

    System architecture
    Pipelines
    Infrastructure
    Complex workflows

That’s exactly where the money is.

Bottom Line

From your top 25 skills:

    High pay = complexity + scale + engineering
    Basic analytics skills are no longer enough
    Cloud + pipelines = biggest salary boost
    AI/ML = future-proofing
    DevOps skills = hidden differentiator