-- SQL Analysis for DVD Rental Database

-- 1. What are the unique movie categories?
SELECT * FROM category;

-- 2. What is the category id for comedy?
SELECT category_id, name FROM category WHERE name = 'Comedy';

-- 3. How many comedy movies are in the store?
SELECT COUNT(*) AS comedy_count
FROM film_category
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy';

-- 4. List all comedy movies in the store.
SELECT title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy';

-- 5. Which customer generated the most revenue?
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS total_amount
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY total_amount DESC
LIMIT 1;

-- 6. Which day had the highest total revenue?
SELECT 
  TRIM(TO_CHAR(payment_date, 'Day')) AS weekday_name,
  EXTRACT(DOW FROM payment_date) AS day_of_week,
  SUM(amount) AS total_revenue
FROM payment
GROUP BY weekday_name, day_of_week
ORDER BY total_revenue DESC
LIMIT 1;

-- 7. Average rental duration per film category.
SELECT category.name AS category,
       AVG(rental.return_date - rental.rental_date) AS average_rental_days
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- 8. Which city rents the most DVDs?
SELECT city.city AS city_name, COUNT(rental.rental_id) AS number_of_rentals
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
GROUP BY city.city_id
ORDER BY number_of_rentals DESC
LIMIT 1;

-- 9. Top 3 most rented movies in each category.
WITH ranked_films AS (
    SELECT category.name AS category,
           film.title,
           COUNT(rental.rental_id) AS rental_count,
           ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS rank_in_category
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    GROUP BY category.name, film.title
)
SELECT category, title, rental_count
FROM ranked_films
WHERE rank_in_category <= 3
ORDER BY category, rank_in_category;

-- 10. Total revenue per movie category.
SELECT category.name AS category, SUM(payment.amount) AS revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY revenue DESC;
