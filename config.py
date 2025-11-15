# config.py
"""
Global configuration settings for the Car Rental CLI System.
Modify values here to update the application's behavior.
"""

# ---------------------------
# DATABASE SETTINGS
# ---------------------------

# SQLite database file name
DATABASE_NAME = "car_rental.db"


# ---------------------------
# APPLICATION SETTINGS
# ---------------------------

# Minimum daily rental rate (for validation)
MIN_RATE = 100

# Enable/Disable debug messages
DEBUG = False


# ---------------------------
# UI SETTINGS
# ---------------------------

# Text header displayed at startup
APP_TITLE = """
=========================================
     CAR RENTAL MANAGEMENT SYSTEM (CLI)
=========================================
"""

# Separator line used across app
SEPARATOR = "-" * 45


# ---------------------------
# HELPER FUNCTIONS
# ---------------------------

def debug_print(msg):
    """Print debug messages only if DEBUG is True."""
    if DEBUG:
        print(f"[DEBUG] {msg}")
