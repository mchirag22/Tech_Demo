-- Assignment 7 – SQL Queries
	use sql_assignments

-- Imported all the tables provided in the assignment file
	select * from studies
	select * from software
	select * from programmer

-- 1) Find out the selling cost average for packages developed in Pascal
	--A)
		select
			avg(scost) avg_selling_cost
		from Software
		where DEVELOPIN like 'pascal'
		
-- 2) Display the names and ages of all programmers
	--A)
		select
			PNAME,
			DATEDIFF(year,DOB,GETDATE()) AGE
		from Programmer

-- 3) Display the names of those who have done the DAP Course
	--A)
		select
			PNAME
		from Studies
		where COURSE like 'DAP'

-- 4) Display the names and date of birth of all programmers born in January
	--A)
		select
			PNAME,
			DOB
		from Programmer
		where month(dob) = 1

-- 5) What is the highest number of copies sold by a package
	--A)
		select
			max(sold) highest_copies_sold
		from Software

-- 6) Display lowest course fee
	--A)
		select
			min(course_fee) lowest_course_fee
		from Studies

-- 7) How many programmers have done the PGDCA Course
	--A)
		select
			count(pname)
		from Studies
		where COURSE like 'pgdca'

-- 8) How much revenue has been earned through sales of packages developed in C?
	--A)
		select
			sum(scost*sold) total_revenue
		from Software
		where DEVELOPIN like 'c'

-- 9) Display the details of the software developed by Ramesh
	--A)
		select *
		from Software
		where PNAME like 'ramesh'

-- 10) How many programmers studied at Sabhari
	--A)
		select
			count(pname) programmer_count
		from Studies
		where INSTITUTE like 'sabhari'

-- 11) Display details of packages whose sales crossed the 2000 mark
	--A)
		select *
		from Software
		where (SCOST*SOLD) > 2000

-- 12) Display the details of packages for which development costs have been recovered
	--A)
		select *
		from Software
		where (SCOST*SOLD) >= DCOST

-- 13) What is the cost of the costliest software development in Basic
	--A)
		select
			max(dcost) cost
		from Software
		where DEVELOPIN like 'basic'

-- 14) How many packages have been developed in dBase
	--A)
		select
			count(title) package_count
		from Software
		where DEVELOPIN like 'dbase'

-- 15) How many programmers studied in Pragathi
	--A)
		select
			count(pname) programmer_count
		from Studies
		where INSTITUTE like 'pragathi'

-- 16) How many programmers paid 5000 to 10000 for their course
	--A)
		select
			count(pname) programmer_count
		from Studies
		where COURSE_FEE between 5000 and 10000

-- 17) What is the average course fee
	--A)
		select
			avg(course_fee) avg_fee
		from Studies

-- 18) Display the details of the programmers knowing C
	--A)
		select *
		from Programmer
		where PROF1 like 'c' or PROF2 like 'c'

-- 19) How many programmers know either COBOL or Pascal
	--A)
		select
			count(pname) programmer_count
		from Programmer
		where PROF1 in ('COBOL','Pascal') 
			or PROF2 in ('COBOL','Pascal')

-- 20) How many programmers don’t know Pascal and C
	--A)
		select
			count(pname) programmer_count
		from Programmer
		where PROF1 not in ('C','Pascal') 
			and PROF2 not in ('C','Pascal')

-- 21) How old is the oldest male programmer
	--A)
		select
			max(DATEDIFF(year,DOB,GETDATE())) AGE
		from Programmer
		where GENDER like 'm'

-- 22) What is the average age of female programmers
	--A)
		select
			avg(DATEDIFF(year,DOB,GETDATE())) avg_AGE
		from Programmer
		where GENDER like 'f'

-- 23) Calculate the experience in years for each programmer and display with their names in descending order
	--A)
		select 
			pname,
			DATEDIFF(year,DOJ,GETDATE()) experience
		from Programmer
		order by experience desc

-- 24) Who are the programmers who celebrate their birthdays during the current month
	--A)
		select 
			pname,
			DOB
		from Programmer
		where MONTH(dob) = MONTH(getdate())

