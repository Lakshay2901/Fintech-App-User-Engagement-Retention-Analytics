-- Query 6: Average Transaction Value by Age Group

SELECT
    u.age_group,
    ROUND(AVG(t.amount), 2) AS avg_transaction_value,
    COUNT(t.transaction_id) AS total_transactions
FROM transactions t
JOIN users u ON u.user_id = t.user_id
WHERE t.status = 'Success'
GROUP BY u.age_group
ORDER BY u.age_group;
