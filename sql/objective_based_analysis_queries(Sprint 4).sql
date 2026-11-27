-- RETAIL BANKING TRANSACTION ANALYSIS
-- OBJECTIVE-BASED ANALYSIS QUERIES WITH QUESTIONS (SPRINT 4)



USE retail_banking;


-- OBJECTIVE 4.1: UNDERSTAND CUSTOMER PROFILE AND SEGMENTATION


-- Q1: How many customers belong to each customer segment?
SELECT segment, COUNT(*) AS total_customers
FROM customers
GROUP BY segment
ORDER BY total_customers DESC;

-- Q2: Which cities have the highest number of customers?
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- Q3: Which states have the highest number of customers?
SELECT state, COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;

-- Q4: What is the gender distribution of customers?
SELECT gender, COUNT(*) AS total_customers
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;

-- Q5: What is the average annual income for each customer segment?
SELECT segment, ROUND(AVG(annual_income), 2) AS average_annual_income
FROM customers
GROUP BY segment
ORDER BY average_annual_income DESC;

-- Q6: What is the average credit score for each customer segment?
SELECT segment, ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers
GROUP BY segment
ORDER BY average_credit_score DESC;

-- Q7: How many customers fall under each KYC status?
SELECT kyc_status, COUNT(*) AS total_customers
FROM customers
GROUP BY kyc_status
ORDER BY total_customers DESC;

-- Q8: How many active vs. inactive customers are there in each segment?
SELECT segment, is_active, COUNT(*) AS total_customers
FROM customers
GROUP BY segment, is_active
ORDER BY segment, is_active;

-- Q9: What is the average customer tenure (in years) by segment as of '2025-02-22'?
SELECT
    segment,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, customer_since, '2025-02-22')), 2) AS average_tenure_years
FROM customers
GROUP BY segment
ORDER BY average_tenure_years DESC;

-- Q10: What is the average customer age (in years) by segment as of '2025-02-22'?
SELECT
    segment,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, date_of_birth, '2025-02-22')), 2) AS average_customer_age
FROM customers
GROUP BY segment
ORDER BY average_customer_age DESC;



-- OBJECTIVE 4.2: UNDERSTAND ACCOUNT USAGE AND BRANCH ACTIVITY


-- Q1: How many accounts exist for each account type?
SELECT account_type, COUNT(*) AS total_accounts
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;

-- Q2: Which customers hold multiple bank accounts?
SELECT customer_id, COUNT(*) AS total_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_accounts DESC;

-- Q3: What is the average balance for each account type?
SELECT account_type, ROUND(AVG(current_balance), 2) AS average_balance
FROM accounts
GROUP BY account_type
ORDER BY average_balance DESC;

-- Q4: What is the total balance held in each account type?
SELECT account_type, ROUND(SUM(current_balance), 2) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;

-- Q5: What is the average interest rate across different account types?
SELECT account_type, ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM accounts
GROUP BY account_type
ORDER BY average_interest_rate DESC;

-- Q6: How many accounts are Active vs. Closed?
SELECT status, COUNT(*) AS total_accounts
FROM accounts
GROUP BY status
ORDER BY total_accounts DESC;

-- Q7: Which branches manage the highest number of accounts?
SELECT b.branch_name, COUNT(a.account_id) AS total_accounts
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_accounts DESC;

-- Q8: Which branches hold the highest total account balance?
SELECT b.branch_name, ROUND(SUM(a.current_balance), 2) AS total_balance
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_balance DESC;

-- Q9: What is the average account balance per branch?
SELECT b.branch_name, ROUND(AVG(a.current_balance), 2) AS average_balance
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY average_balance DESC;

-- Q10: How many Active and Closed accounts does each branch have?
SELECT b.branch_name, a.status, COUNT(a.account_id) AS total_accounts
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name, a.status
ORDER BY b.branch_name, a.status;



-- OBJECTIVE 4.3: ANALYZE TRANSACTION PATTERNS


-- Q1: Which transaction types occur most frequently?
SELECT transaction_type, COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_type
ORDER BY total_transactions DESC;

-- Q2: What is the total transaction amount for each transaction type?
SELECT transaction_type, ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

-- Q3: What is the average transaction amount for each transaction type?
SELECT transaction_type, ROUND(AVG(amount), 2) AS average_amount
FROM transactions
GROUP BY transaction_type
ORDER BY average_amount DESC;

-- Q4: Which banking channels have the highest number of transactions?
SELECT channel, COUNT(*) AS total_transactions
FROM transactions
GROUP BY channel
ORDER BY total_transactions DESC;

-- Q5: What is the total transaction amount by channel?
SELECT channel, ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY channel
ORDER BY total_amount DESC;

-- Q6: What is the average transaction amount by channel?
SELECT channel, ROUND(AVG(amount), 2) AS average_amount
FROM transactions
GROUP BY channel
ORDER BY average_amount DESC;

-- Q7: How many transactions are Completed, Failed, or Pending?
SELECT status, COUNT(*) AS total_transactions
FROM transactions
GROUP BY status
ORDER BY total_transactions DESC;

-- Q8: What is the total transaction amount by transaction status?
SELECT status, ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY status
ORDER BY total_amount DESC;

-- Q9: What are the most common transaction descriptions?
SELECT description, COUNT(*) AS total_transactions
FROM transactions
GROUP BY description
ORDER BY total_transactions DESC;

-- Q10: How does transaction volume trend by year and month?
SELECT
    YEAR(transaction_date) AS txn_year,
    MONTH(transaction_date) AS txn_month,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY txn_year, txn_month;

-- Q11: Which accounts have the highest number of transactions?
SELECT account_id, COUNT(*) AS total_transactions
FROM transactions
GROUP BY account_id
ORDER BY total_transactions DESC
LIMIT 10;



