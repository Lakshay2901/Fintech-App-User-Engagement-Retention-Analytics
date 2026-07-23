-- Query 2: Monthly Active Users (MAU)

SELECT
    DATE_FORMAT(txn_date, '%Y-%m') AS txn_month,
    COUNT(DISTINCT user_id) AS monthly_active_users
FROM transactions
WHERE status = 'Success'
GROUP BY txn_month
ORDER BY txn_month;
