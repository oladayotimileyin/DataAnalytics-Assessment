-- Question 3: Account Inactivity Alert

SELECT
	p.id AS plan_id,
    p.owner_id AS owner_id,
    CASE
		WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment' 
        ELSE 'Unknown'
	END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS inactivity_days
FROM
	plans_plan p
JOIN
	savings_savingsaccount s
ON
	p.id=s.plan_id
WHERE
	p.is_archived = 0
GROUP BY
	p.id, 
    p.owner_id
HAVING
	last_transaction_date IS NOT NULL
    AND DATEDIFF(CURRENT_DATE(), last_transaction_date) > 365;