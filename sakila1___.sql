
#All films with PG-13 films with rental rate of 2.99 or lower

select * from film
where rating = "PG-13" and rental_rate <=2.99;


select * from film
where special_features like "%Deleted Scenes%";

select * from customer where active = 1;

# Names of customers who rented a movie on 26th July 2005
select r.rental_id, r.rental_date,c.customer_id, concat(c.first_name," ",c.last_name) as FullName from rental r 
join customer c on c.customer_id = r.customer_id
where date(r.rental_date)="2005-07-26";
#Distinct names of customers who rented a movie on 26th July 2005
select distinct c.customer_id, concat(c.first_name," ",c.last_name) as FullName from rental r 
join customer c on c.customer_id = r.customer_id
where date(r.rental_date)="2005-07-26";

#How many rentals we do on each day?
select date(rental_date), count(*) from rental
group by date(rental_date)order by count(*) desc; 


# All Sci-fi films in our catalogue
select * from film_category where category_id = 14;

select fc.film_id, fc.category_id,c.name
from   film_category fc
join category c on c.category_id=fc.category_id 
join film f on f.film_id = fc.film_id
where c.name = "Sci-Fi";
# Customers and how many movies they rented from us so far?

select * from rental limit 1;
select * from customer limit 1;
select c.customer_id , c.first_name , c.email , count(*) 'count'
from rental r 
join customer c 
on c.customer_id= r.customer_id
group by r.customer_id
order by count(*) desc ;

# Which movies should we discontinue from our catalogue (less than 2 lifetime rentals)
with low_rental as 
	( select inventory_id , count(*) from rental r 
	  group by inventory_id
	  having count(*)<=1
	)
select low_rental.inventory_id,i.film_id,f.title
from low_rental
join inventory i on i.inventory_id = low_rental.inventory_id
join film f on f.film_id = i.film_id;



# which movies are not returned yet?
select r.rental_id , r.customer_id,i.film_id,f.title
from rental as r 
join inventory as i 
on i.inventory_id = r.inventory_id 
join film as f on f.film_id=i.film_id
where return_date is null
order by f.title;

#How many distinct last names we have in the data?
select count(*) 
from (select distinct last_name from customer) as t ;

#How much money and rentals we make for Store 1 by day?  
select * from customer;
select * from store where store_id =1;
select * from rental;
select * from payment;

select date(r.rental_date)as `DAY`,sum(p.amount) AS `TOTAL AMOUNT`
from store as s
join customer as c
on c.store_id = s.store_id 
join rental as r 
on r.customer_id = c.customer_id
join payment as p 
on p.customer_id = c.customer_id 
where  s.store_id = 1
group by date(r.rental_date)
order by sum(p.amount) desc ;

#top 3 earning days so far 
# What are the three top earning days so far?
select date(r.rental_date)as `DAY`,sum(p.amount) AS `TOTAL AMOUNT`
from store as s
join customer as c
on c.store_id = s.store_id 
join rental as r 
on r.customer_id = c.customer_id
join payment as p 
on p.customer_id = c.customer_id 
group by date(r.rental_date)
order by sum(p.amount) desc 
limit 3;



