-- ==========================================
--   TRIGGERS FOR CAR RENTAL MANAGEMENT
-- ==========================================

PRAGMA foreign_keys = ON;

-- ==========================================
-- TRIGGER 1: Prevent Double Booking
-- ==========================================
-- If someone tries to book a car during dates that overlap
-- with an existing rental, this trigger will block the insert.

CREATE TRIGGER IF NOT EXISTS prevent_double_booking
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    SELECT 
        CASE
            WHEN EXISTS (
                SELECT 1 FROM rentals
                WHERE car_id = NEW.car_id
                AND (
                    (NEW.start_date BETWEEN start_date AND end_date)
                    OR
                    (NEW.end_date BETWEEN start_date AND end_date)
                    OR
                    (start_date BETWEEN NEW.start_date AND NEW.end_date)
                )
            )
            THEN RAISE(ABORT, 'Car is already booked for these dates')
        END;
END;


-- ==========================================
-- TRIGGER 2: Auto-update Car Status to "rented"
-- ==========================================
-- Whenever a rental is inserted, immediately set the car to rented.

CREATE TRIGGER IF NOT EXISTS set_car_rented
AFTER INSERT ON rentals
FOR EACH ROW
BEGIN
    UPDATE cars
    SET status = 'rented'
    WHERE car_id = NEW.car_id;
END;


-- ==========================================
-- TRIGGER 3: Auto-update Car Status to "available" on Delete
-- ==========================================
-- When a rental record is deleted (car returned), mark car available.

CREATE TRIGGER IF NOT EXISTS set_car_available
AFTER DELETE ON rentals
FOR EACH ROW
BEGIN
    UPDATE cars
    SET status = 'available'
    WHERE car_id = OLD.car_id;
END;


-- ==========================================
-- TRIGGER 4: Validate Daily Rate Must Be Positive
-- ==========================================
-- No car can be added/updated with a negative or zero rental rate.

CREATE TRIGGER IF NOT EXISTS validate_daily_rate
BEFORE INSERT ON cars
FOR EACH ROW
BEGIN
    SELECT 
        CASE 
            WHEN NEW.daily_rate <= 0
            THEN RAISE(ABORT, 'Daily rate must be a positive value')
        END;
END;


-- ==========================================
-- TRIGGER 5: Prevent Maintenance Car from Being Rented
-- ==========================================
-- Ensures cars under maintenance cannot be assigned to rentals.

CREATE TRIGGER IF NOT EXISTS prevent_maintenance_rental
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    SELECT 
        CASE 
            WHEN (SELECT status FROM cars WHERE car_id = NEW.car_id) = 'maintenance'
            THEN RAISE(ABORT, 'Car is under maintenance and cannot be rented')
        END;
END;


-- END OF FILE
