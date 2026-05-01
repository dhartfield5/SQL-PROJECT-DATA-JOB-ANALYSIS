# Introduction (This project uses the full up-to-date [2026] dataset)
    This project provides a comprehensive analysis of the data job market, specifically focusing on data analyst roles. It evaluates high-paying opportunities, identifies key in-demand skills, and explores the intersection of market demand and salary potential within the analytics industry.

    Here are the SQL queries: [project_sql folder](/project_sql/)

# Background
    Motivated by the objective of navigating the data analyst job market more strategically, this project was undertaken to identify high-paying roles and in-demand skill sets through the analysis and synthesis of existing research, with the aim of determining optimal career pathways.

    Questions that I answered in these SQL queries were:

    1. What are the top-paying data analyst jobs?
    2. What skills are required for these top-paying jobs?
    3. What skills are most in demand for data analysts?
    4. Which skills are associated with higher salaries?
    5. What are the most optimal skills to learn?

# Tools I Used
    This project leveraged a range of technical tools to support the analysis of the data analyst job market. 
    
    - SQL was employed as the primary language for querying and analyzing the dataset, enabling the extraction of key insights. 
    
    - PostgreSQL was selected as the database management system due to its efficiency in handling structured job posting data. 
    
    - Visual Studio Code was utilized as the development environment for database interaction and query execution. Furthermore, 
    
    - Git and GitHub were implemented for version control and collaboration, facilitating organized project management and code sharing.

# The Analysis
##  - Top Paying Data Analyst Jobs
    Each query conducted in this project was structured to investigate distinct components of the data analyst job market. To determine the highest-paying data analyst positions, I applied filters based on average annual salary and geographic location, with an emphasis on remote roles. This approach enabled the identification of high-paying opportunities within the industry.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id  
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
An analysis of the highest-paying data analyst roles in 2023 reveals several notable trends. The top 10 positions exhibit a substantial salary range, from $184,000 to $650,000, underscoring the strong earning potential in the field. These roles are distributed across a diverse group of employers, including SmartAsset, Meta, and AT&T, indicating widespread demand across industries. Additionally, there is significant diversity in job titles, ranging from Data Analyst to Director of Analytics, which highlights the variety of roles and areas of specialization within the data analytics domain.

![Top Paying Roles](project_sql\assets\1_top_paying_jobs.png) 

*This bar graph visualizes the top 10 salaries for Data Analysts; ChatGPT generated this graph from my SQL query results*


# - Top 5 Demanded Skills for Remote Jobs
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.skill_id) AS demand_count 
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
## 1. 2023 Data (What Employers Wanted Most)
    
### Top 5 Most In-Demand Skills for Remote Jobs (2023)
    
- SQL → 7,291
- Excel → 4,611
- Python → 4,330
- Tableau → 3,745
- Power BI → 2,609

#### Interpretation:

The market was heavily focused on core analytics and reporting skills

## 2. 2026 Market Reality (What’s Changed)

### Still in High Demand (No Change)

- SQL → still #1
- Excel → still widely used
- Python → even more important
- Tableau / Power BI → still standard tools
#### Interpretation:

These didn’t go away—they became baseline expectations

![Top Paying Roles](project_sql\assets\top_5_data_analyst_skills_demand.png)

*This bar graph visualizes the top 5 demanded skills for remote Data Analysts jobs; ChatGPT generated this graph from my SQL query results*

# - Top 25 Paying Skills for Remote Jobs
```sql
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
```
![Top 25 Paying Skills for Remote Data Analyst Jobs](project_sql\assets\top_25_paying_skills_remote_jobs.png)

*This bar graph visualizes the top 25 paying skills for remote Data Analysts jobs; ChatGPT generated this graph from my SQL query results*

# - 25 Most Optimal Remote Skills
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNEr JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
![25 Most Optimal Remote Data Analyst Skills](project_sql\assets\top_25_paying_skills_remote_jobs.png)

*This bar graph visualizes the top 25 most optimal remote Data Analysts skills; ChatGPT generated this graph from my SQL query results*

# What I Learned

Throughout this experience, I significantly strengthened my SQL skill set by developing proficiency in advanced query design, including complex joins and the effective use of Common Table Expressions (CTEs) for managing intermediate result sets. I also enhanced my ability to perform data aggregation by utilizing GROUP BY alongside functions such as COUNT() and AVG() to generate meaningful summaries. Additionally, I improved my analytical capabilities by translating real-world business questions into structured SQL queries that produce clear, actionable insights.

# Conclusions

This project strengthened my SQL proficiency while also providing meaningful insights into current trends within the data analyst job market. The results of this analysis offer a practical framework for prioritizing skill development and guiding job search strategies. By focusing on skills that are both high in demand and associated with higher salaries, aspiring data analysts can position themselves more competitively. Overall, this exploration underscores the importance of continuous learning and adapting to evolving technologies and industry trends in the field of data analytics.
