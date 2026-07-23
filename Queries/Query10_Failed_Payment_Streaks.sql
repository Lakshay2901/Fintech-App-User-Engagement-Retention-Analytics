-- Query 10: Failed Payment Streaks (Gaps-and-Islands pattern)
-- Finds consecutive-day runs of FAILED transactions per user.
-- Method: row-number-diff -- rn = ROW_NUMBER over failed txns only, per user;
-- (txn_date - rn days) stays constant for a consecutive run of calendar days = an "island".

WITH failed_txns AS (
    SELECT
        user_id,
        txn_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY txn_date) AS rn
    FROM (
        SELECT DISTINCT user_id, txn_date
        FROM transactions
        WHERE status = 'Failed'
    ) d
),
islands AS (
    SELECT
        user_id,
        txn_date,
        rn,
        DATE_SUB(txn_date, INTERVAL rn DAY) AS island_key
    FROM failed_txns
)
SELECT
    user_id,
    MIN(txn_date) AS streak_start,
    MAX(txn_date) AS streak_end,
    COUNT(*) AS consecutive_failed_days
FROM islands
GROUP BY user_id, island_key
HAVING COUNT(*) >= 3          -- only surface real streaks, 3+ consecutive failed days
ORDER BY consecutive_failed_days DESC;
