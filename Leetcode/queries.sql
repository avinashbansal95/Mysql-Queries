
175. Combine Two Tables -- Easy
-- Oracle
select FirstName, LastName, City, State
from Person P
left join Address A on p.personid=A.personid



/*** --- Next Question --- ***/



176. Second Highest Salary -- Medium
-- MySQL
select ifnull(
          (select max(salary) as SecondHighestSalary
          from employee
          where salary < (select max(salary) from employee))
          , NULL) as SecondHighestSalary

-- MySQL - using window function
select ifnull(
          (select max(salary) as salary
          from  (select id,salary, rank() over(order by salary desc) as rnk from employee e) x
          where x.rnk = 2)
          , NULL) as SecondHighestSalary from dual

-- Oracle
select nvl(
    (select max(salary ) as salary
    from  (select id,salary, rank() over(order by salary desc) as rnk from employee e) x
    where x.rnk = 2)
        , NULL) as SecondHighestSalary from dual



/*** --- Next Question --- ***/



177. Nth Highest Salary -- Medium
-- Oracle
CREATE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
result NUMBER;
BEGIN
    /* Write your PL/SQL query statement below */

    select distinct x.salary
    into result
    from (
        select id, salary, dense_rank() over (order by salary desc) as nth_salary
        from employee) x
    where x.nth_salary = n;

    RETURN result;

exception
when no_data_found
then
    return null;
END;



/*** --- Next Question --- ***/



178. Rank Scores -- Medium
-- Oracle
select score,
dense_rank() over (order by score desc) as rank
from scores;



/*** --- Next Question --- ***/



180. Consecutive Numbers -- Medium
-- Oracle
select distinct x.ConsecutiveNums
from (
    select
    case when num = (lead(num) over (order by id)) then
        case when num = (lead(num,2) over (order by id)) then num end
    end ConsecutiveNums
    from logs) x
where x.ConsecutiveNums is not null;



/*** --- Next Question --- ***/



181. Employees Earning More Than Their Managers -- Easy
-- MySQL
select emp.name as employee
from employee as emp
join employee as mng
    on emp.managerid = mng.id
    and emp.salary > mng.salary;



/*** --- Next Question --- ***/



182. Duplicate Emails -- Easy
-- Oracle
select email from person p
group by email
having count(1) > 1;



/*** --- Next Question --- ***/



183. Customers Who Never Order -- Easy
-- MySQL
select c.name as customers
from customers c
where not exists (select 1 from orders o
                 where o.customerid=c.id);



/*** --- Next Question --- ***/



184. Department Highest Salary -- Medium
-- MySQL
select department, employee, salary
from (
   select d.name as department,e.name as employee,e.salary,
   rank() over (partition by departmentid order by salary desc) rnk
   from employee e
   join department d on d.id=e.departmentid ) x
where x.rnk = 1;



/*** --- Next Question --- ***/



185. Department Top Three Salaries -- Hard
-- MySQL
select department, employee, salary
from (
    select d.name as department, e.name as employee, e.salary,
    dense_rank() over (partition by d.name order by e.salary desc) as rnk
    from employee e
    join department d on d.id=e.departmentid) x
where x.rnk < 4;



/*** --- Next Question --- ***/



196. Delete Duplicate Emails -- Easy
-- MySQL
delete from person
where id not in
    (select id from (select min(id) as id from person group by email) p);



/*** --- Next Question --- ***/



197. Rising Temperature -- Easy
-- Oracle
select w2.id
from weather w1
join weather w2
    on w1.recorddate = w2.recorddate - 1
    and w1.temperature < w2.temperature

-- MySQL
select w2.id
from weather w1
join weather w2
    on w1.recorddate = date_sub(w2.recorddate, interval 1 day)
    and w1.temperature < w2.temperature;

-- MSSQL
select w2.id
from weather w1
join weather w2
    on w1.recorddate = dateadd(DAY, -1, w2.recorddate)
    and w1.temperature < w2.temperature;



/*** --- Next Question --- ***/



