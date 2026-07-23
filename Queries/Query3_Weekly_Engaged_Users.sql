-- Query 3: Weekly Engaged Users
-- A user counts as "engaged" for a week if they transacted on 3+ distinct days that week.

WITH daily_activity AS (
    SELECT DISTINCT
        user_id,
        txn_date,
        YEARWEEK(txn_date, 3) AS txn_week 
    FROM transactions
    WHERE status = 'Success'
),
weekly_days AS (
    SELECT
        user_id,
        txn_week,
        COUNT(DISTINCT txn_date) AS active_days_in_week
    FROM daily_activity
    GROUP BY user_id, txn_week
)
SELECT
    txn_week,
    COUNT(DISTINCT user_id) AS weekly_engaged_users
FROM weekly_days
WHERE active_days_in_week >= 3
GROUP BY txn_week
ORDER BY txn_week;
