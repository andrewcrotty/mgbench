SELECT *
FROM logs
WHERE status_code >= 200
  AND status_code < 300
  AND request LIKE '%/etc/passwd%'
  AND log_time >= DATE '2012-05-06'
  AND log_time < TIMESTAMP '2012-05-20 00:00:00';
