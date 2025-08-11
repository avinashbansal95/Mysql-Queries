select * from  employees where emp_id not in(select distinct manager_id from employees where manager_id is not null);

SELECT e1.*
FROM employees e1
LEFT JOIN employees e2 ON e1.emp_id = e2.manager_id
WHERE e2.emp_id IS NULL;