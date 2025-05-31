/* 

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).



Solution : Runtime: 287 ms
*/

with cte as (
Select id ,recordDate as original_recordDate, 
temperature as original_temperature,
lead (id) over( order by recordDate ) lead_id,
lead (recordDate) over( order by recordDate ) lead_recordDate,
lead (temperature) over( order by recordDate ) lead_temperature
from Weather)

select lead_id  as id 
from cte 
where lead_id is not null
and datediff(day,original_recordDate,lead_recordDate)=1
and lead_temperature>original_temperature;



select w1.id as Id
from Weather w1
join Weather w2 on w1.recordDate = DATEADD(day, 1, w2.recordDate)
where w1.temperature > w2.temperature;