-- 25) How many female programmers are there
	--A)
		select
			count(pname)
		from Programmer
		where GENDER like 'f'

-- 26) What are the languages studied by male programmers
	--A)
		select
			PROF1 language
		from Programmer
		where GENDER like 'm'
		union
		select
			PROF2 language
		from Programmer
		where GENDER like 'm'


-- 27) What is the average salary
	--A)
		select
			avg(salary) avg_salary
		from Programmer

-- 28) How many people draw a salary between 2000 to 4000
	--A)
		select
			count(pname) count
		from Programmer
		where SALARY between 2000 and 4000

-- 29) Display the details of those who don’t know Clipper, COBOL or Pascal
	--A)
		select *
		from Programmer
		where PROF1 not in ('Clipper','COBOL','Pascal') 
			and PROF2 not in ('Clipper','COBOL','Pascal')

-- 30) Display the cost of packages developed by each programmer
	--A)
		select
			p.pname,
			sum(s.dcost) total_pack_dev_cost
		from Software s
		right join Programmer p on s.pname=p.pname
		group by p.pname

-- 31) Display the sales value of the packages developed by each programmer
	--A)
		select
			p.pname,
			round(sum(s.scost*s.sold),2) total_pack_dev_revenue
		from Software s
		right join Programmer p on s.pname=p.pname
		group by p.pname

-- 32) Display the number of packages sold by each programmer
	--A)
		select
			p.pname,
			sum(s.SOLD) total_pack_sold
		from Software s
		right join Programmer p on s.pname=p.pname
		group by p.pname

-- 33) Display the sales cost of the packages developed by each programmer language wise
	--A)
		select
			p.pname,
			s.DEVELOPIN,
			round(sum(s.scost*s.sold),2) total_pack_dev_revenue
		from Software s
		right join Programmer p on s.pname=p.pname
		group by s.DEVELOPIN, p.pname

-- 34) Display each language name with the average development cost, average selling cost and average price per copy
	--A)
		select
			DEVELOPIN language,
			round(avg(dcost),2) avg_development_cost,
			round(avg(scost*sold),2) avg_selling_cost,
			round(avg(scost),2) avg_price_per_copy
		from Software
		group by DEVELOPIN

-- 35) Display each programmer’s name and the costliest and cheapest packages developed by him or her
	--A)
		select
			p.pname,
			round(min(s.dcost),2) cheapest_package,
			max(s.dcost) costliest_package
		from Software s
		right join Programmer p on s.pname=p.pname
		group by p.pname

-- 36) Display each institute’s name with the number of courses and the average cost per course
	--A)
		select
			INSTITUTE,
			COUNT(course) course_count,
			avg(course_fee) avg_corst_per_course
		from Studies
		group by INSTITUTE

-- 37) Display each institute’s name with the number of students
	--A)
		select
			INSTITUTE,
			COUNT(pname) student_count
		from Studies
		group by INSTITUTE

-- 38) Display names of male and female programmers along with their gender
	--A)
		select
			pname,
			gender
		from Programmer

-- 39) Display the name of programmers and their packages
	--A)
		select
			pname,
			SALARY
		from Programmer

-- 40) Display the number of packages in each language except C and C++
	--A)
		select
			DEVELOPIN,
			count(developin) count
		from Software
		where DEVELOPIN not in ('c','cpp')
		group by DEVELOPIN

-- 41) Display the number of packages in each language for which development cost is less than 1000
	--A)
		select
			DEVELOPIN,
			count(developin) count
		from Software
		where DCOST < 1000
		group by DEVELOPIN

-- 42) Display the average difference between SCOST and DCOST for each package
	--A)
		select
			TITLE,
			round(avg(scost - dcost),2) avg_cost_diff_scost_dcost
		from Software
		group by TITLE
		

-- 43) Display the total SCOST, DCOST and the amount to be recovered for each programmer whose cost has not yet been recovered
	--A)	
		select
			p.pname,
			sum(s.scost) total_scost,
			sum(s.dcost) total_dcost,
			sum(s.dcost-(s.scost*s.sold)) amt_to_be_recovered
		from Software s
		right join Programmer p on s.pname=p.pname
		group by p.pname
		having sum(s.dcost-(s.scost*s.sold)) > 0

