Select * From Books;
Select * From branch;
Select * From employees;
Select * From issued_status;
Select * From members;
Select * From return_status;

-- Questions

-- Q1. Book Availability:
-- Retrieve all books with status 'yes' (available) and display their title, category, and rental price.

Select book_title, category, rental_price
From books
Where status = 'Yes' ;

-- Q2. Member Registration Timeline:
-- List all members who registered in the year 2022, sorted by registration date.

Select *
From members
Where Year(reg_date) = 2022
Order by reg_date ;

-- Q3. Employee Salary Report:
-- Find all employees with a salary greater than ₹50,000, showing their name, position, and branch ID.

Select emp_name, position , branch_id
From employees
Where salary > 50000 ;

-- Q4. Category Count:
-- Count the total number of books in each category and display the results in descending order.

Select Category, count(book_title) as No_of_Books
From books
Group by category 
Order by No_of_Books Desc ;

-- Q5. Most Active Borrowers:
-- Find the top 5 members who have issued the most books, displaying their member ID and total books issued.

Select issued_member_id as member_id,
Count(issued_book_isbn) as Total_Books
From issued_status
Group by issued_member_id
Order by Total_Books Desc 
Limit 5 ;

-- Q6. Branch-wise Employee Count:
-- Display each branch ID along with the total number of employees working there.

Select b.branch_id, Count(emp_id) as Total_Employees
From branch as b
Left Join employees as e
On b.branch_id = e.branch_id 
Group by b.branch_id ;

-- Q7. Books Never Returned:
-- Identify all issued books that have no corresponding entry in the return_status table (i.e., still issued).

Select iss.issued_id, iss.issued_book_name, rs.return_date
From issued_status as iss
Left Join return_status  as rs
On iss.issued_id = rs.issued_id 
Where rs.return_date is null ;

-- Q8. Employee Issue Performance:
-- Find how many books each employee has issued, showing employee ID, name, and total count.

Select e.emp_id, e.emp_name, 
Count(iss.issued_book_isbn) as Issued_Books
From employees as e
Left Join issued_status as iss
On e.emp_id = iss.issued_emp_id
Group by e.emp_id, e.emp_name ;

-- Q9. Revenue per Category:
-- Calculate the total potential rental revenue per book category.

Select b.category, Sum(b.rental_price) as Revenue
From books as b
Inner Join issued_status as iss
On b.isbn = iss.issued_book_isbn 
Group by b.category 
Order by revenue Desc ;

-- Q10. Member's Issued Book History:
-- Display each member's name along with all the book titles they have issued.

Select m.member_name, group_concat(iss.issued_book_name) as Book_Titles
From members as m
Left Join issued_status as iss
on m.member_id = iss.issued_member_id
Group by m.member_name ;

-- Q11. Average Return Time:
-- Calculate the average number of days taken to return a book for each book title.

Select iss.issued_book_name, 
Avg(datediff(rs.return_date, iss.issued_date)) as avg_Return_time
From issued_status as iss
Inner Join return_status as rs
on iss.issued_id = rs.issued_id 
Group by iss.issued_book_name ;

-- Q12. Branch Manager Details:
-- Display each branch's address, manager's employee ID, and the manager's name and salary.

Select b.branch_id, b.branch_address, e.emp_id as Manager_Emp_Id,
e.emp_name as Manager_Name, e.salary as Manager_Salary
From branch as b
Left Join employees as e
on b.manager_id = e.emp_id ;

-- Q13. Overdue Books (30+ days): 
-- Find all issued books that have NOT been returned and were issued more than 30 days ago, showing member name, book title, and issued date.

With Cte1 as (
Select  m.member_name , iss.issued_book_name, iss.issued_date,
datediff(curdate(), iss.issued_date) as days_taken
From issued_status as iss
left Join return_status as rs
on iss.issued_id = rs.issued_id
Left Join members as m
On iss.issued_member_id = m.member_id
Where rs.return_id is null )

Select member_name, issued_book_name, issued_date
From cte1
Where days_taken > 30 ;

-- Q14. Most Popular Author:
-- Identify the author whose books have been issued the most times.

With Cte1 as (
Select author, issued_cnt,
Dense_Rank() Over(Order by issued_cnt Desc) as rnk
From (
		Select b.author, Count(iss.issued_book_isbn) as Issued_Cnt
		From books as b
		Inner Join issued_status as iss
		On b.isbn = iss.issued_book_isbn
		Group by b.author 
		Order by Issued_cnt Desc ) as a  )
        
Select author, issued_cnt
From cte1
Where rnk = 1 ;

-- Q15. Employee-Branch-Manager Hierarchy:
-- Create a report listing each employee's name, their branch address, and their branch manager's name.

Select e.emp_name, e.branch_address, m.emp_name as Manager_Name
From (
		Select e.emp_id, e.emp_name, b.branch_address,b.manager_id
		From employees as e
		Inner Join branch as b
		On e.branch_id = b.branch_id ) as e
Inner Join employees as m
On e.manager_id = m.emp_id ;

