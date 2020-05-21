SELECT dt,
       hr,
       AVG(load_fifteen) AS avg_load_fifteen,
       AVG(load_five) AS avg_load_five,
       AVG(load_one) AS avg_load_one,
       AVG(mem_free) AS avg_mem_free,
       AVG(swap_free) AS avg_swap_free
FROM (
  SELECT CAST(__time AS DATE) AS dt,
         EXTRACT(HOUR FROM __time) AS hr,
         load_fifteen,
         load_five,
         load_one,
         mem_free,
         swap_free
  FROM logs
  WHERE machine_name = 'babbage'
    AND load_fifteen IS NOT NULL
    AND load_five IS NOT NULL
    AND load_one IS NOT NULL
    AND mem_free IS NOT NULL
    AND swap_free IS NOT NULL
    AND __time >= TIMESTAMP '2017-01-01'
) AS r
GROUP BY dt,
         hr
ORDER BY dt,
         hr;
