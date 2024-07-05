-- SQL Case Study 2
	create database sql_assignments2
	
	use sql_assignments2

-- Create all the tables provided in the assignment file
	CREATE TABLE LOCATION 
	(
		Location_ID INT PRIMARY KEY,
		City VARCHAR(50)
	)
	
	INSERT INTO LOCATION (Location_ID, City)
	VALUES (122, 'New York'),
			(123, 'Dallas'),
			(124, 'Chicago'),
			(167, 'Boston');


	CREATE TABLE DEPARTMENT 
	(
		Department_Id INT PRIMARY KEY,
		Name VARCHAR(50),
		Location_Id INT,
		FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
	)


	INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
	VALUES (10, 'Accounting', 122),
			(20, 'Sales', 124),
			(30, 'Research', 123),
			(40, 'Operations', 167);

	CREATE TABLE JOB 
	(
		Job_ID INT PRIMARY KEY,
		Designation VARCHAR(50)
	)

	INSERT  INTO JOB 
	VALUES (667, 'CLERK'),
			(668,'STAFF'),
			(669,'ANALYST'),
			(670,'SALES_PERSON'),
			(671,'MANAGER'),
			(672, 'PRESIDENT')


	CREATE TABLE EMPLOYEE 
	(
		EMPLOYEE_ID INT,
		LAST_NAME VARCHAR(20),
		FIRST_NAME VARCHAR(20),
		MIDDLE_NAME CHAR(1),
		JOB_ID INT FOREIGN KEY
		REFERENCES JOB(JOB_ID),
		MANAGER_ID INT,
		HIRE_DATE DATE,
		SALARY INT,
		COMM INT,
		DEPARTMENT_ID  INT FOREIGN KEY
		REFERENCES DEPARTMENT(DEPARTMENT_ID)
	)

	INSERT INTO EMPLOYEE 
	VALUES (7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
			(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
			(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
			(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
			(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
			(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)
	-- This data is slightly different than the one given in the PDF. 
	-- But since this is also the part of the file given, I'll consider this the updated data

	select * from LOCATION
	select * from DEPARTMENT
	select * from JOB
	select * from EMPLOYEE

-- Simple Queries

-- 1) List all the employee details
	--A)
		select * from EMPLOYEE

-- 2) List all the department details
	--A)
		select * from DEPARTMENT

-- 3) List all job details
	--A)
		select * from JOB

-- 4) List all the locations
	--A)
		select * from LOCATION

-- 5) List out the First Name, Last Name, Salary, Commission for all Employees
	--A)
		select
			FIRST_NAME,
			LAST_NAME,
			SALARY,
			COMM
		from EMPLOYEE

-- 6) List out the Employee ID, Last Name, Department ID for all employees and alias
--		Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"
	--A)
		select 
			EMPLOYEE_ID "ID of the Employee",
			LAST_NAME "Name of the Employee",
			DEPARTMENT_ID Dep_id
		from EMPLOYEE

-- 7) List out the annual salary of the employees with their names only
	--A)
		select
			FIRST_NAME,
			MIDDLE_NAME,
			LAST_NAME,
			(SALARY*12) 'annual salary'
		from EMPLOYEE


-- Where Condition

-- 1) List the details about "Smith"
	--A)
		select *
		from EMPLOYEE
		where LAST_NAME like 'smith'

-- 2) List out the employees who are working in department 20
	--A)
		select *
		from EMPLOYEE
		where DEPARTMENT_ID = 20

-- 3) List out the employees who are earning salaries between 3000 and 4500
	--A)
		select *
		from EMPLOYEE
		where SALARY between 3000 and 4500

-- 4) List out the employees who are working in department 10 or 20
	--A)
		select *
		from EMPLOYEE
		where DEPARTMENT_ID in (10,20)

-- 5) Find out the employees who are not working in department 10 or 30
	--A)
		select *
		from EMPLOYEE
		where DEPARTMENT_ID not in (10,30)

-- 6) List out the employees whose name starts with 'S'
	--A)
		select *
		from EMPLOYEE
		where LAST_NAME like 's%'

