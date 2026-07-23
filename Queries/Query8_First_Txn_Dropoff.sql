-- Query 8: First Transaction Drop-off
-- Users who signed up (and even logged in) but never completed a single
-- successful transaction -- i.e. dropped off before activating.

SELECT
    u.user_id,
    u.signup_date,
    u.acquisition_channel,
    COUNT(DISTINCT l.login_id) AS total_logins
FROM users u
LEFT JOIN logins l ON l.user_id = u.user_id
LEFT JOIN transactions t
    ON t.user_id = u.user_id AND t.status = 'Success'
WHERE t.transaction_id IS NULL
GROUP BY u.user_id, u.signup_date, u.acquisition_channel
ORDER BY total_logins DESC;
