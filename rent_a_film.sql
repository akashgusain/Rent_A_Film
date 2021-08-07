## 1. We want to run an Email Campaigns for customers of Store 2 (First, Last name, and Email address of customers from Store 2) 
select first_name, last_name, email,store_id from customer where store_id =2;

##2. List of the movies with a rental rate of 0.99$
select title, description, rental_rate from film where rental_rate=0.99 order by title;

##3. Your objective is to show the rental rate and how many movies are in each rental rate categories
select rental_rate,count(title) as movies_count from film group by rental_rate order by rental_rate;

##4. Which rating do we have the most films in?
select  rating,count(rating) as count_rating from film group by rating order by count_rating desc Limit 1;

##5. Which rating is most prevalent in each store?
select rating,COUNT(store_id) from  film JOIN inventory ON film.film_id=inventory.film_id where store_id=1  group by rating order by 2 DESC;

##6. We want to mail the customers about the upcoming promotion

##7. List of films by Film Name, Category, Language
select film.title,
category.name,
language.name 
from film 
inner join film_category 
on 
film.film_id=film_category.film_id 
inner join language 
on
language.language_id=film.language_id
inner join category 
on 
film_category.category_id=category.category_id ;

##8. How many times each movie has been rented out?

select film.title,count(inventory.film_id) from inventory
inner join film
on
film.film_id=inventory.film_id
inner join rental
on
inventory.inventory_id=rental.inventory_id
group by film.title;

##9. What is the Revenue per Movie?
select film.title, sum(payment.amount) from film join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id join payment on payment.rental_id=rental.rental_id group by film.title
order by 2 desc;

##10.Most Spending Customer so that we can send him/her rewards or debate points

select customer.customer_id ,concat(customer.first_name,' ',customer.last_name) as customer, sum(payment.amount) from customer
join payment 
on customer.customer_id=payment.customer_id
group by 1
order by 3 desc;

##11. What Store has historically brought the most revenue?

select store.store_id, sum(amount) as revenue from store
join inventory
on store.store_id=inventory.store_id 
join rental 
on rental.inventory_id=inventory.inventory_id 
join payment
on payment.rental_id=rental.rental_id
group by store.store_id
order by 2 desc;

##12.How many rentals do we have for each month?

select DATE_FORMAT(rental_date , '%m') as rental_month, count(*) as rental_count from rental
group by 1 order by 1;

##13.Rentals per Month (such Jan => How much, etc)

select DATE_FORMAT(rental_date , '%m/%y') as rental_month, sum(payment.amount) from rental
join payment on rental.rental_id=payment.rental_id
group by 1 order by 1;

##14.Which date the first movie was rented out?
select rental_date,film.title from rental join inventory 
on 
inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
order by rental_date limit 1;

##15.Which date the last movie was rented out?
select rental_date,film.title from rental join inventory 
on 
inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
order by rental_date desc limit 1;

##16.For each movie, when was the first time and last time it was rented out?
select max(rental_date) as last_time,
min(rental_date) as first_time,
film.title from rental join inventory 
on 
inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
group by film.title
order by 3;

##17.What is the Last Rental Date of every customer?
select rental.customer_id,max(rental.rental_date) from rental
group by rental.customer_id 
order by 2 desc;

##18.What is our Revenue Per Month?
select DATE_FORMAT(rental_date , '%m/%y') as rental_month, sum(payment.amount) from rental
join payment on rental.rental_id=payment.rental_id
group by 1 order by 1;

##19.How many distinct Renters do we have per month?
select DATE_FORMAT(rental_date , '%m/%y') as rental_month,count(distinct customer_id) from rental
group by 1 order by 1;

##20.Show the Number of Distinct Film Rented Each Month
select DATE_FORMAT(rental.rental_date , '%m/%y') as rental_month_year,
count(distinct film.title) as distinct_film_count from rental join inventory 
on 
inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
group by 1
order by 1;

##21.Number of Rentals in Comedy, Sports, and Family
select category.name, count(rental_id) from rental join inventory 
on 
inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
join film_category on film.film_id=film_category.film_id
join category on film_category.category_id=category.category_id
group by 1
order by 1;

##22.Users who have been rented at least 3 times

select rental.customer_id,count(rental.customer_id) as count_customer_id,concat(customer.first_name,' ',customer.last_name) as customer_name from rental join customer on
customer.customer_id=rental.customer_id
group by customer_id having count(rental.customer_id) >=3 ;

##23.How much revenue has one single store made over PG13 and R-rated films?
select store.store_id,sum(payment.amount) as revenue from rental join inventory 
on 
inventory.inventory_id=rental.inventory_id
join store on store.store_id=inventory.store_id
join film on film.film_id=inventory.film_id
join payment on payment.rental_id=rental.rental_id
where film.rating in('PG-13','R')
group by store.store_id
;

##24.Active User where active = 1
select first_name,last_name, active from customer where active=1;

##25.Reward Users: who has rented at least 30 times
select rental.customer_id,count(rental.customer_id) as count_customer_id,concat(customer.first_name,' ',customer.last_name) as customer_name from rental join customer on
customer.customer_id=rental.customer_id
group by customer_id having count(rental.customer_id) >=30 ;

##26.Reward Users who are also active
select rental.customer_id,count(rental.customer_id) as count_customer_id,
concat(customer.first_name,' ',customer.last_name) as customer_name from rental 
join customer on
customer.customer_id=rental.customer_id
where customer.active=1
group by customer_id having count(rental.customer_id) >=30 ;

##27.All Rewards Users with Phone
