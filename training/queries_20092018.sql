1) SQL to find the missing ids from dept

(SELECT DISTINCT dept_id +1 as "department id"
FROM dept
WHERE dept_id + 1 
NOT IN 
(SELECT DISTINCT dept_id 
FROM dept)
order by dept_id + 1)
intersect
select dept_id-1
from dept ;




2) Manager Name, Reportee who joined first (Reportee Name - doj), Reportee who draws less sal (Reportee Name - salary)

SELECT DISTINCT m1.Manager_name,m1.jd,m2.sd
FROM
	(SELECT	m2.name AS Manager_name,
	FIRST_VALUE(CONCAT(m1.name,'-',m1.joining_date)) OVER(
	PARTITION BY m1.mgr_id
	ORDER BY m1.joining_date) AS jd
	FROM employee m1, employee m2
	WHERE m2.emp_id=m1.mgr_id
	)m1 
INNER JOIN
	(SELECT m2.name AS Manager_name,
	FIRST_VALUE(CONCAT(m1.name,'-',m1.salary)) OVER ( 
	PARTITION BY m1.mgr_id 
	ORDER BY m1.salary) AS sd 
	FROM employee m1, employee m2 
	WHERE m2.emp_id=m1.mgr_id
	)m2
ON m1.Manager_name=m2.Manager_name;

3)salary_history
id,name,start_date,end_date,salary
1,Aneesh,2010,2011,1000
1,Aneesh,2011,2012,1100--1,Aneesh,2011,2014,1100
1,Aneesh,2014,2015,1200
1,Aneesh,2015,null,1200

Find the list of employee records where salary data is missing
With the above example, we dont have salary information from 2012 to 2014

Assume, if above data is as commented, then there is no missing as there is no gap

select concat(sd.START_DATE,'-',ed.END_DATE) Missing_Date from   

(SELECT START_DATE from GENERATE_SERIES(
                       (SELECT MIN(start_date) FROM salary_history),
                       (SELECT MAX(start_date) FROM salary_history)
                      ) AS START_DATE  
                   EXCEPT (SELECT start_date FROM salary_history)) sd

INNER JOIN

(SELECT END_DATE  from GENERATE_SERIES(
                       (SELECT MIN(end_date) FROM salary_history),
                       (SELECT MAX(end_date) FROM salary_history)
                      ) AS END_DATE 
                   EXCEPT (SELECT end_date FROM salary_history)) ed


on ed.END_DATE-sd.START_DATE > 1 ;
