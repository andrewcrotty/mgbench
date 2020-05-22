SELECT device_name,
       device_floor,
       COUNT(*) AS ct
FROM logs
WHERE event_type = 'door_open'
  AND log_time >= TIMESTAMP '2019-06-01'
GROUP BY device_name,
         device_floor
ORDER BY ct DESC;
