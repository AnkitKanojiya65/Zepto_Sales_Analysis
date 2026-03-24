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

-- Now as we can see the price in our table is in paise not rupees, so lets convert it
update zepto
set mrp =mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

-- Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name,mrp,discountpercent from zepto
order by  discountpercent desc 
limit 10;
 
-- Q2.What are the Products with High MRP but Out of Stock
select distinct name,mrp,outofstock  from zepto where outofstock = TRUE and mrp>300
order by mrp desc;

-- Q3.Calculate Estimated Revenue for each category 
SELECT Category, SUM(discountedsellingprice * availablequantity) as totalrevenue from Zepto
group by Category order by totalrevenue ;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select name,mrp,discountpercent from Zepto where mrp>500 and discountpercent <10
order by mrp desc,discountpercent desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category, ROUND(AVG(discountpercent),2) as AvgDiscount
from zepto  
group by category 
order by AVG(discountpercent) desc LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name,weightinGms,discountedSellingprice,
round(discountedSellingprice/weightinGms,2) AS PriceperGms From zepto
where weightinGms>=100
ORDER BY PriceperGms ;

-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT distinct Category,weightinGms,
CASE WHEN weightinGms <1000 THEN 'LOW'
	WHEN weightinGms <5000 THEN 'MEDIUM'
    ELSE 'BULK'
    END AS WeightCategory
From zepto;
select * from zepto LIMIT 10;

-- Q8.What is the Total Inventory Weight Per Category
SELECT Category,
sum(weightingms*availablequantity) as Totalweight
from zepto
Group by Category 
order by Totalweight ;


