-- Q2.1: Which requests have caused server errors within the past 2 weeks?

SELECT *
FROM logs
WHERE status_code >= 500
  AND __time >= TIMESTAMP '2012-12-18 00:00:00'
ORDER BY __time;
