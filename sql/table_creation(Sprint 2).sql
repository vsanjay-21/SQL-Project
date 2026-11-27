-- RETAIL BANKING TRANSACTION ANALYSIS
-- FILE 1: DATABASE & TABLE CREATION (SPRINT 2)


-- Check MySQL version
SELECT VERSION();

-- Create and select the database
CREATE DATABASE IF NOT EXISTS retail_banking;
USE retail_banking;

-- Verify active database
SHOW DATABASES;
SELECT DATABASE();


-- PARENT TABLES (No Foreign Keys)

-- 1. Branches Table
CREATE TABLE branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(30),
    region VARCHAR(30),
    opening_date DATE,
    employee_count INT
);

-- 2. Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(30),
    customer_since DATE,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(12,2),
    credit_score INT,
    is_active VARCHAR(3)
);


-- CORE PRODUCT TABLES (Depend on Customers & Branches)

-- 3. Accounts Table
CREATE TABLE accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    branch_id VARCHAR(10),
    account_type VARCHAR(30),
    open_date DATE,
    close_date DATE,
    current_balance DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    overdraft_limit DECIMAL(12,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- 4. Loans Table
CREATE TABLE loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    branch_id VARCHAR(10),
    loan_type VARCHAR(30),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(12,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(30),
    purpose VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);


-- LINKED PRODUCT & ACTIVITY TABLES (Depend on Accounts & Loans)

-- 5. Cards Table
CREATE TABLE cards (
    card_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    card_type VARCHAR(20),
    issue_date DATE,
    expiry_date DATE,
    credit_limit DECIMAL(12,2),
    outstanding_balance DECIMAL(12,2),
    reward_points INT,
    is_active VARCHAR(3),
    network VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- 6. Transactions Table
CREATE TABLE transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    transaction_date DATE,
    transaction_time TIME,
    transaction_type VARCHAR(30),
    amount DECIMAL(15,2),
    channel VARCHAR(30),
    description VARCHAR(50),
    balance_after DECIMAL(15,2),
    status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- 7. Loan Payments Table
CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20),
    payment_date DATE,
    scheduled_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2),
    principal_paid DECIMAL(12,2),
    interest_paid DECIMAL(12,2),
    penalty DECIMAL(12,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);


-- DATA IMPORT VERIFICATION QUERIES

-- List all tables
SHOW TABLES;

-- Inspect table structures
DESCRIBE branches;
DESCRIBE customers;
DESCRIBE accounts;
DESCRIBE loans;
DESCRIBE cards;
DESCRIBE transactions;
DESCRIBE loan_payments;

-- Verify Foreign Key relationships
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'retail_banking'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

-- Verify record counts after CSV import
SELECT 'branches' AS table_name, COUNT(*) AS total_records FROM branches
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'cards', COUNT(*) FROM cards
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'loan_payments', COUNT(*) FROM loan_payments;

-- Preview sample records
SELECT * FROM customers LIMIT 10;
SELECT * FROM accounts LIMIT 10;
SELECT * FROM transactions LIMIT 10;
SELECT * FROM loans LIMIT 10;
