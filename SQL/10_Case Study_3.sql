-- SQL Case Study 3
	use sql_assignments2

-- Import all the tables provided in the assignment file
	select * from continent
	select * from customers
	select * from transactions

-- 1) Display the count of customers in each region who have done the transaction in the year 2020
	--A)
		select
			co.region_name,
			count(t.customer_id) customer_count
		from Transactions t
		left join Customers c on t.customer_id=c.customer_id
		left join Continent co on c.region_id=co.region_id
		where year(t.txn_date) = 2020
		group by co.region_name

-- 2) Display the maximum and minimum transaction amount of each transaction type
	--A)
		select
			txn_type,
			max(txn_amount) max_txn,
			min(txn_amount) min_txn
		from Transactions
		group by txn_type

-- 3) Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000
	--A)
		select
			t.customer_id,
			co.region_name,
			t.txn_amount
		from Transactions t
		left join Customers c on t.customer_id=c.customer_id
		left join Continent co on c.region_id=co.region_id
		where t.txn_type like 'deposit'
			and txn_amount > 2000

-- 4) Find duplicate records in the Customer table
	--A)
		select
			customer_id,
			count(*) duplicate_count
		from Customers
		group by customer_id
		having count(*)>1
		order by customer_id

-- 5) Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit
	--A)
		select
			t.customer_id,
			co.region_name,
			t.txn_type,
			t.txn_amount
		from Transactions t
		left join Customers c on t.customer_id=c.customer_id
		left join Continent co on c.region_id=co.region_id
		where t.txn_amount = (select min(txn_amount) from Transactions
								where txn_type like 'deposit')

-- 6) Create a stored procedure to display details of customers in the Transaction table where the transaction date is greater than Jun 2020
	--A)
		create procedure txn_date_details as
			select *
			from Transactions
			where txn_date >= '2020-07-01'
		go

		exec txn_date_details

-- 7) Create a stored procedure to insert a record in the Continent table
	--A)
		create procedure inst_continent
		@region_id tinyint, @region_name nvarchar(50) as
			insert into Continent values
			(@region_id,@region_name)
		go

		begin transaction inst_record_cont1
			exec inst_continent 6,'Antarctica'

		select * from Continent

		rollback transaction inst_record_cont1

-- 8) Create a stored procedure to display the details of transactions that happened on a specific day
	--A)
		create procedure txn_sdate_details 
		@date date as
			select *
			from Transactions
			where txn_date = @date
		go
		
		exec txn_sdate_details '2020-02-02'

-- 9) Create a user defined function to add 10% of the transaction amount in a table
	--A)
		create function add10per_txn_amount(@txnamount int)
		returns int as
		begin
		return (@txnamount * 1.1)	
		end

		select *, dbo.add10per_txn_amount(txn_amount) "110% txn_amount" from Transactions

-- 10) Create a user defined function to find the total transaction amount for a given transaction type
	--A)
		create function total_txn_amount_type(@txntype varchar(50))
		returns table as return
			select sum(txn_amount) total_txn_amount from Transactions 
			where txn_type like @txntype

		select * from dbo.total_txn_amount_type('deposit')

-- 11) Create a table value function which comprises the columns customer_id, region_id ,txn_date , txn_type , txn_amount which will retrieve data from the above table
	--A)
		select
			t.customer_id,
			c.region_id,
			t.txn_date,
			t.txn_type,
			t.txn_amount
		into value_function
		from Transactions t
		left join Customers c on t.customer_id=c.customer_id

		select * from value_function

-- 12) Create a TRY...CATCH block to print a region id and region name in a single column
	--A)
		begin try
			select CONCAT(region_id,' ', region_name) con_id_name
			from Continent
		end try
		begin catch
			select 'Error Popped Up'
		end catch

-- 13) Create a TRY...CATCH block to insert a value in the Continent table
	--A)
		begin transaction insert_try1
		begin try
			insert into Continent values
			(6,'Antarctica')
		end try
		begin catch
			select 'Error Popped Up'
		end catch

		select * from Continent

		rollback transaction insert_try1

-- 14) Create a trigger to prevent deleting a table in a database
	--A)
		create trigger table_drop_prevention
		on database
		for drop_table
		as
		begin
			raiserror('Cannot delete this table',16,1)
			rollback
		end

		begin transaction test_drop
			drop table Continent

		select * from Continent


-- 15) Create a trigger to audit the data in a table
	--A)
		create table customer_audit(id int identity(1,1), AuditData varchar(50))

		select * from customer_audit

		CREATE TRIGGER trg_audit
		ON customers
		FOR INSERT
		as begin
			Declare @id int
			select @id = customer_id from inserted
			insert into customer_audit values
			('New customer with ID = ' + cast(@id as varchar(5)) +' is added')
		end
		
		begin transaction test_insert1
		insert into Customers values(2003,2,'2001-11-14','2001-11-14')

		select * from customer_audit

		select * from Customers		where customer_id = 2003				rollback transaction test_insert1

-- 16) Create a trigger to prevent login of the same user id in multiple pages
	--A)

		select * from sys.dm_exec_sessions 
		order by is_user_process desc

		select 
			is_user_process, 
			original_login_name 
		from sys.dm_exec_sessions
		order by is_user_process desc

		create trigger trg_logon
		on all server
		for logon
		as begin
		declare @LoginName varchar(50)
		set @LoginName = ORIGINAL_LOGIN()
		if(select count(*) 
			from sys.dm_exec_sessions 
			where is_user_process = 1 
				and original_login_name = @LoginName) > 3
			begin
			print 'Fourth connection attempt by ' +@loginName + ' Blocked'
			rollback
			end
		end

		drop trigger trg_logon on all server
-- 17) Display top n customers on the basis of transaction type
	--A)
		with t as
		(
			select *,
				dense_rank()over(partition by txn_type order by txn_amount desc) rank
			from Transactions
		)

		select * from t where rank <= n

-- 18) Create a pivot table to display the total purchase, withdrawal and deposit for all the customers
	--A)
		select
			customer_id,
			purchase,
			withdrawal,
			deposit
		from Transactions
		pivot
		(
			sum(txn_amount)
			for
			txn_type in (deposit,withdrawal,purchase)
		) as PivotTable
