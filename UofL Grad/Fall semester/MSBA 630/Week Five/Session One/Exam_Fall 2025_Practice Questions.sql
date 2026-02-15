


--1 Write the balance summary (min,max,avg,total,count) of customer balacnces.
select * from CUSTOMER
select min(cus_balance) 'Minimum Cus_balance', 
		max(cus_balance) 'Maximum Cus_balance', 
		avg(cus_balance) 'Average Cus_balance', 
		sum(cus_balance) 'total cus_balance', 
		count(cus_balance) 'Num of Cus-balance'
from CUSTOMER

--2 Write a query to display the brand ID, brand name, brand type, and average price of products for the
-- brand that has the largest average product price.

Create view Average Price
as 
 
select .brand_id,, avg(prod_price) 'Average Product price'
from lgproduct
group by brand_id



select .brand_id, brand_name, brand_type, Average Product price
from 



select P.brand_id, 
		brand_name, 
		brand_type, avg(prod_price) 'Average Product price'
from lgbrand B
join lgproduct P on B.brand_id = P.brand_id
group by P.brand_id, brand_name, brand_type

--3 List the names (First and last name) and addresses(city and state) of all participants who have 
--registered for at least three tours.
select * from participant
select * from reservation 

select Part_Fname, 
		Part_Lname, 
		Part_City, 
		Part_State, 
		count(*) 'num of tours'
from participant P join 
		partres PA 
		on P.Part_ID = PA.Part_ID
group by Part_Fname, 
			Part_Lname, 
			Part_City, 
			Part_State
Having count(*) >= 3


--4 Write a query to display the employee number, first name, last name, and largest salary 
--amount for each employee in department 200. Sort the output by largest salary in descending order.
select * from lgemployee
select * from lgdepartment

select E.emp_num, emp_fname, emp_lname, max(SH.sal_amount) 'Largest Salary', dept_num
from lgemployee E inner join lgsalary_history SH on E.emp_num = SH.emp_num
where dept_num = 200
group by  E.emp_num, emp_fname, emp_lname, dept_num
order by max(SH.sal_amount) DESC


--5 Write a query to display the customer code, first name, last name, and sum of all invoice totals for 
--customers with cumulative invoice totals greater than $1,500. Sort the output by the sum of invoice totals in descending order.
select * from CUSTOMER
select * from INVOICE

select C.CUS_CODE, CUS_FNAME, CUS_LNAME, sum(cus_balance) 'Total'
from CUSTOMER C
	join invoice I on C.cus_code = I.cus_code
where CUS_BALANCE > 1500
group by C.CUS_CODE, CUS_FNAME, CUS_LNAME


--6 list vendor code and vendor name who produce a product
--JOIN
select distinct(P.V_CODE), V_NAME 
from VENDOR V
	inner join product P on V.V_CODE = P.V_CODE

--SUBQUERY
select V_CODE, V_NAME
from VENDOR
where v_code in (select v_code 
					from product)

--CORRELATED QUERY
select V.V_CODE, V_NAME
from VENDOR V
where exists 
	(select P.V_CODE 
	from product P 
	where V.V_code = P.V_CODE)


--7 SELECT PRODUCT CODE AND VENDOR NAME FOR PRODUCTS THAT THEY DON'T HAVE VENDOR?(USING PROPER JOIN)
--SELECT P_CODE,P_DESCRIPT,V_CODE FROM PRODUCT

select P_CODE, P_DESCRIPT, V.V_CODE
from product P
left join VENDOR V on V.V_CODE = P.V_CODE
where V.V_CODE is null

--8  table employee2:
create table employee2 (
employee_id int not null,
first_name varchar(40),
last_name varchar(40),
job_title varchar(40),
hire_date date,
salary decimal(10,2),
manager_id int
);

alter table employee2
add constraint PK_employee2 primary key(employee_id),
	constraint FK_emplyee2 foreign key(manager_id) references employee2 (employee_id)


--9 insert Some values into employee table based on provided instruction:
--Smith Jeanne with employee id 5000 as a Financial Manager hired in 1/1/2008 with 100000 salary. Smith does not have the manager.

insert into employee2 
values (5000, 'Smith', 'Jeanne', 'Financial manager', '1/1/2008', '100000', null)
select * from employee2

--10 insert Some values into employee table based on provided instruction:John Mayer with employee id 5001 is a staff hired in 10/06/2008 
--with 65000 salary. Smith is his manager
 insert into employee2
 values(5001, 'John', 'Mayer', 'staff', '10/06/2008', '65000', '5001')


--11 insert Some values into employee table based on provided instruction:Jeanne Smith with employee id 5002 is a Financial Manager
--hired in 01/01/2008 with 100000 salary. John Mayer is her manager

insert into employee2 
values(5002, 'Jeanne', 'Smith', 'Finanacial Manager', '01/01/2008', '100000', '5001')

--12 Copy the table EMPLOYEE2 and call it EMPLOYEE2TESTCOPY
select * into EMPLOYEE2TESTCOPY 
from employee2

--SELECT * FROM EMPLOYEE2TESTCOPY

--13 ADD NEW COLUMN INTO EMPLOYEE2TESTCOPY with DECIMAL AS IT'S DATATYPE (9,2)
alter table EMPLOYEE2TESTCOPY
add NewColumn decimal(9,2)


 --14 UPDATE THE NEW COLUMN AND MAKE IT EQUAL  TO 5
 update EMPLOYEE2TESTCOPY
 set NewColumn = 5

--15 DELETE ALL DATA FROM EMPLOYEE2TESTCOPY
delete from EMPLOYEE2TESTCOPY

--16 DROP TABLE EMPLOYEE2TESTCOPY
drop table EMPLOYEE2TESTCOPY
