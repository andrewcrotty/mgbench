SELECT DATE_FORMAT(log_time),
       client_ip,
       request,
       status_code,
       object_size
FROM logs
WHERE status_code >= 500
  AND log_time >= '2012-12-18'
ORDER BY log_time;
