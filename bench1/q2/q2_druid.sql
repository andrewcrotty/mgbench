SELECT machine_name,
       __time
FROM logs
WHERE (machine_name LIKE 'cslab%' OR
       machine_name LIKE 'mslab%')
  AND load_one IS NULL
  AND __time >= TIMESTAMP '2017-01-10 00:00:00'
ORDER BY machine_name,
         __time;
