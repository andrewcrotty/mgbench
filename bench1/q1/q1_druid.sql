SELECT machine_name,
       MIN(cpu) AS min_cpu,
       MAX(cpu) AS max_cpu,
       AVG(cpu) AS avg_cpu,
       MIN(net_in) AS min_net_in,
       MAX(net_in) AS max_net_in,
       AVG(net_in) AS avg_net_in,
       MIN(net_out) AS min_net_out,
       MAX(net_out) AS max_net_out,
       AVG(net_out) AS avg_net_out
FROM (
  SELECT machine_name,
         COALESCE(cpu_user, 0.0) AS cpu,
         COALESCE(bytes_in, 0.0) AS net_in,
         COALESCE(bytes_out, 0.0) AS net_out
  FROM logs
  WHERE machine_name IN ('anansi','aragog','urd')
    AND __time >= TIMESTAMP '2017-01-11 00:00:00'
) AS r
GROUP BY machine_name;
