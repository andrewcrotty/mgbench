-- Q1.4: Over a 1-month period, how often was each server blocked on disk I/O?

SELECT machine_name,
       COUNT(*) AS spikes
FROM logs
WHERE machine_group = 'Servers'
  AND cpu_wio > 0.99
  AND __time >= TIMESTAMP '2016-12-01 00:00:00'
  AND __time < TIMESTAMP '2017-01-01 00:00:00'
GROUP BY machine_name
ORDER BY spikes DESC
LIMIT 10;
