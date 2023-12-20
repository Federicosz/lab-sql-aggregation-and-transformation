-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) as 'max_duration', min(length) as 'min_duration' from film;
-- 1.2. Express the average movie duration in hours and minutes. 
select floor(avg(length)/60) as 'hours'	,round(avg(length)-60*floor(avg(length)/60),0) as 'minutes' from film;
-- 2.1 Calculate the number of days that the company has been operating.
select datediff(max(rental_date),min(rental_date)) as '# of days open' from rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *,monthname(rental_date) as 'rental_month',dayname(rental_date) as 'rental_day' from rental;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
select *,case when dayofweek(rental_date) between 1 and 5 then 'workday' else 'weekend' end as 'day_type' from rental;
-- select distinct day_type from rental; ???
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select title, case when rental_duration is null then 'Not Available' else rental_duration end as rental_duration from film order by rental_duration desc;
-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers.
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address,
-- so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by
-- last name in ascending order to make it easier to use the data.
select concat(first_name,' ',last_name),left(email,3) from customer order by last_name;
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(title) from film;
-- 1.2 The number of films for each rating.
select distinct rating, count(rating) as frequency from film group by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
--  This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select distinct rating, count(rating) as frequency from film group by rating order by count(rating) desc;
-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select distinct rating, round(avg(length),2) from film group by rating order by avg(length) desc;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select distinct rating, round(avg(length),2) from film group by rating having avg(length)>120;
-- Bonus: determine which last names are not repeated in the table actor.
select distinct last_name, count(last_name) from actor group by last_name having count(last_name)=1;