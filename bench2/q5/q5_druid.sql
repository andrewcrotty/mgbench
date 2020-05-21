SELECT mo,
       COUNT(DISTINCT client_ip)
FROM (
  SELECT EXTRACT(MONTH FROM __time) AS mo,
         client_ip
  FROM logs
) AS r
GROUP BY mo
ORDER BY mo;
