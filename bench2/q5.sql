SELECT mo,
       COUNT(DISTINCT client_ip)
FROM (
  SELECT EXTRACT(MONTH FROM log_time) AS mo,
         client_ip
  FROM logs
) AS r
GROUP BY mo
ORDER BY mo;