-- 44) Display the highest, lowest and average salaries for those earning more than 2000
	--A)
		select
			max(SALARY) highest_salary,
			min(SALARY) lowest_salary,
			avg(SALARY) average_salary
		from Programmer
		where SALARY > 2000

-- 45) Who is the highest paid C programmer
	--A)
		with t as
		(
			select * from Programmer
			where PROF1 like 'c'
				or PROF2 like 'c'
		)

		select * from t
		where SALARY = (select max(salary) from t)

-- 46) Who is the highest paid female COBOL programmer
	--A)
		with t as
		(
			select * from Programmer
			where GENDER like 'f'
			and PROF1 like 'cobol'
			or PROF2 like 'cobol'
		)

		select * from t
		where SALARY = (select max(salary) from t)

-- 47) Display the names of the highest paid programmers for each language
	--A)
		with rank_lang(pname,language,salary,rank_number) as 
		(
			select *,
				row_number() over (PARTITION BY t.language ORDER BY t.salary DESC) rank_number
			from (select
						PNAME,
						PROF1 language,
						SALARY
					from Programmer
					union
					select
						pname,
						PROF2 language,
						SALARY
					from Programmer) t
		)

		select 
			pname,
			language,
			salary
		from rank_lang
		where rank_number = 1

-- 48) Who is the least experienced programmer
	--A)
		select
			pname,
			DATEDIFF(year,DOJ,GETDATE()) experience
		from Programmer
		where DATEDIFF(year,DOJ,GETDATE()) = (select min(DATEDIFF(year,DOJ,GETDATE())) 
												from Programmer)

-- 49) Who is the most experienced male programmer knowing PASCAL
	--A)
		with t as
		(
			select * from Programmer
			where GENDER like 'm'
			and PROF1 like 'pascal'
			or PROF2 like 'pascal'
		)

		select
			pname,
			DATEDIFF(year,DOJ,GETDATE()) experience
		from t
		where DATEDIFF(year,DOJ,GETDATE()) = (select max(DATEDIFF(year,DOJ,GETDATE())) from t)

-- 50) Which language is known by only one programmer
	--A)
		select
			t.language,
			count(t.language) count_of_programmers
		from (select
					PNAME,
					PROF1 language,
					SALARY
				from Programmer
				union
				select
					pname,
					PROF2 language,
					SALARY
				from Programmer) t
		group by t.language
		having count(t.language) = 1
		

-- 51) Who is the above programmer referred in 50
	--A)
		with lang_count(language,count) as 
		(
			select
				t.language,
				count(t.language) count
			from  (select
						PNAME,
						PROF1 language,
						SALARY
					from Programmer
					union
					select
						pname,
						PROF2 language,
						SALARY
					from Programmer) t
			group by t.language
			having count(t.language) = 1
		)

		select
			s.PNAME,
			s.language
		from  (select
					PNAME,
					PROF1 language,
					SALARY
				from Programmer
				union
				select
					pname,
					PROF2 language,
					SALARY
				from Programmer) s
		where s.language in (select language from lang_count)
		order by s.PNAME

-- 52) Who is the youngest programmer knowing dBase
	--A)
		with t as
		(
			select * from Programmer
			where PROF1 like 'dBase'
			or PROF2 like 'dBase'
		)

		select
			pname,
			DATEDIFF(year,DOB,GETDATE()) age
		from t
		where DATEDIFF(year,DOB,GETDATE()) = (select min(DATEDIFF(year,DOB,GETDATE())) from t)
		

-- 53) Which female programmer earning more than 3000 does not know C, C++, Oracle or dBase
	--A)
		select *
		from Programmer
		where GENDER like 'f'
			and SALARY > 3000
			and PROF1 not in ('c','cpp','oracle','dbase')
			and PROF2 not in ('c','cpp','oracle','dbase')

-- 54) Which institute has the most number of students
	--A)
		with t as
		(
			select
				INSTITUTE,
				count(institute) student_count
			from Studies
			group by INSTITUTE
		)

		select * from t
		where student_count = (select max(student_count) from t)

