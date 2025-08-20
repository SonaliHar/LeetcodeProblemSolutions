/*

Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key (combination of columns with unique values) of this table.
employee_id is a foreign key (reference column) to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key (column with unique values) of this table.
Each row of this table contains information about one employee.
 

Write a solution to report all the projects that have the most employees.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output: 
+-------------+
| project_id  |
+-------------+
| 1           |
+-------------+
Explanation: The first project has 3 employees while the second one has 2.
*/

with cte as (
select top 1 max(cnt_employee_id) as max_employee_id
from (
Select P.project_id  ,count(E.employee_id) cnt_employee_id
from Project P join Employee E
on P.employee_id = E.employee_id
group by P.project_id  
)A
order by max(cnt_employee_id) desc
)

Select project_id
from Project
group by project_id
having count(employee_id) >= (Select * from cte);

--solution # 2 : 
with CTE as (
Select  project_id , rank() over(order by count(employee_id) desc) as rnk
from Project
group by project_id
)

select project_id
from CTE
where rnk=1;


