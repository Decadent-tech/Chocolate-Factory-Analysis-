-- Select everything from sales table

select * from sales;

-- Show just a few columns from sales table

select SaleDate, Amount, Customers from sales;
select Amount, Customers, GeoID from sales;


-- Adding a calculated column with SQL

Select SaleDate, Amount, Boxes, Amount / boxes  from sales;

-- Naming a field with AS in SQL

Select SaleDate, Amount, Boxes, Amount / boxes as 'Amount per box'  from sales;

-- Using WHERE Clause in SQL

select * from sales
where amount > 10000;

-- Showing sales data where amount is greater than 10,000 by descending order
select * from sales
where amount > 10000
order by amount desc;


-- Showing sales data where geography is g1 by product ID &
-- descending order of amounts

select * from sales
where GeoID='G1'
order by PID, Amount desc;

-- Working with dates in SQL

Select * from sales
where amount > 10000 and SaleDate >= '2022-01-01';

-- Using year() function to select all data in a specific year

select SaleDate, Amount from sales
where Amount > 10000 and year(SaleDate) = 2022
order by Amount desc;

-- BETWEEN condition in SQL with < & > operators

select * from sales
where Boxes >0 and Boxes <=50;

-- Using the between operator in SQL

select * from sales
where Boxes between 0 and 50;

-- Using weekday() function in SQL

select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of week'
from sales
where weekday(SaleDate) = 4;


-- Working with People table

select * from people;

-- OR operator in SQL

select * from people
where Team = 'Delish' or Team = 'Jucies';

-- IN operator in SQL

select * from people
where Team in ('Delish','Jucies');

-- LIKE operator in SQL

select * from people
where Salesperson like 'B%';

select * from people
where salesperson like '%B%';

select * from sales;

-- Using CASE to create branching logic in SQL

select 	SaleDate, Amount,
		case 	when Amount < 1000 then 'Under 1k'
				when Amount < 5000 then 'Under 5k'
                when Amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount category'
from sales;

-- GROUP BY in SQL

select team, count(*) from people
group by team;


#1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales
where Amount > 2000 and Boxes< 100;



#2. How many shipments (sales) each of the sales persons had in the month of January 2022?
select * from sales;
select * from people;

select sp.Salesperson , count(*) as 'shipment count'
from sales as s
join people as sp 
on sp.SPID = s.SPID
where SaleDate between '2022-1-1' and '2022-1-31'
group by sp.Salesperson;


#3. Which product sells more boxes? Milk Bars or Eclairs?
select * from sales;
select * from products;
select p.Product , sum(s.Boxes) as 'Boxes in Total' 
from products as p 
join sales as s 
on p.PID = s.PID
where p.Product in ('Milk Bars', 'Eclairs')
group by p.Product;

#4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select p.Product , sum(s.Boxes) as 'Boxes in Total' 
from products as p 
join sales as s 
on p.PID = s.PID
where p.Product in ('Milk Bars', 'Eclairs')
and s.SaleDate between  '2022-2-1' and '2022-2-7'
group by p.Product;

#5. Which shipments had under 100 customers & under 100 boxes? 
#Did any of them occur on Wednesday?

select * from sales 
where Customers<100 and Boxes <100;

select * , 
case 
	when weekday(SaleDate)=2 then "Wednesday Shipment"
End as 'LabelShipmentDay'
from sales
where Customers<100 and Boxes <100 and weekday(SaleDate)=2
order by Amount desc
limit 10 ;


#What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?


select distinct p.Salesperson 
from sales as s
join people as p
on p.SPID = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-07';

#Which salespersons did not make any shipments in the first 7 days of January 2022?
select distinct p.Salesperson 
from sales as s
join people as p
on p.SPID not in (select s.SPID from sales s  
			where s.SaleDate between '2022-01-01' and '2022-01-07');
            
#How many times we shipped more than 1,000 boxes in each month?

select year(SaleDate) 'Year', month(SaleDate) 'Month' , count(*) as '1k boxes shipped'
from sales 
where Boxes >1000
group by year(SaleDate), month(SaleDate)
order by year(SaleDate), month(SaleDate);

#Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select * from products ;
select * from people;
select * from geo;
select * from sales;
select year(SaleDate) 'Year', month(SaleDate) 'Month' , if(count(*)>=1,"Yes","No")as 'boxes shipped'
from sales as s 
join products as pr
on pr.PID= s.PID
join geo as g 
on g.GeoID = s.GeoID
where pr.Product = "After Nines" and g.Geo = "New Zealand" 
group by year(SaleDate), month(SaleDate)
order by year(SaleDate), month(SaleDate);


#India or Australia? 
#Who buys more chocolate boxes on a monthly basis?

select year(saledate) ‘Year’, month(saledate) ‘Month’,
sum(case when g.Geo ='India' then 1 else 0 END) 'India Boxes',
sum(case when g.Geo ='Australia' then 1 else 0 END) 'Australia Boxes'
from sales as s 
join geo as g 
on g.GeoID = s.GeoId 
group by year(SaleDate) , month(SaleDate) 
order by  year(SaleDate) , month(SaleDate) ;



















