# Bookstore SQL Analysis

## Project Overview

This project analyzes a bookstore dataset using PostgreSQL and pgAdmin. The goal is to answer business questions about bookstore orders, book genres, revenue, and customer purchasing behavior using SQL queries.

> **Data note:** Use the provided CSV files. The results section is intentionally left as a placeholder until the queries are run against your own database.

## Tools Used

- PostgreSQL
- pgAdmin
- SQL
- CSV files as the data source

## Project Files

```text
01-bookstore-sql-analysis/
├── Bookstore_Analysis.sql
└── README.md
```

## Database Setup

1. Create or select your bookstore database in PostgreSQL.
2. Open `Bookstore_Analysis.sql` in pgAdmin's Query Tool.
3. Check the three CSV file paths in the `COPY` statements. The current script may use a path such as `C:/Csv files/`. Update the paths if your CSV files are stored elsewhere.
4. Run the setup section to create and load the tables.
5. Run the analysis questions and check the results in pgAdmin.

**Important:** PostgreSQL must be able to access the CSV files at the paths used by the script. If a `COPY` command reports a file-path or permission error, correct the path or use the appropriate import method for your setup.

## Analysis Covered

The SQL analysis includes questions such as:

- Calculating total bookstore revenue.
- Identifying the genre with the highest number of books sold.
- Finding the most frequently ordered book.
- Finding the customer who spent the most.
- Using aggregation, grouping, sorting, and joins to summarize bookstore activity.

## Key SQL Concepts

- `SELECT` and `WHERE`
- `JOIN`
- `GROUP BY` and aggregate functions such as `SUM()` and `COUNT()`
- `ORDER BY` and `DESC`
- Aliases for readable output
- Table creation and CSV data loading

## Selected Query Results

Fill in these values after running the matching queries in pgAdmin. Do not guess the numbers; use the results returned by your database.

| Question | Result to record | Your result |
|---|---|---|
| Q11 | Total revenue | `Pending` |
| Q12 | Top-selling genre and number of books sold | `Pending` |
| Q15 | Most frequently ordered book | `Pending` |
| Q19 | Highest-spending customer and amount spent | `Pending` |

## Notes

- The CSV paths in the SQL script may need to be changed for your computer.
- Run the script in pgAdmin and resolve any errors before publishing the project.
- Replace each `Pending` value in the results table with the actual output from your query.

## How to Run

1. Open pgAdmin and connect to your PostgreSQL server.
2. Open the bookstore database and launch **Tools → Query Tool**.
3. Open `Bookstore_Analysis.sql`.
4. Verify the CSV paths and run the script in the intended order.
5. Record the outputs for Q11, Q12, Q15, and Q19 in this README.

## Project Purpose

This is a SQL portfolio project demonstrating how PostgreSQL can be used to query bookstore data and turn transaction records into useful business insights.
