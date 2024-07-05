-- Assignment 3 – Different Types Of Joins
	use sql_assignments

-- 1) Create an ‘Orders’ table which comprises of these columns: ‘order_id’, ‘order_date’, ‘amount’, ‘customer_id’
	--A)
		create table orders
		(
			order_id int primary key,
            order_date date,
			amount int,
			customer_id int
		)

-- 2) Insert 5 new records
	--A)
		insert into orders
		values
		(10,'2023-10-09',5000,1),
		(20,'2001-07-10',6000,2),
		(30,'1990-11-19',3000,3),
		(40,'2022-05-05',4000,8),
		(50,'2001-03-11',6000,9)

		select * from orders

-- 3) Make an inner join on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column
	--A)
		select * from customer c
		inner join orders o on c.customer_id = o.customer_id

-- 4) Make left and right joins on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column
	--A)
		select * from customer c
		left join orders o on c.customer_id = o.customer_id

		select * from customer c
		right join orders o on c.customer_id = o.customer_id

-- 5) Make a full outer join on ‘Customer’ and ‘Orders’ table on the ‘customer_id’ column
	--A)
		select * from customer c
		full outer join orders o on c.customer_id = o.customer_id

-- 6) Update the ‘Orders’ table and set the amount to be 100 where ‘customer_id’ is 3
	--A)
		update orders
		set amount = 100
		where customer_id = 3