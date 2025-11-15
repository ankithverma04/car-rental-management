# db.py
import sqlite3

DB_NAME = "car_rental.db"


def get_connection():
    """Create and return a connection to the SQLite database."""
    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row  # Access columns by name
    return conn


def execute_query(query, params=()):
    """Execute INSERT, UPDATE, DELETE statements."""
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute(query, params)
        conn.commit()
    except Exception as e:
        print("✖ Database Error:", e)
    finally:
        conn.close()


def fetch_all(query, params=()):
    """Fetch multiple rows from the database."""
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute(query, params)
        rows = cur.fetchall()
        return [dict(row) for row in rows]  # return as list of dicts
    except Exception as e:
        print("✖ Database Error:", e)
        return []
    finally:
        conn.close()


def fetch_one(query, params=()):
    """Fetch a single row from the database."""
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute(query, params)
        row = cur.fetchone()
        return dict(row) if row else None
    except Exception as e:
        print("✖ Database Error:", e)
        return None
    finally:
        conn.close()
