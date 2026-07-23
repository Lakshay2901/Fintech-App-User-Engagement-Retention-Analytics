-- Query 11: Signup Cohort Retention
-- Groups users by signup month, then measures what % of each cohort
-- was still transacting in each subsequent month (month-over-month retention).

WITH cohorts AS (
    SELECT
        user_id,
        DATE_FORMAT(signup_date, '%Y-%m-01') AS signup_month
    FROM users
),
activity AS (
    SELECT
        user_id,
        DATE_FORMAT(txn_date, '%Y-%m-01') AS active_month
    FROM transactions
    WHERE status = 'Success'
    GROUP BY user_id, active_month
),
cohort_activity AS (
    SELECT
        c.signup_month,
        a.active_month,
        TIMESTAMPDIFF(MONTH, c.signup_month, a.active_month) AS month_number,
        a.user_id
    FROM cohorts c
    JOIN activity a ON a.user_id = c.user_id
),
cohort_size AS (
    SELECT signup_month, COUNT(*) AS users_in_cohort
    FROM cohorts
    GROUP BY signup_month
)
SELECT
    DATE_FORMAT(ca.signup_month, '%Y-%m') AS signup_month,
    ca.month_number,
    COUNT(DISTINCT ca.user_id) AS active_users,
    cs.users_in_cohort,
    ROUND(100.0 * COUNT(DISTINCT ca.user_id) / cs.users_in_cohort, 1) AS retention_pct
FROM cohort_activity ca
JOIN cohort_size cs ON cs.signup_month = ca.signup_month
WHERE ca.month_number >= 0
GROUP BY ca.signup_month, ca.month_number, cs.users_in_cohort
ORDER BY ca.signup_month, ca.month_number;
