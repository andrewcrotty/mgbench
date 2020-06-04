-- Q2.5: What are the daily unique visitors?

SELECT dt,
       COUNT(DISTINCT client_ip)
FROM (
  SELECT CAST(log_time AS DATE) AS dt,
         client_ip
  FROM logs
) AS r
GROUP BY dt
ORDER BY dt;
