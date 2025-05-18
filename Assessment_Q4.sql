-- Customer Lifetime Value (CLV) Estimation

SELECT
	u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,
    COUNT(s.owner_id) AS total_transactions,
    ROUND(
    COUNT(s.owner_id)/NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()),0)*12*(0.01*AVG(s.confirmed_amount)), 2
    ) AS estimated_clv
    
FROM
	users_customuser u
JOIN
	savings_savingsaccount s
ON
	u.id = s.owner_id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_joined
ORDER BY
	estimated_clv DESC;