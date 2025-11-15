# menu.py

from car_service import view_cars, add_car, show_available_cars
from customer_service import add_customer, view_customers, search_customer, delete_customer
from rental_service import rent_car, return_car, rental_history


def main_menu():
    while True:
        print("""
=========================================
        CAR RENTAL MANAGEMENT - MENU
=========================================
1. View All Cars
2. View Available Cars
3. Add Car

4. Add Customer
5. View Customers
6. Search Customer
7. Delete Customer

8. Rent a Car
9. Return a Car
10. View Rental History

0. Exit
=========================================
""")

        choice = input("Enter your choice: ")

        if choice == "1":
            view_cars()

        elif choice == "2":
            show_available_cars()

        elif choice == "3":
            add_car()

        elif choice == "4":
            add_customer()

        elif choice == "5":
            view_customers()

        elif choice == "6":
            search_customer()

        elif choice == "7":
            delete_customer()

        elif choice == "8":
            rent_car()

        elif choice == "9":
            return_car()

        elif choice == "10":
            rental_history()

        elif choice == "0":
            print("Exiting... Goodbye!")
            break

        else:
            print("Invalid choice. Please try again.")
