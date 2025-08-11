For each department, count how many employees are managers (i.e., appear as manager_id for someone).
Include departments with zero managers.
Show: dept_name, manager_count. 


# Department-Wise Manager Count (Including Departments with Zero Managers)

## Definition
This query retrieves the number of **managers** in each department.  
A **manager** is defined as an employee whose `emp_id` appears as a `manager_id` for at least one other employee.  
The result includes **all departments**, even if they have **zero managers**.

---

## Query
```sql
SELECT 
    d.dept_name,
    COALESCE(x.manager_count, 0) AS manager_count
FROM departments d
LEFT JOIN (
    SELECT 
        e.dept_id,
        COUNT(DISTINCT e.emp_id) AS manager_count
    FROM employees e
    INNER JOIN employees e1 
        ON e.emp_id = e1.manager_id
    GROUP BY e.dept_id
) x ON d.dept_id = x.dept_id;
```

## Step-by-Step Explanation

### 1. Inner Join to Find Managers
```sql
INNER JOIN employees e1 ON e.emp_id = e1.manager_id
```
* Matches each employee (`e`) with other employees (`e1`) who report to them.
* If an employee has one or more matches here, they are a manager.

### 2. Counting Managers Per Department
```sql
COUNT(DISTINCT e.emp_id) AS manager_count
```
* Uses `DISTINCT` to ensure a manager is only counted once, even if they manage multiple employees.
* Groups by `e.dept_id` so the count is department-specific.

### 3. Including All Departments
```sql
LEFT JOIN (...) x ON d.dept_id = x.dept_id
```
* `departments d` is the left table, ensuring every department appears in the result.
* Departments with no managers will have `NULL` for `manager_count`.

### 4. Handling Null Counts
```sql
COALESCE(x.manager_count, 0)
```
* Replaces `NULL` with `0` for departments without any managers.

## Example Output

| dept_name | manager_count |
|-----------|---------------|
| Engineering | 3 |
| Sales | 1 |
| Marketing | 0 |
| HR | 0 |
| Finance | 0 |

## Key Points

* **Self-join** identifies managerial relationships.
* **DISTINCT** prevents double-counting managers who oversee multiple employees.
* **LEFT JOIN + COALESCE** ensures all departments are represented with an accurate count.
* Useful for organizational analytics and workforce planning.

## Possible Variations

* Add `ORDER BY manager_count DESC` to see departments with most managers first.
* Filter to show only departments with more than 1 manager:
```sql
WHERE COALESCE(x.manager_count, 0) > 1
```
* Include manager names by joining with employees table again.
