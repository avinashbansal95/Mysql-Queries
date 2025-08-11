SELECT 
    e.emp_name AS employee_name,
    m.emp_name AS manager_name,
    gm.emp_name AS gm_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id
LEFT JOIN employees gm ON m.manager_id = gm.emp_id
ORDER BY e.emp_name;