-- 7) List out the employees whose name starts with 'S' and ends with'H'
	--A)
		select *
		from EMPLOYEE
		where LAST_NAME like 's%'
			and LAST_NAME like '%h'

-- 8) List out the employees whose name length is 4 and start with 'S'
	--A)
		select *
		from EMPLOYEE
		where len(LAST_NAME) = 4
			and LAST_NAME like 's%'

-- 9) List out employees who are working in department 10 and draw salaries more than 3500
	--A)
		select *
		from EMPLOYEE
		where DEPARTMENT_ID = 10
			and SALARY > 3500

-- 10) List out the employees who are not receiving commission
	--A)
		select *
		from EMPLOYEE
		where COMM is null


-- Order By Clause

-- 1) List out the Employee ID and Last Name in ascending order based on the Employee ID
	--A)
		select EMPLOYEE_ID, LAST_NAME
		from EMPLOYEE
		order by EMPLOYEE_ID

-- 2) List out the Employee ID and Name in descending order based on salary
	--A)
		select EMPLOYEE_ID, LAST_NAME
		from EMPLOYEE
		order by SALARY desc

-- 3) List out the employee details according to their Last Name in ascending-order
	--A)
		select *
		from EMPLOYEE
		order by LAST_NAME

-- 4) List out the employee details according to their Last Name in ascending order and then Department ID in descending order
	--A)
		select *
		from EMPLOYEE
		order by LAST_NAME, DEPARTMENT_ID desc


-- Group By and Having Clause

-- 1) How many employees are in different departments in the organization
	--A)
		select
			DEPARTMENT_ID,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by DEPARTMENT_ID

-- 2) List out the department wise maximum salary, minimum salary and average salary of the employees
	--A)
		select
			DEPARTMENT_ID,
			max(salary) max_salary,
			min(salary) min_salary,
			avg(salary) avg_salary
		from EMPLOYEE
		group by DEPARTMENT_ID

-- 3) List out the job wise maximum salary, minimum salary and average salary of the employees
	--A)
		select
			JOB_ID,
			max(salary) max_salary,
			min(salary) min_salary,
			avg(salary) avg_salary
		from EMPLOYEE
		group by JOB_ID

-- 4) List out the number of employees who joined each month in ascending order
	--A)
		select
			month(HIRE_DATE) month,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by month(HIRE_DATE)
		order by month(HIRE_DATE)

-- 5) List out the number of employees for each month and year in ascending order based on the year and month
	--A)
		select
			year(HIRE_DATE) year,
			month(HIRE_DATE) month,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by year(HIRE_DATE), month(HIRE_DATE)
		order by year(HIRE_DATE), month(HIRE_DATE)

-- 6) List out the Department ID having at least four employees
	--A)
		select
			DEPARTMENT_ID,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by DEPARTMENT_ID
		having count(EMPLOYEE_ID) >= 4

-- 7) How many employees joined in the month of January
	--A)
		select
			month(HIRE_DATE) month,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by month(HIRE_DATE)
		having month(HIRE_DATE) = 1

-- 8) How many employees joined in the month of January or September
	--A)
		select
			month(HIRE_DATE) month,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by month(HIRE_DATE)
		having month(HIRE_DATE) in (1,9)

-- 9) How many employees joined in 1985
	--A)
		select
			year(HIRE_DATE) year,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by year(HIRE_DATE)
		having year(HIRE_DATE) = 1985

-- 10) How many employees joined each month in 1985
	--A)
		select
			year(HIRE_DATE) year,
			month(HIRE_DATE) month,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by year(HIRE_DATE), month(HIRE_DATE)
		having year(HIRE_DATE) = 1985
		order by month(HIRE_DATE)

-- 11) How many employees joined in March 1985
	--A)
		select
			year(HIRE_DATE) year,
			month(HIRE_DATE) month,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		group by year(HIRE_DATE), month(HIRE_DATE)
		having year(HIRE_DATE) = 1985
			and month(HIRE_DATE) = 3

-- 12) Which is the Department ID having greater than or equal to 3 employees joining in April 1985
	--A)
		select
			DEPARTMENT_ID,
			count(EMPLOYEE_ID) employee_count
		from EMPLOYEE
		where year(HIRE_DATE) = 1985
			and month(HIRE_DATE) = 4
		group by DEPARTMENT_ID
		having count(EMPLOYEE_ID) >= 3


