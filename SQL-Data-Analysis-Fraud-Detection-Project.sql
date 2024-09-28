use bank;
SELECT * FROM transactions;

-- 1).Advanced Fraud Detection Through the Use of Multiple CTEs
-- Q.Use multiple CTEs to find accounts with suspecious activity, 
--   like big money transfers, back-to-back transactions with no balance change, and flagged transactions.
WITH large_transfers AS (
    SELECT nameOrig, step, amount 
    FROM transactions 
    WHERE type = 'TRANSFER' AND amount > 500000
),
no_balance_change AS (
    SELECT nameOrig, step, oldbalanceOrg, newbalanceOrg 
    FROM transactions 
    WHERE oldbalanceOrg = newbalanceOrg
),
flagged_transactions AS (
    SELECT nameOrig, step 
    FROM transactions 
    WHERE isFlaggedFraud = 1
) 
SELECT lt.nameOrig
FROM large_transfers lt
JOIN no_balance_change nbc ON lt.nameOrig = nbc.nameOrig AND lt.step = nbc.step
JOIN flagged_transactions ft ON lt.nameOrig = ft.nameOrig AND lt.step = ft.step;


-- 2). Identifying Recurring Fraudulent Transactions:-
-- Q. Use a recursive CTE to trace possible money laundering 
--    paths where funds move between accounts over several steps, 
--    with each transaction marked as fraudulent.
WITH RECURSIVE fraudulent_chain as (
SELECT nameOrig as initial_account,
nameDest as next_account, step, amount, newbalanceOrg
FROM transactions
WHERE isFraud = 1 and type = 'TRANSFER'

UNION ALL 
SELECT fc.initial_account,t.nameDest,t.step,t.amount ,t.newbalanceOrg
FROM fraudulent_chain fc JOIN transactions t
ON fc.next_account = t.nameOrig and fc.step < t.step 
where t.isFraud = 1 and t.type = 'TRANSFER')

SELECT * FROM fraudulent_chain;


-- 3).Examining fraudulent transactions across time:-
-- Q.Write a Common Table Expression (CTE) to compute the moving 
--   sum of fraudulent transactions for each account, covering the last 5 time periods.
WITH rolling_fraud AS (
SELECT nameOrig, step, SUM(isFraud) 
OVER (PARTITION BY nameorig 
ORDER BY STEP ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) 
AS fraud_rolling FROM transactions)

SELECT * FROM rolling_fraud
WHERE fraud_rolling > 0;


-- 4)Q.create a query that verifies whether the computed value of new_updated_Balance 
-- matches the actual newbalanceDest in the table. If they are identical, the query should return those rows.
WITH CTE as (
SELECT amount,nameorig,oldbalancedest,newbalanceDest,(amount+oldbalancedest) 
as new_updated_Balance 
FROM transactions)

SELECT * FROM CTE 
where new_updated_Balance = newbalanceDest;


-- 5)Q.Identify Transactions Involving Zero Balance:-
-- Objective: Identify transactions in which the destination account had a zero balance either prior to or following the transaction.
-- SQL Query: Construct a query to retrieve transactions where either oldbalanceDest or newbalanceDest equals zero.
SELECT *
FROM transactions
WHERE oldbalanceDest = 0 OR newbalanceDest = 0;



