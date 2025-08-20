SELECT d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    INNER JOIN employees sub ON e.emp_id = sub.manager_id
    WHERE e.dept_id = d.dept_id
);