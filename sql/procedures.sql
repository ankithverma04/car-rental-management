-- ==========================================
--   PROCEDURE-LIKE SQL LOGIC (SQLite)
--   SQLite does not support stored procedures,
--   so this file demonstrates equivalent logic
--   using transactions, CTEs, and reusable statements.
-- ==========================================

PRAGMA foreign_keys = ON;


-- ==========================================
-- PROCEDURE: Calculate Rental Cost
-- INPUT: :start_date, :end_date, :daily_rate
-- OUTPUT: days, total_cost
-- ==========================================
-- Usage in Python:
-- SELECT * FROM calc_rental_cost('2024-05-01','2024-05-05',2500);
-- (Handled with a CTE)

WITH calc AS (
    SELECT
        julianday(:end_date) - julianday(:start_date) AS days,
        (julianday(:end_date) - julianday(:start_date)) * :daily_rate AS total_cost
)
SELECT * FROM calc;


-- ==========================================
-- PROCEDURE: Rent a Car (transaction block)
-- Steps:
-- 1. Check availability
-- 2. Insert rental
-- 3. Update car status
-- ==========================================
-- Example usage in Python:
-- BEGIN;
--   INSERT INTO rentals (...);
--   UPDATE cars SET status = 'rented' WHERE car_id = ?;
-- COMMIT;

-- Template for rental transaction:
-- (Kept for documentation in GitHub)

-- BEGIN TRANSACTION;
--   INSERT INTO rentals (customer_id, car_id, start_date, end_date, total_cost)
--   VALUES (:customer_id, :car_id, :start, :end, :cost);
--
--   UPDATE cars
--   SET status = 'rented'
--   WHERE car_id = :car_id;
-- COMMIT;


-- ==========================================
-- PROCEDURE: Return a Car
-- Steps:
-- 1. Mark the car as available again
-- ==========================================
-- Template usage:
--
-- UPDATE cars
-- SET status = 'available'
-- WHERE car_id = :car_id;
--


-- ==========================================
-- PROCEDURE: Get Full Rental Details
-- (Equivalent to a stored procedure in MySQL)
-- ==========================================
CREATE VIEW IF NOT EXISTS rental_details AS
SELECT 
    r.rental_id,
    c.full_name AS customer_name,
    car.brand || ' ' || car.model AS car_name,
    r.start_date,
    r.end_date,
    r.total_cost
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN cars car ON r.car_id = car.car_id;


-- ==========================================
-- PROCEDURE: Monthly Revenue Report
-- ==========================================
-- Equivalent query:
-- SELECT * FROM monthly_revenue;

CREATE VIEW IF NOT EXISTS monthly_revenue AS
SELECT 
    substr(payment_date, 1, 7) AS month,     -- YYYY-MM
    SUM(amount) AS total_revenue
FROM payments
GROUP BY month
ORDER BY month;


-- END OF FILE
