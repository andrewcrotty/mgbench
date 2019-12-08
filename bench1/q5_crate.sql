SELECT machine_name,
       DATE_FORMAT('%Y-%m-%d', dt) AS dt,
       MIN(mem_free) AS min_mem_free
FROM (
  SELECT machine_name,
         DATE_TRUNC('day', log_time) AS dt,
         mem_free
  FROM logs
  WHERE machine_group = 'DMZ'
    AND mem_free IS NOT NULL
) AS r
GROUP BY machine_name,
         dt
HAVING MIN(mem_free) < 10000
ORDER BY machine_name,
         dt;
