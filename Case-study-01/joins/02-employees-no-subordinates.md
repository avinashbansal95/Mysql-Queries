# Inner join explanation

# SQL LEFT JOIN Explanation - Finding Employees with No Subordinates

## Step-by-Step Explanation

### 1. `LEFT JOIN employees e2 ON e1.emp_id = e2.manager_id`

* For each employee `e1`, try to find **someone** (`e2`) who has `e1` as their manager.
* If such a person exists → `e2.emp_id` will have a value.
* If **no one** reports to `e1` → `e2.emp_id` will be `NULL`.

### 2. `WHERE e2.emp_id IS NULL`

* This filters only those `e1` employees **who have no subordinates**.
* Because if `e2.emp_id IS NULL`, it means **no match was found** in the join → no one reports to this employee.

## 🧪 Example

### Take **David (emp_id = 104)**:
* Is there any `e2` such that `e2.manager_id = 104`? → **No**
* So the `LEFT JOIN` returns a row with `e2.emp_id = NULL`
* `WHERE e2.emp_id IS NULL` → **TRUE** → David is included

### Take **Alice (emp_id = 101)**:
* Multiple `e2` rows where `manager_id = 101` → Bob, Charlie, etc.
* So `e2.emp_id` has values (102, 103, ...) → **not NULL**
* `WHERE e2.emp_id IS NULL` → **FALSE** → Alice is excluded

**Perfect!**

## ✅ Why `e2.emp_id IS NULL` and not `e2.manager_id IS NULL`?

Because:

* `e2.manager_id IS NULL` means "this employee has no manager" — that's about **the subordinate**, not about `e1`.
* We care about whether a **match occurred**, so we check if the joined **primary key** (`e2.emp_id`) is `NULL` — which indicates **no match**.