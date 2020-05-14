SELECT machine_name,
       COUNT(*) AS spikes
FROM logs
WHERE machine_group = 'Servers'
  AND cpu_wio > 0.99
  AND log_time >= DATE '2016-12-01'
  AND log_time < DATE '2017-01-01'
GROUP BY machine_name
ORDER BY spikes DESC
LIMIT 10;
