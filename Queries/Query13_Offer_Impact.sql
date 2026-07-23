-- Query 13: Offer / Cashback Impact on Transaction Volume
-- Compares total & average transactions for users who redeemed an offer
-- vs. users who never received/redeemed one ("organic" users).

WITH redeemers AS (
    SELECT DISTINCT user_id
    FROM offers
    WHERE redeemed = 'Yes'
),
user_txn_counts AS (
    SELECT
        user_id,
        COUNT(*) AS total_txns,
        SUM(amount) AS total_txn_value
    FROM transactions
    WHERE status = 'Success'
    GROUP BY user_id
)
SELECT
    CASE WHEN r.user_id IS NOT NULL THEN 'Offer Redeemer' ELSE 'Organic' END AS user_group,
    COUNT(DISTINCT utc.user_id) AS num_users,
    ROUND(AVG(utc.total_txns), 2) AS avg_txns_per_user,
    ROUND(AVG(utc.total_txn_value), 2) AS avg_txn_value_per_user
FROM user_txn_counts utc
LEFT JOIN redeemers r ON r.user_id = utc.user_id
GROUP BY user_group;
