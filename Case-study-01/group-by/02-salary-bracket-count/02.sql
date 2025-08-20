SELECT 
    d.dept_name,
    COALESCE(SUM(CASE WHEN e.salary < 55000 THEN 1 ELSE 0 END), 0) AS low_count,
    COALESCE(SUM(CASE WHEN e.salary >= 55000 AND e.salary <= 65000 THEN 1 ELSE 0 END), 0) AS medium_count,
    COALESCE(SUM(CASE WHEN e.salary > 65000 THEN 1 ELSE 0 END), 0) AS high_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;