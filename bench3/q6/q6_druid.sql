-- Q3.6: For each device category, what are the monthly power consumption metrics?

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
  SELECT dt,
         yr,
         mo,
         hr,
         AVG(coffee) AS coffee_hourly_avg,
         AVG(printer) AS printer_hourly_avg,
         AVG(projector) AS projector_hourly_avg,
         AVG(vending) AS vending_hourly_avg
  FROM (
    SELECT CAST(__time AS DATE) AS dt,
           EXTRACT(YEAR FROM __time) AS yr,
           EXTRACT(MONTH FROM __time) AS mo,
           EXTRACT(HOUR FROM __time) AS hr,
           CASE WHEN device_name LIKE 'coffee%' THEN event_value ELSE 0 END AS coffee,
           CASE WHEN device_name LIKE 'printer%' THEN event_value ELSE 0 END AS printer,
           CASE WHEN device_name LIKE 'projector%' THEN event_value ELSE 0 END AS projector,
           CASE WHEN device_name LIKE 'vending%' THEN event_value ELSE 0 END AS vending
    FROM logs
    WHERE device_type = 'meter'
  ) AS r
  GROUP BY dt,
           yr,
           mo,
           hr
) AS s
GROUP BY yr,
         mo
ORDER BY yr,
         mo;
