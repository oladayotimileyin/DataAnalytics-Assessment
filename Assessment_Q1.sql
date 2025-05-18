-- Question 1: High Value Customers with Multiple Products

SELECT 
	u.id AS owner_id, 
	CONCAT(u.first_name, ' ', u.last_name) AS name, 
	SUM(CASE WHEN p.is_regular_savings = 1 THEN 1 ELSE 0 END) AS savings_count, 
	SUM(CASE WHEN p.is_a_fund =1 THEN 1 ELSE 0 END) AS investment_count, 
	SUM(s.confirmed_amount) AS total_deposit
FROM 
	users_customuser u
JOIN 
	plans_plan p
ON 
	u.id = p.owner_id
JOIN 
	savings_savingsaccount s
ON 
	s.plan_id = p.id
WHERE 
	s.confirmed_amount > 0
GROUP BY 
	u.id, name
HAVING
	SUM(CASE WHEN p.is_regular_savings = 1 THEN 1 ELSE 0 END) > 0
	AND SUM(CASE WHEN p.is_a_fund = 1 THEN 1 ELSE 0 END) > 0
ORDER BY 
	total_deposit DESC;

