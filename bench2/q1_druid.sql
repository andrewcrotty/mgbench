SELECT *
FROM logs
WHERE status_code >= 500
  AND __time >= TIMESTAMP '2012-12-18'
ORDER BY __time;
