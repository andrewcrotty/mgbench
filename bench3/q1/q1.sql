SELECT *
FROM logs
WHERE event_type = 'temperature'
  AND event_value <= 32.0
  AND log_time >= TIMESTAMP '2019-11-29 17:00:00';
