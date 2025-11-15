# car_service.py
from db import fetch_all, execute_query

def view_cars():
    """Display all cars in the system."""
    rows = fetch_all("""
        SELECT car_id, brand, model, daily_rate, status
        FROM cars
        ORDER BY car_id;
    """)

    print("\n--- Car Inventory ---")
    for car in rows:
        print(f"{car[0]} | {car[1]} {car[2]} | ₹{car[3]} per day | Status: {car[4]}")
    print("-------------------------")


def add_car():
    """Add a new car to the database."""
    brand = input("Enter car brand: ")
    model = input("Enter car model: ")
    rate = input("Enter daily rental rate: ")

    execute_query("""
        INSERT INTO cars (brand, model, daily_rate, status)
        VALUES (?, ?, ?, 'available');
    """, (brand, model, rate))

    print("✔ Car added successfully!")


def update_car_status(car_id, new_status):
    """Update the status of a specific car."""
    allowed = ["available", "rented", "maintenance"]
    if new_status not in allowed:
        print("✖ Invalid status. Allowed:", allowed)
        return

    execute_query("""
        UPDATE cars
        SET status = ?
        WHERE car_id = ?;
    """, (new_status, car_id))

    print(f"✔ Car {car_id} status updated to {new_status}")


def get_available_cars():
    """Return only the cars that are available."""
    return fetch_all("""
        SELECT car_id, brand, model, daily_rate
        FROM cars
        WHERE status = 'available';
    """)


def show_available_cars():
    """Print only available cars."""
    rows = get_available_cars()

    print("\n--- Available Cars ---")
    if not rows:
        print("No cars available right now.")
        return

    for car in rows:
        print(f"{car[0]} | {car[1]} {car[2]} | ₹{car[3]} per day")
    print("--------------------------")
