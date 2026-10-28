-- Top 5 najlepiej płatnych ofert dla każdej roli — analiza ofert pracy z wykorzystaniem SQL
WITH tab_ranking AS (
						SELECT job_id, job_title_short, company_id, job_title ,
						RANK() OVER(PARTITION BY job_title_short ORDER BY salary_year_avg DESC) AS ranking
						FROM job_postings_fact
		)
SELECT ranking, job_title_short, job_id, company_id, job_title  
FROM tab_ranking
WHERE ranking <= 5;