-- Joins

-- 1) List out employees with their department names
	--A)
		select
			distinct e.LAST_NAME,
			d.Name department_name
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id

-- 2) Display employees with their designations
	--A)
		select
			distinct e.LAST_NAME,
			j.Designation
		from EMPLOYEE e
		left join JOB j on e.JOB_ID=j.Job_ID

-- 3) Display the employees with their department names and regional groups
	--A)
		select
			distinct e.LAST_NAME,
			d.Name department_name,
			l.City
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		left join LOCATION l on d.Location_Id=l.Location_ID

-- 4) How many employees are working in different departments? Display with department names
	--A)
		select
			d.Name department,
			count(e.EMPLOYEE_ID) emp_count
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		group by d.Name

-- 5) How many employees are working in the sales department
	--A)
		select
			d.Name department,
			count(e.EMPLOYEE_ID) emp_count
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		where d.Name like 'sales'
		group by d.Name

-- 6) Which is the department having greater than or equal to 5 employees? Display the department names in ascending order
	--A)
		select
			d.Name department,
			count(e.EMPLOYEE_ID) emp_count
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		group by d.Name
		having count(e.LAST_NAME) >= 5
		order by d.Name

-- 7) How many jobs are there in the organization? Display with designations
	--A)
		select
			j.Designation,
			count(e.EMPLOYEE_ID) emp_count
		from EMPLOYEE e
		left join JOB j on e.JOB_ID=j.Job_ID
		group by j.Designation

-- 8) How many employees are working in "New York"
	--A)
		select
			l.City,
			count(e.EMPLOYEE_ID) emp_count
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		left join LOCATION l on d.Location_Id=l.Location_ID
		where l.City like 'New York'
		group by l.City

-- 9) Display the employee details with salary grades. Use conditional statement to create a grade column
	--A)
		select *,
			(case when SALARY between 0 and 999 then 'grade 1'
				when SALARY between 1000 and 1999 then 'grade 2'
				when SALARY between 2000 and 2999 then 'grade 3'
				when SALARY between 3000 and 3999 then 'grade 4'
				else 'grade 4' end) grade
		from EMPLOYEE

-- 10) List out the number of employees grade wise. Use conditional statement to create a grade column
	--A)
		with t as
		(
			select *,
				(case when SALARY between 0 and 999 then 'grade 1'
					when SALARY between 1000 and 1999 then 'grade 2'
					when SALARY between 2000 and 2999 then 'grade 3'
					when SALARY between 3000 and 3999 then 'grade 4'
					else 'grade 4' end) grade
			from EMPLOYEE
		)

		select
			grade,
			count(EMPLOYEE_ID) emp_count
		from t
		group by grade

-- 11) Display the employee salary grades and the number of employees between 2000 to 5000 range of salary
	--A)
		with t as
		(
			select *,
				(case when SALARY between 0 and 999 then 'grade 1'
					when SALARY between 1000 and 1999 then 'grade 2'
					when SALARY between 2000 and 2999 then 'grade 3'
					when SALARY between 3000 and 3999 then 'grade 4'
					else 'grade 4' end) grade
			from EMPLOYEE
		)

		select
			grade,
			count(EMPLOYEE_ID) emp_count
		from t
		where salary between 2000 and 5000
		group by grade

-- 12) Display all employees in sales or operation departments
	--A)
		select
			d.Name department,
			e.LAST_NAME
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		where d.Name in ('sales','operations')
		order by d.Name


-- Set Operators

-- 1) List out the distinct jobs in sales and accounting departments
	--A)
		select
			j.Designation
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		left join JOB j on e.JOB_ID=j.Job_ID
		where d.Name like 'sales'

		union

		select
			j.Designation
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		left join JOB j on e.JOB_ID=j.Job_ID
		where d.Name like 'accounting'

