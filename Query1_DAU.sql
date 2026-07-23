-- Query 1: Daily Active Users (DAU)
-- A user is "active" on a day if they completed at least one successful transaction.

SELECT
    txn_date,
    COUNT(DISTINCT user_id) AS daily_active_users
FROM transactions
WHERE status = 'Success'
GROUP BY txn_date
ORDER BY txn_date;
