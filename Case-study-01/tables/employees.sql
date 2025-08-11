-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert sample data into employees
INSERT INTO employees (emp_id, emp_name, salary, manager_id, dept_id) VALUES
(101, 'Alice', 70000, NULL, 1),
(102, 'Bob', 60000, 101, 1),
(103, 'Charlie', 65000, 101, 2),
(104, 'David', 55000, 102, 1),
(105, 'Eve', 62000, 101, 2),
(106, 'Frank', 50000, 103, 3),
(107, 'Grace', 58000, 101, 4),
(108, 'Henry', 72000, 101, 1),
(109, 'Ivy', 54000, 103, 3),
(110, 'Jack', 61000, 102, 2),
(111, 'Kate', 53000, NULL, 5),
(112, 'Leo', 67000, 108, 1);