-- ==========================================
--   CAR RENTAL MANAGEMENT SYSTEM - SCHEMA
-- ==========================================

PRAGMA foreign_keys = ON;

-- ----------------------
-- TABLE: customers
-- ----------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   TEXT NOT NULL,
    email       TEXT UNIQUE NOT NULL,
    phone       TEXT NOT NULL
);

-- ----------------------
-- TABLE: cars
-- ----------------------
CREATE TABLE IF NOT EXISTS cars (
    car_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    brand       TEXT NOT NULL,
    model       TEXT NOT NULL,
    daily_rate  REAL NOT NULL,
    status      TEXT CHECK(status IN ('available','rented','maintenance'))
                DEFAULT 'available'
);

-- ----------------------
-- TABLE: rentals
-- ----------------------
CREATE TABLE IF NOT EXISTS rentals (
    rental_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    car_id      INTEGER NOT NULL,
    start_date  TEXT NOT NULL,
    end_date    TEXT NOT NULL,
    total_cost  REAL NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (car_id)      REFERENCES cars(car_id)        ON DELETE CASCADE
);

-- ----------------------
-- TABLE: payments (optional for future)
-- ----------------------
CREATE TABLE IF NOT EXISTS payments (
    payment_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    rental_id   INTEGER NOT NULL,
    amount      REAL NOT NULL,
    payment_date TEXT NOT NULL,
    method      TEXT CHECK(method IN ('UPI','Card','Cash')) NOT NULL,

    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id) ON DELETE CASCADE
);

-- ----------------------
-- TABLE: car_maintenance (optional)
-- ----------------------
CREATE TABLE IF NOT EXISTS car_maintenance (
    maintenance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    car_id         INTEGER NOT NULL,
    description    TEXT NOT NULL,
    cost           REAL NOT NULL,
    maintenance_date TEXT NOT NULL,

    FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE CASCADE
);

-- END OF FILE