-- OBJECTIVE 4.4: EVALUATE LOAN PERFORMANCE AND REPAYMENT BEHAVIOUR


-- Q1: How many loans exist for each loan type?
SELECT loan_type, COUNT(*) AS total_loans
FROM loans
GROUP BY loan_type
ORDER BY total_loans DESC;

-- Q2: What is the total principal amount disbursed for each loan type?
SELECT loan_type, ROUND(SUM(principal_amount), 2) AS total_principal
FROM loans
GROUP BY loan_type
ORDER BY total_principal DESC;

-- Q3: What is the total outstanding balance by loan type?
SELECT loan_type, ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY total_outstanding_balance DESC;

-- Q4: What is the average outstanding balance by loan type?
SELECT loan_type, ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY average_outstanding_balance DESC;

-- Q5: How many loans fall under each loan status (Active, Closed, In Arrears, Defaulted)?
SELECT loan_status, COUNT(*) AS total_loans
FROM loans
GROUP BY loan_status
ORDER BY total_loans DESC;

-- Q6: What are the most common purposes for taking a loan?
SELECT purpose, COUNT(*) AS total_loans
FROM loans
GROUP BY purpose
ORDER BY total_loans DESC;

-- Q7: Which payment methods are most commonly used for loan repayments?
SELECT payment_method, COUNT(*) AS total_payments
FROM loan_payments
GROUP BY payment_method
ORDER BY total_payments DESC;

-- Q8: What is the breakdown of loan payment statuses (Paid, Late, Missed, Pending)?
SELECT status, COUNT(*) AS total_payments
FROM loan_payments
GROUP BY status
ORDER BY total_payments DESC;

-- Q9: Which loan types generate the highest total late penalties?
SELECT l.loan_type, ROUND(SUM(lp.penalty), 2) AS total_penalty
FROM loans l
JOIN loan_payments lp ON l.loan_id = lp.loan_id
GROUP BY l.loan_type
ORDER BY total_penalty DESC;

-- Q10: What is the average number of days late for each loan type?
SELECT l.loan_type, ROUND(AVG(lp.days_late), 2) AS average_days_late
FROM loans l
JOIN loan_payments lp ON l.loan_id = lp.loan_id
GROUP BY l.loan_type
ORDER BY average_days_late DESC;

-- Q11: What is the total amount paid back for each loan type?
SELECT l.loan_type, ROUND(SUM(lp.paid_amount), 2) AS total_paid_amount
FROM loans l
JOIN loan_payments lp ON l.loan_id = lp.loan_id
GROUP BY l.loan_type
ORDER BY total_paid_amount DESC;

-- Q12: Which branches have the highest total loan repayment penalties?
SELECT b.branch_name, ROUND(SUM(lp.penalty), 2) AS total_penalty
FROM branches b
JOIN loans l ON b.branch_id = l.branch_id
JOIN loan_payments lp ON l.loan_id = lp.loan_id
GROUP BY b.branch_name
ORDER BY total_penalty DESC;



-- OBJECTIVE 4.5: UNDERSTAND CARD USAGE AND PRODUCT ENGAGEMENT


-- Q1: How many Debit vs. Credit cards have been issued?
SELECT card_type, COUNT(*) AS total_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;

-- Q2: How many cards are currently Active vs. Inactive?
SELECT is_active, COUNT(*) AS total_cards
FROM cards
GROUP BY is_active
ORDER BY total_cards DESC;

-- Q3: What is the average credit limit by card type?
SELECT card_type, ROUND(AVG(credit_limit), 2) AS average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY average_credit_limit DESC;

-- Q4: What is the total outstanding balance by card type?
SELECT card_type, ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM cards
GROUP BY card_type
ORDER BY total_outstanding_balance DESC;

-- Q5: What are the average reward points by card type?
SELECT card_type, ROUND(AVG(reward_points), 2) AS average_reward_points
FROM cards
GROUP BY card_type
ORDER BY average_reward_points DESC;

-- Q6: How many cards belong to each card network (Visa, Mastercard, Amex, Discover)?
SELECT network, COUNT(*) AS total_cards
FROM cards
GROUP BY network
ORDER BY total_cards DESC;

-- Q7: What is the latest transaction date (reference "today") and how many cards are expired?
SELECT MAX(transaction_date) AS latest_date
FROM transactions;

SELECT COUNT(*) AS expired_cards
FROM cards
WHERE expiry_date < '2025-02-22';

-- Q8: Which accounts have the most cards linked to them?
SELECT a.account_id, COUNT(c.card_id) AS total_cards
FROM accounts a
JOIN cards c ON a.account_id = c.account_id
GROUP BY a.account_id
ORDER BY total_cards DESC
LIMIT 10;

-- Q9: How many accounts, loans, and cards does each customer hold?
SELECT
    c.customer_id,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    COUNT(DISTINCT cd.card_id) AS total_cards
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN loans l ON c.customer_id = l.customer_id
LEFT JOIN cards cd ON a.account_id = cd.account_id
GROUP BY c.customer_id;

-- Q10: Which customer segments hold the most cards?
SELECT cu.segment, COUNT(DISTINCT cd.card_id) AS total_cards
FROM customers cu
JOIN accounts a ON cu.customer_id = a.customer_id
JOIN cards cd ON a.account_id = cd.account_id
GROUP BY cu.segment
ORDER BY total_cards DESC;

-- Q11: Which branches have issued the most cards through their accounts?
SELECT b.branch_name, COUNT(c.card_id) AS total_cards
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
JOIN cards c ON a.account_id = c.account_id
GROUP BY b.branch_name
ORDER BY total_cards DESC;
