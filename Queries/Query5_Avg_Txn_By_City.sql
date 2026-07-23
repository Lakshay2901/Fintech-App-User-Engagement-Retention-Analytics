-- Query 5: Average Transaction Value by City

SELECT
    u.city,
    ROUND(AVG(t.amount), 2) AS avg_transaction_value,
    COUNT(t.transaction_id) AS total_transactions
FROM transactions t
JOIN users u ON u.user_id = t.user_id
WHERE t.status = 'Success'
GROUP BY u.city
ORDER BY avg_transaction_value DESC;
