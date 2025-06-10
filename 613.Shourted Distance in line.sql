/*

Table: Point

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
+-------------+------+
In SQL, x is the primary key column for this table.
Each row of this table indicates the position of a point on the X-axis.
 

Find the shortest distance between any two points from the Point table.

The result format is in the following example.

 

Example 1:

Input: 
Point table:
+----+
| x  |
+----+
| -1 |
| 0  |
| 2  |
+----+
Output: 
+----------+
| shortest |
+----------+
| 1        |
+----------+
Explanation: The shortest distance is between points -1 and 0 which is |(-1) - 0| = 1.
 

Follow up: How could you optimize your solution if the Point table is ordered in ascending order?

Accepted
Runtime: 239 ms

*/

with cte as (
select abs(x) original_len,isnull(lead(abs(x)) over(order by x),0) lead_len
from Point
)
select top 1
abs(abs(original_len) - abs(lead_len)) as shortest 
from cte
where abs(abs(original_len) - abs(lead_len))>0
order by abs(abs(original_len) - abs(lead_len));

Select min(abs(P.x-P1.x)) as shortest 
 from Point P
 join Point P1
 on P.x-P1.x>0;




