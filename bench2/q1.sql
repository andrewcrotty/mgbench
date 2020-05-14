SELECT *
FROM logs
WHERE status_code >= 500
  AND log_time >= DATE '2012-12-18'
ORDER BY log_time;
