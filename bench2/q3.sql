SELECT top_level,
       AVG(LENGTH(request) - LENGTH(REPLACE(request, '/', ''))) AS depth
FROM (
  SELECT SUBSTRING(request FROM 0 FOR len) AS top_level,
         request
  FROM (
    SELECT POSITION('/' IN SUBSTRING(request FROM 2)) AS len,
           request
    FROM logs
    WHERE status_code >= 200
      AND status_code < 300
      AND log_time >= '2012-12-01'
  ) AS r
  WHERE len > 0
) AS s
WHERE top_level IN ('/about','/courses','/degrees','/events',
                    '/grad','/industry','/news','/people',
                    '/publications','/research','/ugrad')
GROUP BY top_level
ORDER BY top_level;
