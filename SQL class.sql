# * all table
select * 
from product;

# 起一个新的列名
select productid,productprice*1.1 as "New Price"
from product;

# Retrieve the product ID, product name, vendor ID, and product price for each product whose price is above $100
select productid,productname,vendorid,productprice
from product
where productprice>100;

# Retrieve the product ID, product name, vendor ID, and product price for each product in the FW category whose price is equal to or below $110
select productid,productname,productprice
from product
where productprice<=100 and
categoryid='FW';

# Show one instance of all the different VendorID values in the relation PRODUCT
select distinct vendorid
from product;

# Retrieve the product ID, product name, category ID, and product price for each product in the FW product category, sorted by product price
# 如果倒序 用DESC
select productid,productname,categoryid,productprice
from product
where categoryid='FW'
order by productprice;

# Retrieve the record for each product whose product name contains the phrase ’Boot’
select productname
from product
where productname like "%boot%";

# Retrieve the average price of all products
select avg(productprice)
from product;

# Show how many products we offer for sale
select count(*)
from product;

select count(distinct vendorid)
from product;

select count(distinct vendorid)
from product
where categoryid='FW';

#开之前要选schemas
use zagi;
select count(*)
from product
group by vendorid;

use zagi;
# For each vendor, retrieve the number of products supplied by the vendor and the average price of the products supplied by the vendor
select vendorid, count(*), avg(productprice)
from product
group by vendorid;

# For each vendor, retrieve the vendor ID and the number of products with a product price of $100 or higher supplied by the vendor
select vendorid, count(*)
from product
where productprice>=100
group by vendorid;

# For each such group, retrieve the vendor ID,  product category ID, number of products in the group, and average price of the products in the group.
select vendorid, categoryid,count(*),avg(productprice)
from product
group by vendorid,categoryid
order by vendorid;

# For each such group, retrieve the vendor ID,  product category ID, number of products in the group, and average price of the products in the group.
select productid, sum(noofitems) 
from soldvia
group by productid;

# For each product, retrieve the ProductID value and the number of sales transactions in which the product was sold
select productid, count(*) 
from soldvia
group by productid;

###HAVING--PPT38####
#Q22/Q23
select productid,categoryid, count(*), avg(productprice)
from product
where productprice>=50
group by vendorid,categoryid
Having count(*)>1; ##where not use under the group by, use before group by

# Q24
select productid,sum(noofitems)product
from soldvia
group by productid
having sum(noofitems)>3;

use zagi;


create view product_more_than_3_sold as
select productid,productname,productprice
from product
where productid in
(select productid
from soldvia
group by productid
having sum(noofitems)>3);

create view product_in_multiple_trnsc as
select productid,productname,productprice
from product
where productid in
(select productid
from soldvia
group by productid
having count(*)>1);

-- union
select *from product_more_than_3_sold
union
select* from product_in_multiple_trnsc;

-- intersect (mysql not have this function)
select *from product_more_than_3_sold
intersect
select* from product_in_multiple_trnsc;

-- instead of intersect
select *
from product_more_than_3_sold
where productid in
(select productid
from product_in_multiple_trnsc);

select t1.*
from product_in_multiple_trnsc t1
inner join product_more_than_3_sold t2
on t1.productid=t2.productid;

select t1.*
from product_in_multiple_trnsc t1,product_more_than_3_sold t2
where t1.productid=t2.productid;

-- MINUS/EXCEPT (mysql not have this function)

use hafh;
-- outer join; left; right


use classicmodels;

set @total=0;
CALL CountOrderByStatus('in process',@total);
select @total;

set @counter=1;
call set_counter(@counter,1);
select@counter;








