-- Q2.3: What was the average path depth for top-level requests in the past month?

SELECT top_level,
       AVG(CHAR_LENGTH(request) - CHAR_LENGTH(REGEXP_REPLACE(request, '/', '', 'g'))) AS depth_avg
FROM (
  SELECT SUBSTR(request, 1, len + 1) AS top_level,
         request
  FROM (
    SELECT CHAR_LENGTH(REGEXP_REPLACE(SUBSTR(request, 2), '/.*', '')) AS len,
           request
    FROM logs
    WHERE status_code >= 200
      AND status_code < 300
      AND log_time >= TIMESTAMP '2012-12-01 00:00:00'
  ) AS r
  WHERE len > 0
) AS s
WHERE top_level IN ('/about','/courses','/degrees','/events',
                    '/grad','/industry','/news','/people',
                    '/publications','/research','/teaching','/ugrad')
GROUP BY top_level
ORDER BY top_level;
