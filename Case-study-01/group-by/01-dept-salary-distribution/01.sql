EngineeringSELECT 
    d.dept_name,
    COALESCE(x.manager_count, 0) AS manager_count,
    y.total_salary,y.avg_salary,y.emp_count,COALESCE(CAST(x.manager_count AS DECIMAL(10,2)) / CAST(y.emp_count AS DECIMAL(10,2)),0) as manager_ratio
FROM departments d
LEFT JOIN (
    SELECT 
        e.dept_id,
        COUNT(DISTINCT e.emp_id) AS manager_count
    FROM employees e
     JOIN employees e1 ON e.emp_id = e1.manager_id
    GROUP BY e.dept_id
) x ON d.dept_id = x.dept_id  left join (select dept_id,sum(salary) as total_salary,AVG(salary) as avg_salary,count(emp_id) as emp_count from employees group by dept_id)
y on d.dept_id = y.dept_id; 