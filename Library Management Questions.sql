Select * From Books;
Select * From branch;
Select * From employees;
Select * From issued_status;
Select * From members;
Select * From return_status;

-- Questions

-- Q1. Book Availability:
-- Retrieve all books with status 'yes' (available) and display their title, category, and rental price.


-- Q2. Member Registration Timeline:
-- List all members who registered in the year 2022, sorted by registration date.


-- Q3. Employee Salary Report:
-- Find all employees with a salary greater than ₹50,000, showing their name, position, and branch ID.



-- Q4. Category Count:
-- Count the total number of books in each category and display the results in descending order.


-- Q5. Most Active Borrowers:
-- Find the top 5 members who have issued the most books, displaying their member ID and total books issued.

-- Q6. Branch-wise Employee Count:
-- Display each branch ID along with the total number of employees working there.

-- Q7. Books Never Returned:
-- Identify all issued books that have no corresponding entry in the return_status table (i.e., still issued).

-- Q8. Employee Issue Performance:
-- Find how many books each employee has issued, showing employee ID, name, and total count.

-- Q9. Revenue per Category:
-- Calculate the total potential rental revenue per book category.

-- Q10. Member's Issued Book History:
-- Display each member's name along with all the book titles they have issued.

-- Q11. Average Return Time:
-- Calculate the average number of days taken to return a book  for each book title.

-- Q12. Branch Manager Details:
-- Display each branch's address, manager's employee ID, and the manager's name and salary.

-- Q13. Overdue Books (30+ days): 
-- Find all issued books that have NOT been returned and were issued more than 30 days ago, showing member name, book title, and issued date.

-- Q14. Most Popular Author:
-- Identify the author whose books have been issued the most times.

-- Q15. Employee-Branch-Manager Hierarchy:
-- Create a report listing each employee's name, their branch address, and their branch manager's name.