-- 55) What is the costliest course
	--A)
		select
			COURSE,
			COURSE_FEE
		from Studies
		where COURSE_FEE = (select max(COURSE_FEE) from Studies)

-- 56) Which course has been done by the most number of students
	--A)
		with t as
		(
			select
				COURSE,
				count(course) student_count
			from Studies
			group by COURSE	
		)

		select * from t
		where student_count = (select max(student_count) from t)

-- 57) Which institute conducts the costliest course
	--A)
		select
			INSTITUTE,
			course,
			course_fee
		from Studies
		where COURSE_FEE = (select max(course_fee) from Studies)

-- 58) Display the name of the institute and the course which has below average course fee
	--A)
		select
			INSTITUTE,
			COURSE
		from Studies
		where COURSE_FEE < (select avg(course_fee) from Studies)

-- 59) Display the names of the courses whose fees are within 1000 (+ or -) of the average fee
	--A)
		select
			COURSE
		from Studies
		where COURSE_FEE < (select avg(course_fee)+1000 from Studies)
			and COURSE_FEE > (select avg(course_fee)-1000 from Studies)

-- 60) Which package has the highest development cost
	--A)
		select
			TITLE,
			DCOST
		from Software
		where DCOST = (select max(dcost) from Software)

-- 61) Which course has below average number of students
	--A)
		select
			COURSE,
			count(course) student_count
		from Studies
		group by COURSE
		having count(course) < (select avg(cast(s.count as float))
								from (select
											course,
											count(course) count
										from Studies
										group by COURSE) s)

-- 62) Which package has the lowest selling cost
	--A)
		select
			distinct TITLE,
			SCOST
		from Software
		where SCOST = (select min(scost) from Software)

-- 63) Who developed the package that has sold the least number of copies
	--A)
		select
			pname,
			sold
		from Software
		where sold = (select min(sold) from Software)

-- 64) Which language has been used to develop the package which has the highest sales amount
	--A)
		select
			DEVELOPIN,
			(SCOST*SOLD) Hsales_amount
		from Software
		where (SCOST*SOLD) = (select max(SCOST*SOLD) from Software)



-- 65) How many copies of the package that has the least difference between development and selling cost were sold
	--A)
		select
			TITLE,
			(DCOST-SCOST) cost_diff,
			sold
		from Software
		where (DCOST-SCOST) = (select min(DCOST-SCOST) from Software)

-- 66) Which is the costliest package developed in Pascal
	--A)
		select
			TITLE,
			DCOST
		from Software
		where DEVELOPIN like 'pascal'
		and DCOST = (select max(dcost) from Software
						where DEVELOPIN like 'pascal')

-- 67) Which language was used to develop the most number of packages
	--A)
		with t as
		(
			select
				DEVELOPIN,
				count(title) package_count
			from Software
			group by DEVELOPIN
		)

		select * from t
		where package_count = (select max(package_count) from t)

-- 68)Which programmer has developed the highest number of packages
	--A)
		with t as
		(
			select
				PNAME,
				count(title) package_count
			from Software
			group by PNAME
		)

		select * from t
		where package_count = (select max(package_count) from t)

-- 69) Who is the author of the costliest package
	--A)
		select
			TITLE,
			PNAME,
			DCOST
		from Software
		where DCOST = (select max(dcost) from Software)

-- 70) Display the names of the packages which have sold less than the average number of copies
	--A)
		select
			TITLE,
			sum(SOLD) sold_count
		from Software
		group by TITLE
		having sum(SOLD) < (select avg(cast(SOLD as float)) from Software)

-- 71) Who are the authors of the packages which have recovered more than double the development cost
	--A)
		select distinct PNAME
		from Software
		where (DCOST*2) < (SCOST*SOLD)

-- 72) Display the programmer names and the cheapest packages developed by them in each language
	--A)
		select
			PNAME,
			TITLE,
			DEVELOPIN,
			round(min(DCOST),2) min_dcost
		from Software
		group by PNAME, TITLE, DEVELOPIN

