-- Assignment 4 – Different Types Of Fuctions
	use sql_assignments

-- 1) Use the inbuilt functions and find the minimum, maximum and average amount from the orders table
	--A)
		select
			min(amount) min_amount,
			max(amount) max_amount,
			avg(amount) avg_amount
		from orders

-- 2) Create a user-defined function which will multiply the given number with 10
	--A) 
		create function multi_with_10(@number float)
		returns float as
		begin
			return(@number*10)
		end

		select dbo.multi_with_10(5.2) as result

-- 3) Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value
	--A)
		select 
		(case
			when 100<200 then 'Number less than 200'
			when 100>200 then 'Number greater than 200'
			when 100=200 then 'Number equal to 200'
		end) result

-- 4) Using a case statement, find the status of the amount. Set the status of the amount as high amount, low amount or medium amount based upon the condition
	--A)
		select *,
		(case
			when amount<2000 then 'Low amount'
			when amount<5000 then 'Medium amount'
			else 'High amount'
		end) status_of_amount
		from orders

-- 5) Create a user-defined function, to fetch the amount greater than the given input
	--A)
		create function amount_gtrthan_input(@input int)
		returns table as
			return select *
					from orders
					where amount > @input

		select * from dbo.amount_gtrthan_input(4000)

		