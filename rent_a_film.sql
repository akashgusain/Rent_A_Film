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
