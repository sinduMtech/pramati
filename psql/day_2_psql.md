## **postgresql query for employee table.**

**1) Manager Name, Count of Employees whose start date is after 2013**
```
(SELECT DISTINCT dept_id +1 as "department id"
FROM dept
WHERE dept_id + 1 
NOT IN 
(SELECT DISTINCT dept_id 
FROM dept)
order by dept_id + 1)
intersect
select dept_id-1 from dept ;

```
**2) Manager Name, Reportee who joined first (Reportee Name - doj), Reportee who draws less sal (Reportee Name - salary)**
```
SELECT m1.name,m1.doj AS "Reportee Name - doj",m2.sal AS "Reportee Name - salary"
FROM
    (SELECT m2.name,CONCAT(m1.name,'-', m1.joining_date) AS doj 
    FROM employee m1,employee m2
    WHERE m2.emp_id=m1.mgr_id 
    AND EXISTS(
    SELECT 1
    FROM employee m1_inr
    WHERE m1_inr.mgr_id=m2.emp_id
    HAVING min(m1_inr.joining_date)=m1.joining_date
    ) 
) m1
INNER JOIN
    (SELECT m2.name,CONCAT(m1.name,'-',m1.salary) AS sal	
    FROM employee m1,employee m2
    WHERE m2.emp_id=m1.mgr_id
    AND EXISTS(
    SELECT 1
    FROM employee m1_inr
    WHERE m1_inr.mgr_id=m2.emp_id
    HAVING min(m1_inr.salary)=m1.salary
    )
)m2
ON m1.name=m2.name;
```