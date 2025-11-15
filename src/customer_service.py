# customer_service.py
from db import fetch_all, fetch_one, execute_query

def add_customer():
    """Add a new customer to the database."""
    name = input("Enter full name: ")
    email = input("Enter email: ")
    phone = input("Enter phone number: ")

    # Check if email already exists
    existing = fetch_all("SELECT customer_id FROM customers WHERE email = ?", (email,))
    if existing:
        print("✖ A customer with this email already exists.")
        return

    execute_query("""
        INSERT INTO customers (full_name, email, phone)
        VALUES (?, ?, ?);
    """, (name, email, phone))

    print("✔ Customer added successfully!")


def view_customers():
    """Display all customers."""
    rows = fetch_all("""
        SELECT customer_id, full_name, email, phone
        FROM customers
        ORDER BY customer_id;
    """)

    print("\n--- Customer List ---")
    if not rows:
        print("No customers found.")
        return

    for c in rows:
        print(f"{c['customer_id']} | {c['full_name']} | {c['email']} | {c['phone']}")
    print("-------------------------")


def find_customer_by_id(customer_id):
    """Return customer details for the given ID."""
    row = fetch_one("""
        SELECT customer_id, full_name, email, phone
        FROM customers
        WHERE customer_id = ?;
    """, (customer_id,))
    return row  # either dict or None


def search_customer():
    """Search customer by name or email."""
    keyword = input("Enter name or email to search: ")

    rows = fetch_all("""
        SELECT customer_id, full_name, email, phone
        FROM customers
        WHERE full_name LIKE ? OR email LIKE ?;
    """, (f"%{keyword}%", f"%{keyword}%"))

    print("\n--- Search Results ---")
    if not rows:
        print("No matching customers.")
        return

    for c in rows:
        print(f"{c['customer_id']} | {c['full_name']} | {c['email']} | {c['phone']}")
    print("-------------------------")


def delete_customer():
    """Delete a customer by ID."""
    customer_id = input("Enter customer ID to delete: ")

    execute_query("""
        DELETE FROM customers
        WHERE customer_id = ?;
    """, (customer_id,))

    print("✔ Customer deleted successfully!")
