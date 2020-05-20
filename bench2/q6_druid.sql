SELECT AVG(bandwidth) / 1000000000.0 AS avg_bandwidth,
       MAX(bandwidth) / 1000000000.0 AS peak_bandwidth
FROM (
  SELECT __time,
         SUM(object_size) AS bandwidth
  FROM logs
  GROUP BY __time
) AS r;
