-- Query 9: Primary Login Device vs Retention
-- For each user, find their most-used device, then check whether they were
-- still transacting in the final 30 days of the dataset ("retained").

WITH primary_device AS (
    SELECT
        user_id,
        device_type,
        COUNT(*) AS uses,
        ROW_NUMBER() OVER (
            PARTITION BY user_id ORDER BY COUNT(*) DESC
        ) AS rn
    FROM logins
    GROUP BY user_id, device_type
),
dataset_end AS (
    SELECT MAX(txn_date) AS max_date FROM transactions
),
retained_users AS (
    SELECT DISTINCT t.user_id
    FROM transactions t
    CROSS JOIN dataset_end d
    WHERE t.status = 'Success'
      AND DATEDIFF(d.max_date, t.txn_date) <= 30
)
SELECT
    pd.device_type,
    COUNT(DISTINCT pd.user_id) AS total_users,
    COUNT(DISTINCT ru.user_id) AS retained_users,
    ROUND(100.0 * COUNT(DISTINCT ru.user_id) / COUNT(DISTINCT pd.user_id), 1) AS retention_rate_pct
FROM primary_device pd
LEFT JOIN retained_users ru ON ru.user_id = pd.user_id
WHERE pd.rn = 1
GROUP BY pd.device_type
ORDER BY retention_rate_pct DESC;
