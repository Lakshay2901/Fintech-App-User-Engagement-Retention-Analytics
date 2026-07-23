-- Query 12: Churn Rate by City
-- A user is "churned" if their last successful transaction was more than
-- 30 days before the last date present in the dataset (or they never transacted).

WITH last_txn AS (
    SELECT user_id, MAX(txn_date) AS last_txn_date
    FROM transactions
    WHERE status = 'Success'
    GROUP BY user_id
),
dataset_end AS (
    SELECT MAX(txn_date) AS max_date FROM transactions
),
churn_flag AS (
    SELECT
        u.user_id,
        u.city,
        CASE
            WHEN lt.last_txn_date IS NULL THEN 1  -- never transacted = churned
            WHEN DATEDIFF(d.max_date, lt.last_txn_date) > 30 THEN 1
            ELSE 0
        END AS is_churned
    FROM users u
    LEFT JOIN last_txn lt ON lt.user_id = u.user_id
    CROSS JOIN dataset_end d
)
SELECT
    city,
    COUNT(*) AS total_users,
    SUM(is_churned) AS churned_users,
    ROUND(100.0 * SUM(is_churned) / COUNT(*), 1) AS churn_rate_pct
FROM churn_flag
GROUP BY city
ORDER BY churn_rate_pct DESC;
