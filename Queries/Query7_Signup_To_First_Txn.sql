-- Query 7: Time from Signup to First Transaction (activation lag)

WITH first_txn AS (
    SELECT
        user_id,
        MIN(txn_date) AS first_txn_date
    FROM transactions
    WHERE status = 'Success'
    GROUP BY user_id
)
SELECT
    u.user_id,
    u.signup_date,
    ft.first_txn_date,
    DATEDIFF(ft.first_txn_date, u.signup_date) AS days_to_activate
FROM users u
JOIN first_txn ft ON ft.user_id = u.user_id
ORDER BY days_to_activate DESC;
