-- ==========================================
--   SAMPLE DATA FOR CAR RENTAL MANAGEMENT
-- ==========================================

PRAGMA foreign_keys = ON;

-- ----------------------
-- INSERT CUSTOMERS
-- ----------------------
INSERT INTO customers (full_name, email, phone) VALUES
('Ankit Verma', 'ankit.verma@example.com', '9876543210'),
('Riya Sharma', 'riya.sharma@example.com', '9123456780'),
('Karan Patel', 'karan.patel@example.com', '9988776655'),
('Sneha Mehta', 'sneha.mehta@example.com', '9090909090'),
('Rahul Singh', 'rahul.singh@example.com', '9000011111');

-- ----------------------
-- INSERT CARS
-- ----------------------
INSERT INTO cars (brand, model, daily_rate, status) VALUES
('Toyota', 'Innova', 2500, 'available'),
('Hyundai', 'Creta', 2200, 'available'),
('Maruti', 'Baleno', 1500, 'available'),
('Tata', 'Nexon', 1800, 'maintenance'),
('Honda', 'City', 2400, 'available'),
('Mahindra', 'XUV500', 3000, 'available');

-- ----------------------
-- INSERT RENTALS
-- (Some past rentals for history display)
-- ----------------------
INSERT INTO rentals (customer_id, car_id, start_date, end_date, total_cost) VALUES
(1, 1, '2024-01-05', '2024-01-08', 7500),   -- 3 days * 2500
(2, 3, '2024-02-10', '2024-02-12', 3000),   -- 2 days * 1500
(4, 2, '2024-03-01', '2024-03-04', 6600);   -- 3 days * 2200

-- ----------------------
-- INSERT PAYMENTS (Optional)
-- ----------------------
INSERT INTO payments (rental_id, amount, payment_date, method) VALUES
(1, 7500, '2024-01-08', 'UPI'),
(2, 3000, '2024-02-12', 'Card'),
(3, 6600, '2024-03-04', 'Cash');

-- ----------------------
-- INSERT MAINTENANCE RECORDS (Optional)
-- ----------------------
INSERT INTO car_maintenance (car_id, description, cost, maintenance_date) VALUES
(4, 'Full service – engine oil, brakes', 3500, '2024-01-15'),
(4, 'Tyre replacement', 6000, '2024-03-01');

-- END OF FILE