262. Trips and Users -- Hard
-- Oracle
with data as
        (select request_at, status
        from trips t
        where exists (select 1 from users u
                      where banned = 'No'
                      and   u.users_id = t.client_id)
        and   exists (select 1 from users u
                      where banned = 'No'
                      and   u.users_id = t.driver_id)
        and to_date(t.request_at, 'yyyy-mm-dd')
                between to_date('2013-10-01', 'yyyy-mm-dd')
                and to_date('2013-10-03', 'yyyy-mm-dd')),
    total_requests as
        (select request_at, count(1) as no_of_requests
        from data
        group by request_at),
    total_cancels as
        (select request_at, count(1) as no_of_cancels
        from data
        where status in ('cancelled_by_driver', 'cancelled_by_client')
        group by request_at)
select tr.request_at as "Day"
    , round(coalesce(tc.no_of_cancels, 0) / tr.no_of_requests, 2) as "Cancellation Rate"
from total_requests tr
left join total_cancels tc on tr.request_at = tc.request_at;

-- MySQL
with data as
        (select request_at, status
        from trips t
        where exists (select 1 from users u
                     where u.banned = 'No' and u.users_id = t.client_id)
        and   exists (select 1 from users u
                     where u.banned = 'No' and u.users_id = t.driver_id)
        and date_format(request_at, '%Y-%m-%d')
                between date_format('2013-10-01', '%Y-%m-%d')
                and date_format('2013-10-03', '%Y-%m-%d')),
    total_requests as
        (select request_at , count(1) as no_of_requests
        from data
        group by request_at),
    total_cancels as
        (select request_at , count(1) as no_of_cancels
        from data
        where status in ('cancelled_by_driver', 'cancelled_by_client')
        group by request_at)
select tr.request_at as Day
, round(coalesce(tc.no_of_cancels, 0) / tr.no_of_requests, 2) as "Cancellation Rate"
from total_requests tr
left join total_cancels tc on tr.request_at = tc.request_at;

-- MSSQL
with data as
        (select request_at, status
        from trips t
        where exists (select 1 from users u
                      where banned = 'No'
                      and   u.users_id = t.client_id)
        and   exists (select 1 from users u
                      where banned = 'No'
                      and   u.users_id = t.driver_id)
        and cast(t.request_at as date)
                between cast('2013-10-01' as date)
                and cast('2013-10-03' as date)),
    total_requests as
        (select request_at, count(1) as no_of_requests
        from data
        group by request_at),
    total_cancels as
        (select request_at, count(1) as no_of_cancels
        from data
        where status in ('cancelled_by_driver', 'cancelled_by_client')
        group by request_at)
select tr.request_at as "Day"
    , cast(
            cast(coalesce(tc.no_of_cancels, 0) as numeric(12,2)) /
            cast(tr.no_of_requests as numeric(12,2))
        as numeric(12,2) )
    as "Cancellation Rate"
from total_requests tr
left join total_cancels tc on tr.request_at = tc.request_at;



/*** --- Next Question --- ***/



595. Big Countries -- Easy
-- MySQL
select name, population, area
from world
where population > 25000000
or area > 3000000;



/*** --- Next Question --- ***/



596. Classes More Than 5 Students -- Easy
-- Oracle
select class
from courses
group by class
having count(1) >= 5;



/*** --- Next Question --- ***/



601. Human Traffic of Stadium -- Hard
-- MySQL: Solution 1
select id, visit_date, people
from (
    select *
    , case when people >= 100
                and  lead(people) over (order by id) >= 100
                and  lead(people,2) over (order by id) >= 100
                then 'Y'
           when people >= 100
                and  lag(people) over (order by id) >= 100
                and  lag(people,2) over (order by id) >= 100
                then 'Y'
           when people >= 100
                and  lag(people) over (order by id) >= 100
                and  lead(people) over (order by id) >= 100
                then 'Y'
           else 'N'
      end as flag
    from stadium) x
where x.flag = 'Y';

