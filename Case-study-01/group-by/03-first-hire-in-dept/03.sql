SELECT 
    d.dept_name,
    e.emp_name,
    e.salary
FROM employees e
INNER JOIN (
    SELECT 
        dept_id, 
        MIN(emp_id) AS first_hire_id
    FROM employees
    GROUP BY dept_id
) min_emp ON e.dept_id = min_emp.dept_id 
         AND e.emp_id = min_emp.first_hire_id
INNER JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name;