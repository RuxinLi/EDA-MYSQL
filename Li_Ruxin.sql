/*Assignment 3 Ruxin Li
October 23，2019*/

use classicmodels;

-- Query 1
-- Create a list, by office country, of the counts of each employee job titles in that country
select o.country, e.jobTitle, count(*)
from employees e, offices o
where e.officeCode=o.officeCode
group by o.country,e.jobTitle;

-- Query 2
-- List Customer Name, Customer Country, and number of orders (in descending order) for all customers that have placed more than 10 orders
select c.customerName, c.country, count(*) as 'number of orders'
from customers c, orders o
where c.customerNumber=o.customerNumber
group by c.customerName,c.country
having count(*)>10
order by count(*) desc;

-- Query 3
-- List, in descending order, the Customer Name, Total Amount Spent (quantityOrdered*priceEach) for each Customer for the top 10 customers
select c.customerName, sum(d.quantityOrdered*d.priceEach) as 'Total Amount Spent'
from customers c, orders o, orderdetails d
where c.customerNumber=o.customerNumber and 
o.orderNumber=d.orderNumber
group by c.customerName
order by sum(d.quantityOrdered*d.priceEach) desc 
limit 10;

-- Query 4
-- create a new view 'customersalesbyorder'
create view customersalesbyorder as
select c.customerNumber,o.orderNumber, sum(d.quantityOrdered*d.priceEach) as 'TotalAmount'
from orders o,orderdetails d,customers c
where o.orderNumber=d.orderNumber and
c.customerNumber=o.customerNumber
group by c.customerNumber,o.orderNumber;

-- Customer country, customer name, sales rep last name, sales rep first name, sales rep email and average order amount for the customer with the highest average order amount.
select c.country, c.customerName, e.lastName as 'sales rep last name', e.firstName as 'sales rep first name', e.email as 'sales rep email ', avg(s.TotalAmount) as 'average order amount'
from customers c, employees e,customersalesbyorder s
where c.customerNumber=s.customerNumber and 
e.employeeNumber=c.salesRepEmployeeNumber
group by c.country, c.customerName, e.lastName, e.firstName, e.email
order by avg(s.TotalAmount) desc
limit 1;

-- Query 5
-- Create an order list for the most profitable customer. List the customer name, order date, and Total Purchased (quantityOrdered*priceEach) for each order.
select  c.customerName as 'the most profitable customer name', o.orderDate, sum(d.quantityOrdered*d.priceEach) as 'Total Purchased'
from customers c, orders o, orderdetails d
where c.customerNumber=o.customerNumber and 
o.orderNumber=d.orderNumber and 
c.customerName =
				(select c.customerName
				from customers c,customersalesbyorder s
				where c.customerNumber=s.customerNumber
				group by c.customerName
				order by sum(s.TotalAmount) desc 
				limit 1)
group by c.customerName,o.orderDate;
