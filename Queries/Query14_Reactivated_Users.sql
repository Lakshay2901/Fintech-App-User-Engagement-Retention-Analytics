-- Query 14: Reactivated Users
-- Finds users who went quiet for 45+ days and then transacted again --
-- i.e. they churned and came back. Uses LAG() to compare each transaction
-- date to the user's previous one.

WITH ordered_txns AS (
    SELECT
        user_id,
        txn_date,
        LAG(txn_date) OVER (PARTITION BY user_id ORDER BY txn_date) AS prev_txn_date
    FROM (
        SELECT DISTINCT user_id, txn_date
        FROM transactions
        WHERE status = 'Success'
    ) d
),
gaps AS (
    SELECT
        user_id,
        prev_txn_date,
        txn_date AS reactivation_date,
        DATEDIFF(txn_date, prev_txn_date) AS gap_days
    FROM ordered_txns
    WHERE prev_txn_date IS NOT NULL
)
SELECT
    user_id,
    prev_txn_date AS last_active_before_gap,
    reactivation_date,
    gap_days
FROM gaps
WHERE gap_days >= 45
ORDER BY gap_days DESC;
