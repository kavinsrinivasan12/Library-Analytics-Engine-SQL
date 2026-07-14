# 📚 Library Analytics Engine

An end-to-end SQL analytics project built on a synthetic library dataset (6 tables, 5,000+ rows each) covering book inventory, member activity, employee performance, and branch operations. The project moves from schema design through data quality auditing to 15 business-driven SQL queries spanning aggregation, multi-table joins, CTEs, and window functions.

## 📂 Dataset

| Table | Rows | Description |
|---|---|---|
| `books` | 5,000 | Title, category, author, publisher, rental price, availability status |
| `members` | 5,000 | Member profile and registration date |
| `employees` | 5,000 | Staff details, position, salary, branch assignment |
| `branch` | 8 | Branch address, contact info, assigned manager |
| `issued_status` | 5,000 | Book issue transactions (member, book, employee, date) |
| `return_status` | 5,000 | Book return transactions linked to issued records |

## 🧹 Data Quality Audit

Before writing queries, I ran an integrity check across all six tables:

- ✅ No missing values or duplicate rows in `books`, `members`, `employees`, or `branch`
- ✅ All foreign keys resolve correctly (every issued book, member, and employee ID has a valid parent record)
- ⚠️ `return_status` contains 18 rows with missing return details, 3 of which are **orphan records** referencing an `issued_id` that doesn't exist in `issued_status`
- ⚠️ 2 `issued_id` values appear **twice** in `return_status` (duplicate returns logged against the same issue) — a known real-world data issue that can silently inflate counts in return-based aggregations if not handled with care
- ⚠️ `status` values in `books` are stored in lowercase (`yes`/`no`); queries should match casing or use `LOWER()` for portability across database engines

Flagging and working around these issues (rather than assuming clean data) was part of the exercise.

## 🔍 Business Questions Answered

15 SQL queries answering real library-operations questions, including:

- Book availability and category-wise inventory
- Member registration trends and most active borrowers
- Employee salary and issue-performance reporting
- Branch-wise staffing and manager hierarchy
- Revenue by book category
- Books never returned / overdue 30+ days (CTEs)
- Average return time per title
- Most popular author (window functions: `DENSE_RANK`)

## 🛠️ Tools & Concepts

`MySQL` · Joins (`INNER`, `LEFT`) · Aggregations (`SUM`, `COUNT`, `AVG`) · `GROUP BY` / `HAVING` · CTEs · Window Functions (`DENSE_RANK`) · Date functions (`DATEDIFF`) · `GROUP_CONCAT`

## 📈 Key Insights

- Fiction is both the largest category by book count and the top revenue generator (~₹2,921)
- Self-Help has the lowest rental revenue and smallest catalog share
- Only a small fraction of issued books remain overdue past 30 days — most returns happen within a healthy window
- One author (Abdul Sant) accounts for the highest number of book issues across the catalog


---
