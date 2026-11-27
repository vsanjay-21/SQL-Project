-- RETAIL BANKING TRANSACTION ANALYSIS
-- BASIC ANALYSIS / DATA EXPLORATION QUERIES (SPRINT 3)


USE retail_banking;

-- Q11: What is the total number of customers?
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q12: What is the total number of accounts?
SELECT COUNT(*) AS total_accounts
FROM accounts;

-- Q13: What are the different account types available?
SELECT DISTINCT account_type
FROM accounts;

-- Q14: How many customers are currently active?
SELECT COUNT(*) AS active_customers
FROM customers
WHERE is_active = 'Yes';

-- Q15: What are the different transaction types available?
SELECT DISTINCT transaction_type
FROM transactions;

-- Q16: What is the total amount of completed transactions?
SELECT ROUND(SUM(amount), 2) AS total_completed_transaction_amount
FROM transactions
WHERE status = 'Completed';

-- Q17: What are the different loan types available?
SELECT DISTINCT loan_type
FROM loans;

-- Q18: What is the total number of loans?
SELECT COUNT(*) AS total_loans
FROM loans;

-- Q19: What are the different card types available?
SELECT DISTINCT card_type
FROM cards;

-- Q20: What is the total outstanding loan balance?
SELECT ROUND(SUM(outstanding_balance), 2) AS total_outstanding_loan_balance
FROM loans;