-- 73) Display the language used by each programmer to develop the highest selling and lowest selling package
	--A)

		with sold_rank as 
		(
			SELECT
				PNAME,
				TITLE,
				DEVELOPIN,
				SOLD,
				ROW_NUMBER() OVER (PARTITION BY PNAME ORDER BY SOLD DESC) AS h_sold_rank,
				ROW_NUMBER() OVER (PARTITION BY PNAME ORDER BY SOLD ASC) AS l_sold_rank
			FROM
			Software
		)

		SELECT
			s1.pname,
			s1.title AS h_sold_pack,
			s1.developin AS Lang_h_sold_pack,
			s1.sold AS count_h_sold_pack,
			s2.title AS l_sold_pack,
			s2.developin AS Lang_l_sold_pack,
			s2.sold AS count_l_sold_pack
		FROM sold_rank s1
		JOIN sold_rank s2 ON s1.pname = s2.pname
		WHERE s1.h_sold_rank = 1
			AND s2.l_sold_rank = 1

-- 74) Who is the youngest male programmer born in 1965
	--A)
		select *
		from Programmer
		where GENDER = 'm'
			and DOB = (select max(DOB) from Programmer
						where GENDER = 'm' and year(DOB) = 1965)
			

-- 75) Who is the oldest female programmer who joined in 1992
	--A)
		select *
		from Programmer
		where GENDER = 'f'
			and DOB = (select min(DOB) from Programmer
						where GENDER = 'f' and year(DOJ) = 1992)

-- 76) In which year was the most number of programmers born
	--A)
		with t as
		(
			select
				YEAR(DOB) year_born,
				count(YEAR(DOB)) count_born
			from Programmer
			group by YEAR(DOB)
		)

		select * from t
		where count_born = (select max(count_born) from t)


-- 77) In which month did the most number of programmers join
	--A)
		with t as
		(
			select
				month(DOJ) join_month,
				count(month(DOJ)) count_join
			from Programmer
			group by month(DOJ)
		)

		select * from t
		where count_join = (select max(count_join) from t)

-- 78) In which language are most of the programmer’s proficient
	--A)
		with t1 as 
		(
			select
				t.language,
				count(t.language) count_of_programmers
			from (select
						PNAME,
						PROF1 language,
						SALARY
					from Programmer
					union
					select
						pname,
						PROF2 language,
						SALARY
					from Programmer) t
			group by t.language
		)

		select * from t1
		where t1.count_of_programmers = (select max(t1.count_of_programmers) from t1)

-- 79) Who are the male programmers earning below the average salary of female programmers
	--A)
		select
			PNAME,
			SALARY
		from Programmer
		where GENDER like 'm'
		 and SALARY < (select avg(salary) from Programmer where GENDER like 'f')

-- 80) Who are the female programmers earning more than the highest paid
	--A) since the question seems to be incomplete, I'll assume it meant highest paid male programmer
		select
			PNAME,
			SALARY
		from Programmer
		where GENDER like 'f'
		 and SALARY > (select max(salary) from Programmer where GENDER like 'm')

-- 81) Which language has been stated as the proficiency by most of the programmers
	--A)
		with t1 as 
		(
			select
				t.language,
				count(t.language) count_of_programmers
			from (select
						PNAME,
						PROF1 language,
						SALARY
					from Programmer
					union
					select
						pname,
						PROF2 language,
						SALARY
					from Programmer) t
			group by t.language
		)

		select *
		from t1
		where t1.count_of_programmers = (select max(t1.count_of_programmers) from t1)

-- 82) Display the details of those who are drawing the same salary
	--A)
		select *
		from Programmer
		where SALARY in (select SALARY from Programmer
							group by SALARY
							having COUNT(SALARY)>1)
		order by SALARY

-- 83) Display the details of the software developed by the male programmers earning more than 3000
	--A)
		select s.*
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		where p.GENDER like 'm'
			and p.SALARY > 3000

-- 84) Display the details of the packages developed in Pascal by the female programmers
	--A)
		select s.*
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		where p.GENDER like 'f'
			and s.DEVELOPIN like 'pascal'

-- 85) Display the details of the programmers who joined before 1990
	--A)
		select *
		from Programmer
		where year(doj) < 1990

