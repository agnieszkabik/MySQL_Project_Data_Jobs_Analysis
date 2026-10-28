-- Top 5 najlepiej płatnych ofert dla każdej roli — analiza ofert pracy z wykorzystaniem SQL
WITH tab_ranking AS (
						SELECT job_id, job_title_short, company_id, job_title, salary_year_avg,
						RANK() OVER(PARTITION BY job_title_short ORDER BY salary_year_avg DESC) AS ranking
						FROM job_postings_fact
		)
SELECT ranking, job_title_short, t_r.company_id, name AS company_name, job_id, job_title, salary_year_avg
FROM tab_ranking t_r
JOIN company_dim c_d ON t_r.company_id = c_d.company_id
WHERE ranking <= 5
ORDER BY job_title_short, ranking;