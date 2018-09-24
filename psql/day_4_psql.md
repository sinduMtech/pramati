## **Postgres SQL:**

**1. create a csv file with sample data like below with 10 to 20 records
emp_id |     name      | dept_id | mgr_id | salary | joining_date | termination_date | mgr_name
--------+---------------+---------+--------+--------+--------------+------------------+----------
      1 | Harish        |         |        |  90000 | 1990-12-17   | 2015-12-17       |
```
Table created
```
**2. Load the csv to table using psql command

```
COPY employee(emp_id,name,dept_id,mgr_id,salary,joining_date,termination_date) FROM 'c:/training/table.csv' DELIMITER ',' CSV;
```


**3. While loading the table, if the given mgr_id is not in emp table, insert/update should fail

```
ALTER TABLE employee
ADD CONSTRAINT FK_employee_Code FOREIGN KEY (mgr_id)
REFERENCES employee (emp_id) ;

ALTER TABLE employee
ADD CONSTRAINT FK_dept_code FOREIGN KEY (dept_id)
REFERENCES dept (dept_id) ;
```

**4. While loading the table, if the given dept_id is not in dept table, we should insert a record in dept table first with id and name as dept_id in the csv and then insert the employee table
```
INSERT
    BEFORE
    AFTER
, UPDATE, DELETE
```

**5. create a new employee table (say employee1) with the same structure and constraints of employee table but not data

``` 
CREATE TABLE employee1
AS
 SELECT * FROM employee
 WHERE 1=0;
```

https://www.postgresql.org/docs/9.1/static/sql-createtable.html

**6. add a new column peer_emp_ids array
```
ALTER TABLE employee1 ADD COLUMN peer_emp_ids int[];
```
**7. write an insert statement to populate this table from employee table where peer_emp_ids is the employee ids of its manager excluding the given employee
```
INSERT INTO employee1
SELECT
	*, (
		SELECT
			ARRAY_AGG (emp_id)
		FROM
			employee e_inr
		WHERE
			e_inr.mgr_id = e.mgr_id
	) - ARRAY [ e.emp_id ]
FROM
	employee e
```
**8. Write a SQL to find all the employees for the given employee id where the given employee is part of using peer_emp_ids
```
SELECT
	*
FROM
	employee e
INNER JOIN employee1 e1 ON e.emp_id = ANY (e1.peer_emp_ids)
WHERE
	e1.emp_id = 3
```