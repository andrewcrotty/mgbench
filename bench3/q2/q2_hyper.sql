WITH power_hourly AS (
  SELECT EXTRACT(HOUR FROM log_time) AS hr,
         device_id,
         device_name,
         CASE WHEN device_name LIKE 'coffee%' THEN 'coffee'
              WHEN device_name LIKE 'printer%' THEN 'printer'
              WHEN device_name LIKE 'projector%' THEN 'projector'
              WHEN device_name LIKE 'vending%' THEN 'vending'
              ELSE 'other'
         END AS device_category,
         device_floor,
         event_value
  FROM logs
  WHERE event_type = 'power'
    AND log_time >= TIMESTAMP '2019-11-01 00:00:00'
)
SELECT hr,
       device_id,
       device_name,
       device_category,
       device_floor,
       power_avg,
       category_power_avg
FROM (
  SELECT hr,
         device_id,
         device_name,
         device_category,
         device_floor,
         AVG(event_value) AS power_avg,
         (SELECT AVG(r2.event_value)
          FROM power_hourly AS r2
          WHERE r2.device_id <> r.device_id
            AND r2.device_category = r.device_category
            AND r2.hr = r.hr) AS category_power_avg
  FROM power_hourly AS r
  GROUP BY hr,
           device_id,
           device_name,
           device_category,
           device_floor
) AS s
WHERE power_avg >= category_power_avg * 2.0;
