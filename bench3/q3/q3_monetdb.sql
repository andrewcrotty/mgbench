WITH room_use AS (
  SELECT dow,
         hr,
         device_name,
         AVG(motions) AS in_use
  FROM (
    SELECT dt,
           dow,
           hr,
           device_name,
           COUNT(*) AS motions
    FROM (
      SELECT CAST(log_time AS DATE) AS dt,
             DAYOFWEEK(log_time) AS dow,
             EXTRACT(HOUR FROM log_time) AS hr,
             device_name
      FROM logs
      WHERE device_name LIKE 'room%'
        AND event_type = 'motion_start'
        AND log_time >= TIMESTAMP '2019-09-01'
    ) AS r
    WHERE dow IN (1,2,3,4,5)
      AND hr BETWEEN 9 AND 16
    GROUP BY dt,
             dow,
             hr,
             device_name
  ) AS s
  GROUP BY dow,
           hr,
           device_name
)
SELECT device_name,
       dow,
       hr,
       in_use
FROM room_use AS r
WHERE in_use = (
  SELECT MIN(in_use)
  FROM room_use
  WHERE device_name = r.device_name
)
ORDER BY device_name;
