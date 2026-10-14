-- Najbardziej poszukiwane umiejętności technologiczne według stanowiska — analiza ofert pracy z wykorzystaniem SQL
WITH zliczanie AS (
SELECT jpf.job_title_short, s.skills, COUNT(*) AS job_postings_count
FROM job_postings_fact jpf
JOIN skills_job_dim sj ON jpf.job_id = sj.job_id
JOIN skills_dim s ON s.skill_id = sj.skill_id
GROUP BY jpf.job_title_short, s.skills
),
ranking_tabela AS (
SELECT * , 
RANK() OVER(partition by job_title_short ORDER BY job_postings_count DESC) AS ranking 
FROM zliczanie 
)
SELECT ranking, job_title_short, skills, job_postings_count FROM ranking_tabela
WHERE ranking <=5;