-- 86) Display the details of the software developed in C by the female programmers at Pragathi
	--A)
		select s.*
		from Software s
		left join Studies st on s.PNAME=st.PNAME
		left join Programmer p on s.PNAME=p.PNAME
		where s.DEVELOPIN like 'c'
			and p.GENDER like 'f'
			and st.INSTITUTE like 'pragathi'

		-- since there are no records matching the above question. Lets change the language to dbase for the above question
		select s.*
		from Software s
		left join Studies st on s.PNAME=st.PNAME
		left join Programmer p on s.PNAME=p.PNAME
		where s.DEVELOPIN like 'dbase'
			and p.GENDER like 'f'
			and st.INSTITUTE like 'pragathi'

-- 87) Display the number of packages, number of copies sold and sales value of each programmer institute wise
	--A)
		select
			st.INSTITUTE,
			count(s.title) count_package,
			sum(s.sold) copies_sold,
			sum(s.scost*s.sold) sales_value
		from Studies st
		left join Software s on st.PNAME=s.PNAME
		group by st.INSTITUTE

-- 88) Display the details of the software developed in dBase by male programmers who belong to the institute in which the most number of programmers studied
	--A)
		with i as 
		(
			select 
				INSTITUTE, 
				count(institute) count
			from Studies
			group by INSTITUTE
		)
		
		select s.*
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		left join Studies st on s.PNAME=st.PNAME
		where s.DEVELOPIN like 'dbase'
			and p.GENDER like 'm'
			and st.INSTITUTE like (select INSTITUTE from i
									where count = (select max(count) from i))

-- 89) Display the details of the software developed by the male programmers born before 1965 and female programmers born after 1975
	--A)
		select *
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		where p.PNAME in (select PNAME from Programmer where GENDER like 'm' and year(dob) < 1965)
			or p.PNAME in (select PNAME from Programmer where GENDER like 'f' and year(dob) > 1975)

		-- There are no records in the provided tables for the above mentioned details

-- 90) Display the details of the software that has been developed in the language which is neither the first nor the second proficiency of the programmers
	--A)
		select *
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		where s.DEVELOPIN not in (select
										PROF1 language
									from Programmer
									union
									select
										PROF2 language
									from Programmer)

		-- There are no records in the provided tables for the above mentioned details

-- 91) Display the details of the software developed by the male students at Sabhari
	--A)
		select s.*
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		left join Studies st on s.PNAME=st.PNAME
		where p.GENDER like 'm'
			and st.INSTITUTE like 'sabhari'

-- 92) Display the names of the programmers who have not developed any packages
	--A)
		select p.PNAME
		from Programmer p
		where p.PNAME not in (select distinct s.pname from Software s)

-- 93) What is the total cost of the software developed by the programmers of Apple
	--A)
		select sum(s.dcost) total_dcost
		from Software s
		left join Studies st on s.PNAME=st.PNAME
		where st.INSTITUTE like 'apple'


-- 94) Who are the programmers who joined on the same day
	--A)
		select
			DOJ,
			PNAME
		from Programmer
		where DOJ in ( select DOJ
						from Programmer
						group by DOJ
						having count(doj)>1)
		order by DOJ

-- 95) Who are the programmers who have the same Prof2
	--A)
		select
			PROF2,
			PNAME
		from Programmer
		where PROF2 in ( select PROF2
							from Programmer
							group by PROF2
							having count(prof2)>1)
		order by PROF2

-- 96) Display the total sales value of the software institute wise
	--A)
		select 
			st.INSTITUTE,
			sum(s.scost*s.sold) sales_value
		from Studies st
		left join Software s on st.PNAME=s.PNAME
		group by st.INSTITUTE

-- 97) In which institute does the person who developed the costliest package study
	--A)
		select INSTITUTE
		from Studies
		where PNAME like (select pname
							from Software
							where DCOST = (select max(dcost) 
											from Software))

-- 98) Which language listed in Prof1, Prof2 has not been used to develop any package
	--A)
		with i as 
		(
			select
				PROF1 language
			from Programmer
			union
			select
				PROF2 language
			from Programmer
		)

		select *
		from i
		where language not in (select distinct DEVELOPIN from Software)

