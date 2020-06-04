-- Q2.5: What are the daily unique visitors?

SELECT dt,
       COUNT(DISTINCT client_ip)
FROM (
  SELECT DATE_TRUNC('day', log_time) AS dt,
         client_ip
  FROM logs
) AS r
GROUP BY dt
ORDER BY dt;
