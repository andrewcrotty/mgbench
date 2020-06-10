-- Q2.6: What are the average and maximum data transfer rates (Gbps)?

SELECT AVG(transfer) / 125000000.0 AS transfer_avg,
       MAX(transfer) / 125000000.0 AS transfer_max
FROM (
  SELECT log_time,
         SUM(object_size) AS transfer
  FROM logs
  GROUP BY log_time
) AS r;
