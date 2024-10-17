#Fraud-Detection-using-SQL-Project
This project analyzes a financial dataset with over 1 million rows to detect fraud using SQL techniques, including CTEs. Key analyses include identifying suspicious accounts, tracing money laundering paths, computing moving sums of fraudulent transactions, verifying balance calculations, and finding transactions with zero balances. I tackled several key analyses:
* Detected suspicious accounts with large transactions and flagged activity.
* Traced potential money laundering paths through recursive CTEs.
* Computed moving sums of fraudulent transactions over time.
* Verified the accuracy of balance calculations.
* Identified transactions involving zero balances.

Dataset Link:- https://www.kaggle.com/datasets/ealaxi/paysim1/data

In SQL cammand line:-
* STEP-First - CREATE DATABASE bank;
* STEP-Second - USE bank;
* STEP-Third -  CREATE TABLE transactions ( step INT, type VARCHAR(20), amount DECIMAL(15,2), nameOrig VARCHAR(20), oldbalanceOrg DECIMAL(15,2), newbalanceOrig DECIMAL(15,2), nameDest VARCHAR(20), oldbalanceDest DECIMAL(15,2), newbalanceDest DECIMAL(15,2), isFraud TINYINT, isFlaggedFraud TINYINT );

for loading dataset:-
* STEP-Four - LOAD DATA INFILE ""C:/new/PS_20174392719_1491204439457_log.csv"" INTO TABLE transactions FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
After it, You can see my sql file.
