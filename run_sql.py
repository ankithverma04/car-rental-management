import sqlite3

db = "car_rental.db"

sql_files = [
    "sql/create_tables.sql",
    "sql/insert_sample_data.sql",
    "sql/views.sql",
    "sql/triggers.sql"
]

conn = sqlite3.connect(db)
cursor = conn.cursor()

for file in sql_files:
    print(f"Running: {file}")
    with open(file, "r") as f:
        cursor.executescript(f.read())

conn.commit()
conn.close()

print("✔ Database initialized successfully!")
