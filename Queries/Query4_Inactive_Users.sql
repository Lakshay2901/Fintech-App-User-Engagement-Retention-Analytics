-- Query 4: Detect Inactive (Churned) Users
-- Flags users whose last successful transaction was more than 30 days
-- before the last date present in the dataset.

WITH last_txn AS (
    SELECT
        user_id,
        MAX(txn_date) AS last_txn_date
    FROM transactions
    WHERE status = 'Success'
    GROUP BY user_id
),
dataset_end AS (
    SELECT MAX(txn_date) AS max_date FROM transactions
)
SELECT
    lt.user_id,
    lt.last_txn_date,
    DATEDIFF(d.max_date, lt.last_txn_date) AS days_since_last_txn
FROM last_txn lt
CROSS JOIN dataset_end d
WHERE DATEDIFF(d.max_date, lt.last_txn_date) > 30
ORDER BY days_since_last_txn DESC;
