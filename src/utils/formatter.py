# formatter.py

def print_header(title: str):
    """Print a formatted section header."""
    print("\n" + "=" * 45)
    print(title.upper())
    print("=" * 45)


def print_table(rows, headers):
    """Pretty-print rows in a table format."""
    if not rows:
        print("No data found.")
        return

    # Determine column widths
    col_widths = [len(h) for h in headers]

    for row in rows:
        for i, key in enumerate(headers):
            col_widths[i] = max(col_widths[i], len(str(row.get(key, ""))))

    # Print header row
    header_line = " | ".join(h.ljust(col_widths[i]) for i, h in enumerate(headers))
    print(header_line)
    print("-" * len(header_line))

    # Print data rows
    for row in rows:
        line = " | ".join(str(row.get(h, "")).ljust(col_widths[i]) for i, h in enumerate(headers))
        print(line)


def success(msg: str):
    """Display a success message."""
    print(f"✔ {msg}")


def error(msg: str):
    """Display an error message."""
    print(f"✖ {msg}")


def separator():
    """Print a visual separator line."""
    print("-" * 45)
