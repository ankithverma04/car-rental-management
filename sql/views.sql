-- ==========================================
--   VIEWS FOR CAR RENTAL MANAGEMENT SYSTEM
-- ==========================================

PRAGMA foreign_keys = ON;

-- ==========================================
-- VIEW 1: Rental Details (Full Joined Report)
-- Shows complete information about every rental,
-- including customer and car details.
-- ==========================================
CREATE VIEW IF NOT EXISTS rental_details AS
SELECT 
    r.rental_id,
    c.full_name AS customer_name,
    c.email AS customer_email,
    car.brand || ' ' || car.model AS car_name,
    r.start_date,
    r.end_date,
    r.total_cost
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN cars car ON r.car_id = car.car_id
ORDER BY r.rental_id;


-- ==========================================
-- VIEW 2: Active Rentals (Current Ongoing Rentals)
-- Shows rentals where today's date is between start and end date.
-- ==========================================
CREATE VIEW IF NOT EXISTS active_rentals AS
SELECT
    r.rental_id,
    c.full_name AS customer_name,
    car.brand || ' ' || car.model AS car_name,
    r.start_date,
    r.end_date
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN cars car ON r.car_id = car.car_id
WHERE DATE('now') BETWEEN r.start_date AND r.end_date
ORDER BY r.end_date;


-- ==========================================
-- VIEW 3: Available Cars
-- Quick view to see cars ready for rental.
-- ==========================================
CREATE VIEW IF NOT EXISTS available_cars AS
SELECT 
    car_id,
    brand,
    model,
    daily_rate
FROM cars
WHERE status = 'available'
ORDER BY brand, model;


-- ==========================================
-- VIEW 4: Cars Under Maintenance
-- Helps track repair work and downtime.
-- ==========================================
CREATE VIEW IF NOT EXISTS maintenance_cars AS
SELECT 
    car_id,
    brand,
    model,
    status
FROM cars
WHERE status = 'maintenance';


-- ==========================================
-- VIEW 5: Customer Rental Count
-- Analytics view showing how many rentals each customer has made.
-- ==========================================
CREATE VIEW IF NOT EXISTS customer_rental_stats AS
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(r.rental_id) AS total_rentals,
    SUM(r.total_cost) AS total_spent
FROM customers c
LEFT JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_rentals DESC;


-- ==========================================
-- VIEW 6: Car Rental Frequency
-- Shows how many times each car was rented.
-- ==========================================
CREATE VIEW IF NOT EXISTS car_rental_frequency AS
SELECT 
    car.car_id,
    car.brand,
    car.model,
    COUNT(r.rental_id) AS times_rented
FROM cars car
LEFT JOIN rentals r ON car.car_id = r.car_id
GROUP BY car.car_id
ORDER BY times_rented DESC;


-- END OF FILE
