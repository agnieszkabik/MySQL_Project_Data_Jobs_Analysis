--  5 najlepiej płatnych ogłoszeń dla roli analityka danych z możliwością pracy zdalnej i wymagane umiejętności
WITH sub AS (
				SELECT * FROM job_postings_fact
				WHERE job_title_short = "Data Analyst" AND salary_year_avg != 0 AND job_work_from_home = 1
			),
tab_ranking AS (
			SELECT *,
			RANK() OVER(ORDER BY salary_year_avg DESC) AS ranking
			FROM sub
		)
SELECT ranking, t_r.job_id, t_r.company_id, name, job_title, salary_year_avg, GROUP_CONCAT(s_d.skills ORDER BY s_d.skill_id SEPARATOR ', ') AS skills
FROM tab_ranking t_r
JOIN company_dim c_d ON t_r.company_id = c_d.company_id
JOIN skills_job_dim s_j_d ON t_r.job_id = s_j_d.job_id
LEFT JOIN skills_dim s_d ON s_d.skill_id = s_j_d.skill_id
WHERE ranking <= 5
GROUP BY ranking, job_id, company_id, name, job_title, salary_year_avg
ORDER BY ranking;