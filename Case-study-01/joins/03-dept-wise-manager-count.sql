SELECT 
    d.dept_name,
    COALESCE(x.manager_count, 0) AS manager_count
FROM departments d
LEFT JOIN (
    SELECT 
        e.dept_id,
        COUNT(DISTINCT e.emp_id) AS manager_count
    FROM employees e
    INNER JOIN employees e1 ON e.emp_id = e1.manager_id
    GROUP BY e.dept_id
) x ON d.dept_id = x.dept_id;


or 


SELECT 
    d.dept_name,
    COALESCE(x.manager_count, 0) AS manager_count
FROM departments d
LEFT JOIN (
    SELECT 
        e.dept_id,
        COUNT(*) AS manager_count
    FROM employees e
    WHERE EXISTS (
        SELECT 1 
        FROM employees sub 
        WHERE sub.manager_id = e.emp_id
    )
    GROUP BY e.dept_id
) x ON d.dept_id = x.dept_id
ORDER BY d.dept_name;