-- Assignment 2 – Different Data Types In SQL
	use sql_assignments

-- 1) Create a customer table which comprises of these columns: ‘customer_id’, ‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’
	--A)
		create table customer
		(
			customer_id int primary key, 
            first_name varchar(50), 
			last_name varchar(50), 
			email varchar(100),
			address varchar(100), 
			city varchar(25), 
			state varchar(25), 
			zip int
		)

-- 2) Insert 5 new records into the table
	--A)
		insert into customer		values		(1,'MIKE','JOHN','MJOHN@GMAIL.COM','123 STREET','JACKSONVILLE','FLORIDA',32256),		(2,'STEVE','DAVID','SDAVID@GMAIL.COM','456 COURT ROAD','NEWYORK','NEWYORK',72390),		(3,'DEEPAK','MATHUR','DEEPAKMATHUR@GMAIL.COM','7840 CLARA DRIVE','PLANO','TEXAS',75024),		(4,'MANISH','SHARMA','MANISHS@GMAIL.COM','12323 MAPPLE ROARD','CHICAGO','ILLINOIS',1332),		(5,'AMIT','GUPTA','AGUPTA@GMAIL.COM','43242 JERSEY STREET','JERSEY CITY','NEW JERSEY',32423)

		select * from customer

-- 3) Select only the ‘first_name’ and ‘last_name’ columns from the customer table
	--A)
		select first_name, last_name
		from customer

-- 4) Select those records where ‘first_name’ starts with “G” and city is ‘SanJose’
	--A)
		select *
		from customer
		where first_name like 'G%'
		and city like 'SanJose'
	-- This gets us zero results as there is no such record that matches the requirements
	-- So, as suggested in class we'll change the question a bit
	-- Select those records where ‘first_name’ starts with “M” and city is 'Chicago'
		select *
		from customer
		where first_name like 'M%'
		and city like 'Chicago'

-- 5) Select those records where Email has only ‘gmail’
	--A)
		select *
		from customer
		where email like '%gmail%'

-- 6) Select those records where the ‘last_name’ doesn't end with “A”
	--A)
		select *
		from customer
		where last_name not like '%A'