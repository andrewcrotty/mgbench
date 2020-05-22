SELECT yr,
       mo,
       SUM(coffee_hourly_avg) AS coffee_monthly_sum,
       AVG(coffee_hourly_avg) AS coffee_monthly_avg,
       SUM(printer_hourly_avg) AS printer_monthly_sum,
       AVG(printer_hourly_avg) AS printer_monthly_avg,
       SUM(projector_hourly_avg) AS projector_monthly_sum,
       AVG(projector_hourly_avg) AS projector_monthly_avg,
       SUM(vending_hourly_avg) AS vending_monthly_sum,
       AVG(vending_hourly_avg) AS vending_monthly_avg
FROM (
  SELECT CAST(log_time AS DATE) AS dt,
         EXTRACT(YEAR FROM log_time) AS yr,
         EXTRACT(MONTH FROM log_time) AS mo,
         EXTRACT(HOUR FROM log_time) AS hr,
         AVG(CASE WHEN device_name LIKE 'coffee%' THEN event_value ELSE 0 END) AS coffee_hourly_avg,
         AVG(CASE WHEN device_name LIKE 'printer%' THEN event_value ELSE 0 END) AS printer_hourly_avg,
         AVG(CASE WHEN device_name LIKE 'projector%' THEN event_value ELSE 0 END) AS projector_hourly_avg,
         AVG(CASE WHEN device_name LIKE 'vending%' THEN event_value ELSE 0 END) AS vending_hourly_avg
  FROM logs
  WHERE device_type = 'meter'
  GROUP BY dt,
           yr,
           mo,
           hr
) AS r
GROUP BY yr,
         mo
ORDER BY yr,
         mo;
