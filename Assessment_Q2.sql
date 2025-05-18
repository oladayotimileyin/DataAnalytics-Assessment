-- Question 2: 

WITH monthly_transaction AS (
	SELECT
		s.owner_id,
		DATE_FORMAT(s.transaction_date, '%Y-%m') AS yearmonth,
		COUNT(*) AS transaction_in_month
	FROM 
		savings_savingsaccount s
	GROUP BY
		s.owner_id, yearmonth
),
user_average AS (
	SELECT
		owner_id,
		AVG(transaction_in_month) AS avg_tran_per_month
	FROM
		monthly_transaction
	GROUP BY
		owner_id
	),
categorized AS (
	SELECT
		owner_id,
        avg_tran_per_month,
        CASE
			WHEN avg_tran_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tran_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
		END AS frequency_category
	FROM
		user_average
)
SELECT
	frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tran_per_month), 1) AS avg_transactions_per_month
FROM
	categorized
GROUP BY
	frequency_category
ORDER BY
	FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
    