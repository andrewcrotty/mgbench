SELECT DATE_FORMAT(log_time),
       client_ip,
       request,
       status_code,
       object_size
FROM logs
WHERE status_code >= 200
  AND status_code < 300
  AND request LIKE '%/etc/passwd%'
  AND log_time >= '2012-05-06'
  AND log_time < '2012-05-20';
