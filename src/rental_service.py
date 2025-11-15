# rental_service.py

from db import fetch_all, fetch_one, execute_query
from car_service import update_car_status, show_available_cars
from customer_service import find_customer_by_id


def rent_car():
    """Rent a car to a customer."""
    print("\n--- Rent a Car ---")

    # Show available cars first
    show_available_cars()

    car_id = input("Enter Car ID to rent: ")
    customer_id = input("Enter Customer ID: ")

    # Validate customer
    customer = find_customer_by_id(customer_id)
    if not customer:
        print("✖ Customer not found.")
        return

    # Validate car
    car = fetch_one("SELECT * FROM cars WHERE car_id = ?;", (car_id,))
    if not car:
        print("✖ Car not found.")
        return

    if car["status"] != "available":
        print(f"✖ Car is not available (Current status: {car['status']})")
        return

    start = input("Enter start date (YYYY-MM-DD): ")
    end = input("Enter end date (YYYY-MM-DD): ")

    # Calculate days
    query_days = fetch_one(
        "SELECT julianday(?) - julianday(?) AS days;",
        (end, start)
    )

    if not query_days or query_days["days"] <= 0:
        print("✖ Invalid date range.")
        return

    days = int(query_days["days"])
    total_cost = days * car["daily_rate"]

    # Insert rental
    execute_query("""
        INSERT INTO rentals (customer_id, car_id, start_date, end_date, total_cost)
        VALUES (?, ?, ?, ?, ?);
    """, (customer_id, car_id, start, end, total_cost))

    update_car_status(car_id, "rented")

    print(f"✔ Car rented successfully for {days} days. Total cost: ₹{total_cost}")


def return_car():
    """Return a rented car."""
    print("\n--- Return a Car ---")

    # Show currently rented cars
    rented = fetch_all("""
        SELECT r.rental_id, c.full_name, car.brand, car.model, r.car_id
        FROM rentals r
        JOIN customers c ON r.customer_id = c.customer_id
        JOIN cars car ON r.car_id = car.car_id
        WHERE car.status = 'rented';
    """)

    if not rented:
        print("No cars are currently rented out.")
        return

    print("\n--- Cars Currently Rented ---")
    for r in rented:
        print(f"Rental ID: {r['rental_id']} | {r['brand']} {r['model']} | Customer: {r['full_name']}")

    rental_id = input("\nEnter Rental ID to return: ")

    rental = fetch_one("SELECT * FROM rentals WHERE rental_id = ?;", (rental_id,))
    if not rental:
        print("✖ Rental ID not found.")
        return

    car_id = rental["car_id"]

    update_car_status(car_id, "available")

    print("✔ Car returned successfully!")


def rental_history():
    """Display all rentals with details."""
    print("\n--- Rental History ---")

    rows = fetch_all("""
        SELECT r.rental_id, c.full_name, car.brand, car.model,
               r.start_date, r.end_date, r.total_cost
        FROM rentals r
        JOIN customers c ON r.customer_id = c.customer_id
        JOIN cars car ON r.car_id = car.car_id
        ORDER BY r.rental_id;
    """)

    if not rows:
        print("No rental history found.")
        return

    for r in rows:
        print(f"""
Rental ID: {r['rental_id']}
Customer: {r['full_name']}
Car: {r['brand']} {r['model']}
From: {r['start_date']}   To: {r['end_date']}
Total Cost: ₹{r['total_cost']}
-----------------------------------------
        """)