-- MySQL: Solution 2 (Generic method)
with
	t1 as
		(select *,	id - row_number() over (order by id) as diff
		from stadium s
		where s.people >= 100),
	t2 as
		(select *,
		count(*) over (partition by diff order by diff) as cnt
		from t1)
select id, visit_date, people
from t2
where t2.cnt >= 3;



/*** --- Next Question --- ***/



620. Not Boring Movies -- Easy
-- MySQL
select id, movie, description, rating
from cinema c
where c.description != 'boring'
and (c.id % 2) != 0
order by rating desc;



/*** --- Next Question --- ***/



626. Exchange Seats -- Medium
-- MySQL
select id,
case when (id % 2) = 0 then lag(student) over (order by id)
	 else lead(student,1,student) over (order by id) end student
from seat;



/*** --- Next Question --- ***/



627. Swap Salary -- Easy
-- MySQL
update salary
set sex = case when sex = 'm' then 'f' else 'm' end ;



/*** --- Next Question --- ***/



1179. Reformat Department Table -- Easy
-- Oracle: Solution 1 using Pivot table.
select * from (
   select id, month, revenue
   from department t
)
pivot
(
   sum(revenue)
   for month in ('Jan' as Jan_Revenue, 'Feb' as Feb_Revenue, 'Mar' as Mar_Revenue, 'Apr' as Apr_Revenue
                ,'May' as May_Revenue, 'Jun' as Jun_Revenue, 'Jul' as Jul_Revenue, 'Aug' as Aug_Revenue
                ,'Sep' as Sep_Revenue, 'Oct' as Oct_Revenue, 'Nov' as Nov_Revenue, 'Dec' as Dec_Revenue)
);

-- MySQL: SOlution 2 using CASE statement .
select id,
sum(case when month = 'Jan' then revenue else null end) as Jan_Revenue,
sum(case when month = 'Feb' then revenue else null end) as Feb_Revenue,
sum(case when month = 'Mar' then revenue else null end) as Mar_Revenue,
sum(case when month = 'Apr' then revenue else null end) as Apr_Revenue,
sum(case when month = 'May' then revenue else null end) as May_Revenue,
sum(case when month = 'Jun' then revenue else null end) as Jun_Revenue,
sum(case when month = 'Jul' then revenue else null end) as Jul_Revenue,
sum(case when month = 'Aug' then revenue else null end) as Aug_Revenue,
sum(case when month = 'Sep' then revenue else null end) as Sep_Revenue,
sum(case when month = 'Oct' then revenue else null end) as Oct_Revenue,
sum(case when month = 'Nov' then revenue else null end) as Nov_Revenue,
sum(case when month = 'Dec' then revenue else null end) as Dec_Revenue
from department
group by id;

-- Solution for Microsoft SQL Server using Pivot table.
select id
,[Jan] as Jan_Revenue
,[Feb] as Feb_Revenue
,[Mar] as Mar_Revenue
,[Apr] as Apr_Revenue
,[May] as May_Revenue
,[Jun] as Jun_Revenue
,[Jul] as Jul_Revenue
,[Aug] as Aug_Revenue
,[Sep] as Sep_Revenue
,[Oct] as Oct_Revenue
,[Nov] as Nov_Revenue
,[Dec] as Dec_Revenue
from
   (  select id, month, revenue
      from department t
   ) as t1
   PIVOT
   (  sum(revenue)
      for [month] in ([Jan], [Feb], [Mar], [Apr]
                     ,[May], [Jun], [Jul], [Aug]
                     ,[Sep], [Oct], [Nov], [Dec])
   )  as t2;


select a.* from (select row_number() over() as 'serial_number', a.* from Activity a) a 
join (select row_number() over() as 'serial_number'  , a.* from Activity a) b 
on a.event_date = date_sub(b.event_date, interval 1 day) 
and a.serial_number!=b.serial_number;


select count(1) as desiredCount from Activity a join Activity b 
on a.event_date = date_sub(b.event_date, interval 1 day) 
and a.player_id = b.player_id;