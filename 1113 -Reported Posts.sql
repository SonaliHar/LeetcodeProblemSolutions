/*Table: Actions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| post_id       | int     |
| action_date   | date    | 
| action        | enum    |
| extra         | varchar |
+---------------+---------+
This table may have duplicate rows.
The action column is an ENUM (category) type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
The extra column has optional information about the action, such as a reason for the report or a type of reaction.
extra is never NULL.
 

Write a solution to report the number of posts reported yesterday for each report reason. Assume today is 2019-07-05.

Return the result table in any order.

*/

/* Write your T-SQL query statement below */

with cte as (
Select distinct case when action ='report' then  extra
end as report_reason, post_id
from Actions
where action_date = cast(dateadd(day,-1,'2019-07-05') as date) and
extra is not null 
)

Select report_reason ,count(*) as report_count 
from cte
where report_reason is not null 
group by  report_reason
