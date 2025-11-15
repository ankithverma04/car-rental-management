# validators.py

import re
from datetime import datetime


def is_valid_email(email: str) -> bool:
    """Validate email format."""
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(pattern, email) is not None


def is_valid_phone(phone: str) -> bool:
    """Validate phone number (10 digits)."""
    return phone.isdigit() and len(phone) == 10


def is_valid_date(date_str: str) -> bool:
    """Check if date is in YYYY-MM-DD format."""
    try:
        datetime.strptime(date_str, "%Y-%m-%d")
        return True
    except ValueError:
        return False


def is_positive_number(value: str) -> bool:
    """Check if value is a positive integer or float."""
    try:
        return float(value) > 0
    except ValueError:
        return False


def not_empty(value: str) -> bool:
    """Check if input is not empty."""
    return bool(value and value.strip())
