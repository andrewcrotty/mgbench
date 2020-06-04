-- Q2.4: During the last 3 months, which clients have made an excessive number of requests?

SELECT client_ip,
       COUNT(*) AS num_requests
FROM logs
WHERE log_time >= TIMESTAMP '2012-10-01 00:00:00'
GROUP BY client_ip
HAVING COUNT(*) >= 100000
ORDER BY num_requests DESC;
