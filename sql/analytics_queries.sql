-- ==========================================
--  ADVANCED ANALYTICS & REPORTING QUERIES
-- ==========================================

PRAGMA foreign_keys = ON;

-- ------------------------------------------
-- 1. Monthly Revenue Report
-- ------------------------------------------
-- Shows total money earned per month (YYYY-MM).

SELECT 
    substr(payment_date, 1, 7) AS month,
    SUM(amount) AS total_revenue
FROM payments
GROUP BY month
ORDER BY month DESC;


-- ------------------------------------------
-- 2. Most Rented Cars
-- ------------------------------------------
-- Shows which cars are the most popular.

SELECT 
    car.brand,
    car.model,
    COUNT(r.rental_id) AS times_rented
FROM cars car
LEFT JOIN rentals r ON car.car_id = r.car_id
GROUP BY car.car_id
ORDER BY times_rented DESC;


-- ------------------------------------------
-- 3. Top Spending Customers
-- ------------------------------------------
-- Shows customers who spent the most on rentals.

SELECT
    c.full_name,
    COUNT(r.rental_id) AS rentals_taken,
    SUM(r.total_cost) AS total_spent
FROM customers c
LEFT JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;


-- ------------------------------------------
-- 4. Cars Currently Rented
-- ------------------------------------------
-- Shows active rentals with car & customer names.

SELECT
    r.rental_id,
    c.full_name,
    car.brand || ' ' || car.model AS car_name,
    r.start_date,
    r.end_date
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN cars car ON r.car_id = car.car_id
WHERE DATE('now') BETWEEN r.start_date AND r.end_date;


-- ------------------------------------------
-- 5. Cars Not Rented in Last 60 Days
-- ------------------------------------------
-- Helps identify low-performing vehicles.

SELECT 
    car.car_id,
    car.brand,
    car.model
FROM cars car
WHERE car.car_id NOT IN (
    SELECT car_id FROM rentals
    WHERE (julianday('now') - julianday(end_date)) <= 60
);


-- ------------------------------------------
-- 6. Customer Rental Frequency Pattern
-- ------------------------------------------
-- Helps understand customer engagement.

SELECT 
    c.full_name,
    COUNT(r.rental_id) AS rental_count,
    MIN(r.start_date) AS first_rental,
    MAX(r.end_date) AS last_rental
FROM customers c
LEFT JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY rental_count DESC;


-- ------------------------------------------
-- 7. Daily Rental Count Trend
-- ------------------------------------------
-- Shows how many rentals occurred per day.

SELECT
    start_date AS rental_date,
    COUNT(*) AS rentals_started
FROM rentals
GROUP BY start_date
ORDER BY rental_date DESC;


-- ------------------------------------------
-- 8. Revenue Breakdown By Car Model
-- ------------------------------------------

SELECT
    car.brand,
    car.model,
    SUM(r.total_cost) AS model_revenue
FROM rentals r
JOIN cars car ON r.car_id = car.car_id
GROUP BY car.brand, car.model
ORDER BY model_revenue DESC;


-- END OF FILE
