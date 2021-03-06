## **postgresql query fOR employee table.**

**1) Employee_Name AND Manager_Name**
```
SELECT e.name AS "Employee name",m.name AS "Manager name" 
FROM employee e ,employee m
WHERE m.emp_id=e.mgr_id;
```

**2, Employee name, emp doj, manager name, manger doj
```
SELECT e.name AS "Employee name",
e.joining_date AS "Employee joining date",
m.name AS "Manager name",
m.joining_date  AS "Manager joining date" 
FROM employee e ,employee m 
WHERE e.mgr_id=m.emp_id; 
```

**3, Employee name, Emp Dept, Mgr Dept
```
SELECT e.name,d1.name,d2.name 
FROM employee e,employee m,dept d1,dept d2 
WHERE m.emp_id=e.mgr_id 
AND e.dept_id=d1.dept_id 
AND m.dept_id=d2.dept_id;
```

**4, List of employees without a manager
```
SELECT name
FROM employee 
WHERE mgr_id is null;
```

**5, List of terminated manager names
```
SELECT distinct m.name 
FROM employee m, employee e 
WHERE e.mgr_id=m.emp_id 
AND m.termination_date < now()::date;
```

**6, List of department names where we have a terminated employee
```
SELECT distinct  d.name AS "Department name" 
FROM dept d, employee e 
WHERE d.dept_id=e.dept_id 
AND e.termination_date is not null;
```

**7, List of department names where we have a terminated Manager
```
SELECT distinct d.name AS "Department name" 
FROM dept d, employee e 
WHERE d.dept_id=e.dept_id 
AND e.termination_date is not null;
```

**8, List of employees whose manager salary is less then employee salary
```
SELECT e.name 
FROM employee e,employee m 
WHERE m.emp_id=e.mgr_id 
AND m.salary<e.salary;
```

**9, List of employees whose doj is earlier than manager
```
SELECT e.name 
FROM employee e,employee m 
WHERE m.emp_id=e.mgr_id 
AND e.joining_date<m.joining_date;
```

**10, List of employees whose name has a vowel
```
SELECT DISTINCT name 
FROM employee 
WHERE name LIKE '%A%' 
OR name LIKE '%E%'
OR name LIKE '%I%'
OR name LIKE '%O%' 
OR name LIKE '%U%' 
OR name LIKE '%a%' 
OR name LIKE '%e%' 
OR name LIKE '%i%' 
OR name LIKE '%o%' 
OR name LIKE '%u%';
```

**11, List of employees whose manager name has a vowel AND employee salary is less than 20000 
```
SELECT distinct e.name 
FROM employee e,employee m 
WHERE (m.name LIKE '%A%' 
OR m.name LIKE '%E%' 
OR m.name LIKE '%I%' 
OR m.name LIKE '%O%' 
OR m.name LIKE '%U%' 
OR m.name LIKE '%a%' 
OR m.name LIKE '%e%' 
OR m.name LIKE '%i%' 
OR m.name LIKE '%o%' 
OR m.name LIKE '%u%') 
AND e.salary < 20000 
AND e.mgr_id=m.emp_id;
```

**12, List of employees who has joined in Jan/Feb AND Nov
```
SELECT name 
FROM employee 
WHERE EXTRACT(Month FROM joining_date)='01'
OR EXTRACT(Month FROM joining_date)='02' 
OR EXTRACT(Month FROM joining_date)='11';
```