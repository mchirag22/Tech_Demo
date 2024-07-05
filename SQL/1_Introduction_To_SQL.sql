-- Assignment 1 – Introduction To SQL

-- 1) Install MS SQL Server
	--A) Done
		create database sql_assignments
		use sql_assignments

-- 2) Give the difference between Char and Varchar data type
	--A) These are both character data types, where;
			-- Char;
				-- Used when the length of the string is known
				-- Takes memory for the length specified everytime
				-- Time taken to retrieve data is faster than Varchar
			-- Varchar;
				-- Used when length of the string is unknown
				-- Takes memory only for the length of string used
				-- Takes less memory to store data than Char because it has to fetch the length of each string along with the string as well

-- 3) Explain the types of SQL Commands
	--A) There are mainly 4 types of SQL commands. They are;

			-- Data Query Language
				-- It is used to fetch the data from the database
				-- It uses only one command 'SELECT'
				
			-- Data Definition Language
				-- It is used to create/change/delete the structure of a table
				-- It uses commands like 'CREATE TABLE', 'ALTER TABLE', 'DROP TABLE', and 'TRUNCATE TABLE'
	
			-- Data Manipulation Language
				-- It is used to insert/modify/delete the data inside a table
				-- It uses commands like 'INSERT', 'UPDATE', and 'DELETE'

			-- Data Control Language
				-- It is used to grant/revoke access from any database user
				-- It uses commands like 'GRANT' and 'REVOKE'

-- 4) Explain NVarchar and Nchar
	--A) These are similar to Varchar and Char, with the only difference being that these are used instead when the data includes non-english strings