-- 2) List out all the jobs in sales and accounting departments
	--A)
		select
			j.Designation
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		left join JOB j on e.JOB_ID=j.Job_ID
		where d.Name like 'sales'

		union all

		select
			j.Designation
		from EMPLOYEE e
		left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
		left join JOB j on e.JOB_ID=j.Job_ID
		where d.Name like 'accounting'

-- 3) List out the common jobs in research and accounting departments in ascending order
	--A)
		with t as
		(
			select
				j.Designation
			from EMPLOYEE e
			left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
			left join JOB j on e.JOB_ID=j.Job_ID
			where d.Name like 'research'

			union

			select
				j.Designation
			from EMPLOYEE e
			left join DEPARTMENT d on e.DEPARTMENT_ID=d.Department_Id
			left join JOB j on e.JOB_ID=j.Job_ID
			where d.Name like 'accounting'
		)

		select *
		from t
		order by Designation


-- Subqueries

-- 1) Display the employees list who got the maximum salary
	--A)
		select
			LAST_NAME,
			SALARY
		from EMPLOYEE
		where SALARY = (select max(SALARY) from EMPLOYEE)

-- 2) Display the employees who are working in the sales department
	--A)
		select LAST_NAME
		from EMPLOYEE
		where DEPARTMENT_ID = (select Department_Id from DEPARTMENT
								where Name like 'sales')

-- 3) Display the employees who are working as 'Clerk'
	--A)
		select LAST_NAME
		from EMPLOYEE
		where JOB_ID = (select Job_ID from JOB
						where Designation like 'clerk')

-- 4) Display the list of employees who are living in "New York"
	--A)
		select LAST_NAME
		from EMPLOYEE
		where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT d
								left join LOCATION l on d.Location_Id=l.Location_ID
								where l.City like 'New York')

-- 5) Find out the number of employees working in the sales department
	--A)
		select count(EMPLOYEE_ID) emp_count
		from EMPLOYEE
		where DEPARTMENT_ID = (select Department_Id from DEPARTMENT
								where Name like 'sales')

-- 6) Update the salaries of employees who are working as clerks on the basis of 10%
	--A)
		begin transaction sal_update1
			update EMPLOYEE
			set SALARY = (SALARY*1.1)
			where JOB_ID = (select JOB_ID from JOB
							where Designation like 'clerk')

		select * from EMPLOYEE

		rollback transaction sal_update1

-- 7) Delete the employees who are working in the accounting department
	--A)
		begin transaction emp_update1
			delete from EMPLOYEE
			where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
									where name like 'accounting')

		select * from EMPLOYEE

		rollback transaction emp_update1
			
-- 8) Display the second highest salary drawing employee details
	--A)
		with t as
		(
			select *,
				dense_rank()over(order by salary desc) rank
			from EMPLOYEE
		)

		select * from t where rank = 2

-- 9) Display the nth highest salary drawing employee details
	--A)
		with t as
		(
			select *,
				dense_rank()over(order by salary desc) rank
			from EMPLOYEE
		)

		select * from t where rank = n

-- 10) List out the employees who earn more than every employee in department 30
	--A)
		select LAST_NAME
		from EMPLOYEE
		where SALARY > (select max(salary) from EMPLOYEE
						where DEPARTMENT_ID = 30)

-- 11) List out the employees who earn more than the lowest salary in department.Find out whose department has no employees
	--A)
		with t as
		(
			select *,
				dense_rank() over(partition by department_id order by salary) rank
			from EMPLOYEE
		)

		select last_name emp_earning_more_than_lowest from t where rank > 1

		select Name department_with_no_employee from DEPARTMENT
		where Department_Id not in (select distinct DEPARTMENT_ID from EMPLOYEE)

-- 12) Find out which department has no employees
	--A)
		select Name department_with_no_employee from DEPARTMENT
		where Department_Id not in (select distinct DEPARTMENT_ID from EMPLOYEE)

-- 13) Find out the employees who earn greater than the average salary for their department
	--A)
		with t as
		(
			select *,
				AVG(salary) over (partition by department_id) avg_salary
			from EMPLOYEE
		)

		select
			LAST_NAME,
			DEPARTMENT_ID,
			SALARY,
			avg_salary
		from t
		where SALARY > avg_salary
