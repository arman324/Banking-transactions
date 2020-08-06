# Banking Transactions
## Overview
Banks have many customers who can open an account and trade during the day. With each transaction, the value of their deposit may increase or decrease. Also, we have several ways to withdraw money or put money in the bank. For example, you can use credit cards or do it in-person. 
## Goal
We know that every transaction has many components like a voucher id, transaction date, transaction time, source id, destination id, and amount. In this project, we want to use these components to find the final destination of this money after the current transaction or to find the first source of this money before the current transaction. Suppose we have a transaction from X to Y with the amount of $100 and the Transaction date is 2019-04-16. To achieve this goal, we must consider the following criteria and create a related graph:
1.
2.
3.
4.
## Requirements
* [SQL Server 2019](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
* [SQL Management Tools for SQL server](https://www.guru99.com/top-20-sql-management-tools.html)
* Python 3.7.4
* ``pip install networkx``
* [kivy](https://kivy.org/#download)
## How to Run
1. First of all, you need to connect to the SQL Server.
2. Use [SQL_File.sql](https://github.com/arman324/Banking-transactions/blob/master/SQL_File.sql) to create tables and insert data into them, then create two procedures in [Procedure.sql](https://github.com/arman324/Banking-transactions/blob/master/Procedure.sql) and [Procedure_Left.sql](https://github.com/arman324/Banking-transactions/blob/master/Procedure_Left.sql).
3. Finally, run ``python3 BankingTransactions.py`` or ``python BankingTransactions.py`` in your terminal.
4. You can now work with the GUI.
## Output

## Support
Reach out to me at riasiarman@yahoo.com
