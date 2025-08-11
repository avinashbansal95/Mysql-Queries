SELECT 
    a.emp_name,
    a.salary,
    x.dept_name,
    x.average AS dept_avg_salary
FROM employees a
INNER JOIN (
    SELECT 
        e.dept_id, 
        d.dept_name, 
        AVG(e.salary) AS average
    FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id
    GROUP BY e.dept_id, d.dept_name
) x ON a.dept_id = x.dept_id
WHERE a.salary > x.average;
