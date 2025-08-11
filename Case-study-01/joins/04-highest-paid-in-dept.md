# Finding Highest Salary Employees Per Department

## Step-by-Step Explanation

### 1. Finding the Maximum Salary Per Department

```sql
SELECT dept_id, MAX(salary) AS max_salary 
FROM employees 
GROUP BY dept_id
```

* Groups employees by their department.
* Uses `MAX(salary)` to find the highest salary in each department.
* Returns two columns: `dept_id` and `max_salary`.

### 2. Matching Employees to Their Department's Max Salary

```sql
INNER JOIN (...) max_sal ON e.dept_id = max_sal.dept_id AND e.salary = max_sal.max_salary
```

* Ensures that we only select employees whose salary matches the maximum salary for their department.
* Handles ties — if two employees have the same max salary, both are included.

### 3. Adding Department Names

```sql
INNER JOIN departments d ON e.dept_id = d.dept_id
```

* Joins with the `departments` table to get the department name instead of just the department ID.

### 4. Final Output Columns

```sql
SELECT e.emp_name, e.salary, d.dept_name
```

* Displays the employee's name, their salary, and the department name.

## Example Output

| emp_name | salary | dept_name |
|----------|--------|-----------|
| Henry | 72000.00 | Engineering |
| Charlie | 65000.00 | Sales |
| Frank | 50000.00 | Marketing |
| Grace | 58000.00 | HR |
| Kate | 53000.00 | Finance |

## Key Points

* **No window functions** are used — the solution relies on `GROUP BY` and `MAX()`.
* Works for datasets where multiple employees can tie for the top salary.
* Uses **two joins**:
   1. To match employees to their department's max salary.
   2. To fetch department names.
* Very efficient for small to medium datasets; for large datasets, indexes on `dept_id` and `salary` improve performance.

## Possible Variations

* Add `ORDER BY dept_name` to sort the result alphabetically by department.
* Include additional employee details (e.g., `emp_id`) if needed.
* Filter to show only departments where the max salary is above a certain amount:

```sql
WHERE max_sal.max_salary > 60000
```