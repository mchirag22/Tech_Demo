-- Assignment 5 – Different Types Of Clauses
	use sql_assignments

-- 1) Arrange the ‘Orders’ dataset in decreasing order of amount
	--A)
		select *
		from orders
		order by amount desc

-- 2) Create a table with the name ‘Employee_details1’ consisting of these columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. Create another table with
--		the name ‘Employee_details2’ consisting of the same columns as the first table
	--A)
		create table Employee_details1
		(
			Emp_id int primary key,
			Emp_name varchar(30),
			Emp_salary float
		)

		create table Employee_details2
		(
			Emp_id int primary key,
			Emp_name varchar(30),
			Emp_salary float
		)

		insert into Employee_details1
		values
		(11001,'Rahul',30000),
		(11007,'Dinesh',33000),
		(11009,'Monica',40000),
		(11016,'Ankit',34000),
		(11022,'Mahesh',27000)

		insert into Employee_details2
		values
		(11001,'Rahul',30000),
		(11007,'Dinesh',33000),
		(11002,'Soham',32000),
		(11003,'Guru',36000),
		(11008,'Mohit',47000),
		(11013,'Ramya',35000),
		(11019,'Devi',29000)

		select * from Employee_details1
		select * from Employee_details2



-- 3) Apply the UNION operator on these two tables
	--A)
		select * from Employee_details1
		union
		select * from Employee_details2

-- 4) Apply the INTERSECT operator on these two tables
	--A)
		select * from Employee_details1
		intersect
		select * from Employee_details2

-- 5) Apply the EXCEPT operator on these two tables
	--A)
		select * from Employee_details1
		except
		select * from Employee_details2