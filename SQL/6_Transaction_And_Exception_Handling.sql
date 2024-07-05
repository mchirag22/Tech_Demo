-- Assignment 6 – Transaction And Exception Handling In SQL
	use sql_assignments

-- 1) Create a view named ‘customer_san_jose’ which comprises of only those customers who are from San Jose
	--A) Since there are no records with custormers from San Jose, lets change this to a view called ‘customer_newyork’ for the customers from newyork
		create view customer_newyork as
		select *
		from customer
		where city like 'newyork'

		select * from customer_newyork

-- 2) Inside a transaction, update the first name of the customer to Francis where the last name is Jordan:
--		a. Rollback the transaction
--		b. Set the first name of customer to Alex, where the last name is Jordan
	--A) Since there are no records with last name Jordan. So, let's just replace Jordan with John in the question
		begin transaction change_name1
			update customer
			set first_name = 'Francis'
			where last_name like 'john'
		print 'transaction completed'

		select * from customer

		rollback transaction change_name1

		begin transaction change_name2
			update customer
			set first_name = 'Alex'
			where last_name like 'john'
		print 'transaction completed'

		commit transaction change_name2

-- 3) Inside a TRY... CATCH block, divide 100 with 0, print the default error message
	--A)
		begin try
			select 100/0 Result
		end try
		begin catch
			select 'Divide by zero error encountered' Exception
		end catch

-- 4) Create a transaction to insert a new record to Orders table and save it
	--A)
		begin transaction new_orders_with_savepoint1
		insert into orders values
		(60,'2023-08-22',7000,10)
		SAVE TRANSACTION new_orders1

		insert into orders values
		(70,'2023-08-23',500,13)
		SAVE TRANSACTION new_orders2

		commit transaction new_orders_with_savepoint1

		select * from orders