-- 99) How much does the person who developed the highest selling package earn and what course did he/she undergo
	--A)
		select
			p.PNAME,
			p.SALARY,
			(case when p.PNAME='PATTRICK' then (select COURSE
												from Studies
												where PNAME like 'PATRICK')
				else st.COURSE end)
		from Programmer p
		left join Studies st on p.PNAME=st.PNAME
		where p.PNAME in (select PNAME
							from Software
							where sold = (select max(sold) from Software))

		-- I had to include a case statement to adjust for a probable error in the table data where the name PATTRICK is spelled wrong in studies table
		-- This however is just a temporary fix for the problem. A better fix would be to change the data in the table itself

-- 100) What is the average salary for those whose software sales is more than 50,000
	--A)
		with sale as 
		(
			select
				PNAME,
				sum(SCOST*SOLD) Tsale
			from Software
			group by PNAME
		)

		select avg(p.salary) avg_salary
		from sale s
		left join Programmer p on s.PNAME=p.PNAME
		where (s.Tsale)>50000

-- 101) How many packages were developed by students who studied in institutes that charge the lowest course fee
	--A)
		select count(s.title) pack_count
		from Software s
		left join Studies st on s.PNAME=st.PNAME
		where st.COURSE_FEE = (select 
									min(course_fee)
								from Studies)

-- 102) How many packages were developed by the person who developed the cheapest package? Where did he/she study
	--A)
		select
			s.PNAME,
			st.INSTITUTE,
			count(s.title) pack_count
		from Software s
		left join Studies st on s.PNAME=st.PNAME
		where DCOST = (select min(dcost) from Software)
		group by s.PNAME, st.INSTITUTE

-- 103) How many packages were developed by female programmers earning more than the highest paid male programmer
	--A)
		select 
			s.PNAME,
			count(s.title) pack_count
		from Software s
		left join Programmer p on s.PNAME=p.PNAME
		where p.GENDER like 'f'
			and p.SALARY > (select max(salary)
							from Programmer
							where GENDER like 'm')
		group by s.PNAME

-- 104) How many packages are developed by the most experienced programmers from BDPS
	--A)
		select count(title) pack_count
		from Software
		where PNAME like (select 
								st.PNAME
							from Programmer p
							left join Studies st on p.PNAME=st.PNAME
							where st.INSTITUTE like 'bdps'
								and DATEDIFF(year,DOJ,GETDATE()) = (select max(DATEDIFF(year,DOJ,GETDATE())) 
																	from Programmer p
																	left join Studies st on p.PNAME=st.PNAME
																	where st.INSTITUTE like 'bdps'))

-- 105) List the programmers (from the software table) and the institutes they studied at
	--A)
		select 
			distinct s.PNAME,
			(case when s.PNAME='PATTRICK' then (select institute
												from Studies
												where PNAME like 'PATRICK')
				else st.INSTITUTE end) INSTITUTE
		from Software s
		left join Studies st on s.PNAME=st.PNAME

		-- I had to include a case statement to adjust for a probable error in the table data where the name PATTRICK is spelled wrong in studies table
		-- This however is just a temporary fix for the problem. A better fix would be to change the data in the table itself

-- 106) List each PROF with the number of programmers having that PROF and the number of the packages in that PROF
	--A)
		with i as 
		(
			select
				PROF1 language,
				PNAME
			from Programmer
			union
			select
				PROF2 language,
				PNAME
			from Programmer
		)

		select 
			t1.language,
			t1.prog_count,
			t2.pack_count
		from (select
					language,
					count(pname) prog_count
				from i
				group by language) t1
		left join (select
						DEVELOPIN,
						count(title) pack_count
					from Software
					group by DEVELOPIN) t2 on t1.language=t2.DEVELOPIN

-- 107) List the programmer names (from the programmer table) and the number of packages each has developed
	--A)
		select
			p.PNAME,
			count(s.title) pack_count
		from Programmer p
		left join Software s on p.PNAME=s.PNAME
		group by p.PNAME