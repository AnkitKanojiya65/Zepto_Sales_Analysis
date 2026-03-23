-- Create Database named - ZeptoProject
Use ZeptoProject;
-- Created Table named - Zepto
Create Table zepto (
Sku_id serial Primary key ,
Category varchar(120),
name varchar(150) not null,
mrp numeric (8,2),
discountPercent numeric (5,2),
availableQuantity int,
discountedSellingPrice numeric(8,2),
weightInGms int,
outOfStock boolean,
quantity int);
-- imported the data into "Zepto" table by using Table Data import wizard from my .csv file
-- lets see our table
select * from zepto LIMIT 10;
-- lets check the details of ouur table
DESCRIBE ZEPTO;
-- lets check if there is any null values in our table
SELECT * FROM ZEPTO
WHERE category IS NULL
or
mrp IS NULL
or
discountPercent IS NULL
or
availableQuantity IS NULL
or
discountedSellingPrice IS NULL
or
weightInGms IS NULL
or
outOfStock IS NULL
or
quantity IS NULL;
-- different product category
select distinct category from zepto;

-- lets check which products are in stock and which are not
select outofstock, count(sku_id) from zepto group by outofstock;

-- prodcut names present multiple times
select name, count(sku_id) as CountofID
from zepto
group by name
Having count(sku_id) >1
order by count(sku_id) desc ;

-- data cleaning
-- lets check whether is there any products with 0 price
select * from zepto where mrp = 0  or discountedsellingprice = 0;
-- we found one row with price = 0, now will delete it.
delete from zepto where mrp = 0;