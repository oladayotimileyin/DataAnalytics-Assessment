# DataAnalytics-Assessment
Cowrywise assessment

# Data Analytics SQL Assessment

This is my submission for the SQL assessment. Each question is answered using SQL queries, and I’ve included short notes explaining how I tackled each one. The focus was on clarity, logic, and correct use of joins and aggregation.

---

## Question 1: High-Value Customers with Multiple Products

### Goal:
Find customers who have both a savings plan and an investment plan, and who have made confirmed deposits. The goal is to identify cross-sell opportunities.

### What I Did:
- Joined `users_customuser`, `plans_plan`, and `savings_savingsaccount` to link users, their plans, and deposits.
- Used conditional aggregation to count how many of each plan type a user had.
- Filtered only users with at least one savings and one investment plan.
- Summed only confirmed deposit amounts to get the total value.
- Sorted the results by deposit total in descending order.

### Notes:
- I used `CASE WHEN` inside `SUM()` to count specific plan types.
- Deposits were filtered using `confirmed_amount > 0`.

---

## Question 2: Transaction Frequency Analysis

### Goal:
Classify customers based on how frequently they transact. The business wants to segment them as High, Medium, or Low Frequency.

### What I Did:
- Grouped savings transactions by customer and month.
- Calculated each customer's average number of transactions per month.
- Categorized users based on the average:
  - High: 10 or more/month
  - Medium: 3–9/month
  - Low: 2 or fewer/month
- Finally, grouped these segments to count customers per category and calculate average activity per segment.

### Notes:
- Used `DATE_FORMAT()` to group by month.
- Used a CTE chain to keep things modular and readable.
- Added a safeguard to avoid dividing by zero.

---

## Question 3: Account Inactivity Alert

### Goal:
Find active plans (savings or investments) that haven't had any transactions in over a year.

### What I Did:
- Joined `plans_plan` with `savings_savingsaccount` to connect plans with their transactions.
- Filtered only plans that are not archived using `is_archived = 0`.
- Used `MAX(transaction_date)` to find each plan's latest activity.
- Calculated the number of days since the last transaction.
- Filtered only those with no deposits in the past 365 days.

### Notes:
- Got a MySQL error with `ONLY_FULL_GROUP_BY` and fixed it by aligning `GROUP BY` with selected fields.
- Used `CASE WHEN` to tag plan types as "Savings" or "Investment."

---

## Question 4: Customer Lifetime Value (CLV) Estimation

### Goal:
Estimate a simple version of CLV using transaction volume and account tenure.

### What I Did:
- Calculated tenure as the number of months since each user signed up.
- Counted total transactions and averaged the deposit value.
- Used the formula:  
  `CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction`,  
  where `avg_profit_per_transaction = 0.1%` of deposit value.
- Sorted the result by CLV to highlight the most valuable users.

### Notes:
- Used `NULLIF` in division to prevent errors when tenure is zero.
- Joined user and transaction data, grouped by user, and kept formatting clean.

---

## Final Thoughts

I focused on getting accurate results with queries that are easy to read and maintain. Where things got tricky (like grouping rules in MySQL), I made adjustments and tested until the logic held up.
