# Car Rental CLI System - Sample Run Output

Below is a recorded demonstration of the Car Rental Management System (CLI) working end‑to‑end.

---

## 🟦 Application Start

```
=========================================
     CAR RENTAL MANAGEMENT SYSTEM (CLI)
=========================================
```

---

## 🟦 Main Menu

```
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
```

---

## 🟩 Viewing All Cars

```
1 | Toyota Innova | ₹2500.0 per day | Status: available
2 | Hyundai Creta | ₹2200.0 per day | Status: available
3 | Maruti Baleno | ₹1500.0 per day | Status: available
4 | Tata Nexon | ₹1800.0 per day | Status: maintenance
5 | Honda City | ₹2400.0 per day | Status: available
6 | Mahindra XUV500 | ₹3000.0 per day | Status: available
7 | BMW m3 | ₹5000.0 per day | Status: available
```

---

## 🟩 Adding a Car

```
Enter car brand: Mahindra
Enter car model: Bolero
Enter daily rental rate: 2500
✔ Car added successfully!
```

---

## 🟩 Adding a Customer

```
Enter full name: Anushka Verma
Enter email: anushka@yahoo.com
Enter phone number: 8976895432
✔ Customer added successfully!
```

---

## 🟩 Viewing Customers

```
1 | Ankit Verma | ankit.verma@example.com | 9876543210
2 | Riya Sharma | riya.sharma@example.com | 9123456780
4 | Sneha Mehta | sneha.mehta@example.com | 9090909090
5 | Rahul Singh | rahul.singh@example.com | 9000011111
6 | Anitha Thakur | anitha@gmail.com | 9876543231
7 | Anushka Verma | anushka@yahoo.com | 8976895432
```

---

## 🟩 Searching a Customer

```
Enter name or email to search: anushka
7 | Anushka Verma | anushka@yahoo.com | 8976895432
```

---

## 🟩 Deleting a Customer

```
Enter customer ID to delete: 2
✔ Customer deleted successfully!
```

---

## 🟩 Renting a Car

```
--- Available Cars ---
1 | Toyota Innova | ₹2500
2 | Hyundai Creta | ₹2200
3 | Maruti Baleno | ₹1500
5 | Honda City | ₹2400
6 | Mahindra XUV500 | ₹3000
7 | BMW m3 | ₹5000
8 | Mahindra Bolero | ₹2500

Enter Car ID to rent: 7
Enter Customer ID: 7
Enter start date: 2024-09-11
Enter end date: 2024-09-13

✔ Car rented successfully for 2 days. Total cost: ₹10000
```

---

## 🟩 Returning a Car

```
--- Cars Currently Rented ---
Rental ID: 5 | BMW m3 | Customer: Anitha Thakur
Rental ID: 6 | BMW m3 | Customer: Anushka Verma

Enter Rental ID to return: 5
✔ Car returned successfully!
```

---

## 🟩 Rental History

```
Rental ID: 1 — Ankit Verma — Toyota Innova — ₹7500  
Rental ID: 3 — Sneha Mehta — Hyundai Creta — ₹6600  
Rental ID: 4 — Ankit Verma — Toyota Innova — ₹7500  
Rental ID: 5 — Anitha Thakur — BMW m3 — ₹5000  
Rental ID: 6 — Anushka Verma — BMW m3 — ₹10000  
```

---

## 🟦 Exit

```
Exiting... Goodbye!
```

---
