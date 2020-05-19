SELECT machine_name,
       log_time
FROM logs
WHERE (machine_name LIKE 'cslab%' OR
       machine_name LIKE 'mslab%')
  AND load_one IS NULL
  AND log_time >= TIMESTAMP '2017-01-10'
ORDER BY machine_name,
         log_time;
