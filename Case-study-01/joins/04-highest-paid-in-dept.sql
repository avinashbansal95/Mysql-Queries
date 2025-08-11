SELECT 
    e.emp_name,
    e.salary,
    d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN (
    SELECT 
        dept_id, 
        MAX(salary) AS max_salary
    FROM employees
    GROUP BY dept_id
) max_sal ON e.dept_id = max_sal.dept_id AND e.salary = max_sal.max_salary;