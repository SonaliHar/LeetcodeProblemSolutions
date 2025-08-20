/* 

Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation: 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33


*/

/* Write your T-SQL query statement below */
with cte as (
Select query_name,sum(per_quality) as per_quality, count(*) as total_cnt
from (
Select  query_name,cast((cast(rating as float)/cast(position as  float)) as float) as 
per_quality --,count(query_name) as total_cnt
from Queries 
)A
group by query_name,per_quality
)

, cte2 as (
Select query_name ,count(cast(isnull(rating ,0) as float)) as cnt_rating
from Queries
where rating<3
group by query_name
)


Select a.query_name,
round((sum(isnull(per_quality,0))/sum(isnull(total_cnt,0))),2) as quality,
round((cast(isnull(cnt_rating ,0) as float)/cast(sum(isnull(total_cnt,0)) as float))*100,2) as poor_query_percentage 
from cte a 
left join cte2 b
on a.query_name=b.query_name
group by  a.query_name,cnt_rating



--2nd way 
 select query_name
,round(avg(rating*1.0 /position),2) as quality ,
round(avg(case when rating<3 then 1.0 else 0 end)*100,2) as poor_query_percentage 
from Queries q
group by query_name


