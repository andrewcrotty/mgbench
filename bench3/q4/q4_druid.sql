-- Q3.4: Over the past 6 months, how frequently was each door opened?

SELECT device_name,
       device_floor,
       COUNT(*) AS ct
FROM logs
WHERE event_type = 'door_open'
  AND __time >= TIMESTAMP '2019-06-01 00:00:00'
GROUP BY device_name,
         device_floor
ORDER BY ct DESC;
