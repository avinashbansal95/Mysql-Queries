# Employees Earning More Than Their Department Average

## Definition
This query retrieves employees whose salary is greater than the **average salary** of their department.  
It’s useful for identifying **top performers or highly paid employees** compared to their peers in the same department.

---

# SQL Query: Employees Above Department Average Salary

## Your Query

```sql
SELECT a.emp_name, a.salary, x.dept_name, x.average AS dept_avg_salary 
FROM employees a 
INNER JOIN ( 
    SELECT e.dept_id, d.dept_name, AVG(e.salary) AS average 
    FROM employees e 
    INNER JOIN departments d ON e.dept_id = d.dept_id 
    GROUP BY e.dept_id, d.dept_name 
) x ON a.dept_id = x.dept_id 
WHERE a.salary > x.average;
```

## Step-by-Step Explanation

### Step 1: Identify the goal
We want employees whose salary is **greater** than their department's average salary.

### Step 2: Calculate average salary per department
We use a subquery to:
1. Join `employees` with `departments` so we can get `dept_name` for each `dept_id`.
2. Group by each department.
3. Apply `AVG(salary)` to get the average salary for each department.

**Subquery:**
```sql
SELECT e.dept_id, d.dept_name, AVG(e.salary) AS average 
FROM employees e 
INNER JOIN departments d ON e.dept_id = d.dept_id 
GROUP BY e.dept_id, d.dept_name
```

**Example result of subquery:**
| dept_id | dept_name | average |
|---------|-----------|---------|
| 1 | Engineering | 64800.00 |
| 2 | Sales | 62666.67 |
| 3 | Marketing | 52000.00 |
| 4 | HR | 58000.00 |
| 5 | Finance | 53000.00 |

### Step 3: Compare each employee's salary with their department average
We join the main `employees` table (`a`) with the subquery (`x`) on `dept_id`. Then we use:

```sql
WHERE a.salary > x.average
```

to keep only those employees earning more than their department average.

### Step 4: Select final columns
We choose:
* `emp_name`
* `salary`
* `dept_name`
* `dept_avg_salary` (from subquery alias)

## Sample Output (Using Provided Data)

| emp_name | salary | dept_name | dept_avg_salary |
|----------|--------|-----------|-----------------|
| Alice | 70000.00 | Engineering | 64800.00 |
| Henry | 72000.00 | Engineering | 64800.00 |
| Charlie | 65000.00 | Sales | 62666.67 |
| Leo | 67000.00 | Engineering | 64800.00 |

*(Only employees with salary strictly greater than the average appear.)*

## Key Points

* The `AVG()` function in the subquery computes average salary **per department**.
* Grouping by both `dept_id` and `dept_name` avoids ambiguity.
* Filtering with `WHERE a.salary > x.average` ensures we only keep above-average earners.

