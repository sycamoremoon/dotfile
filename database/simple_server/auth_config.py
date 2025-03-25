import json
import os
import hashlib
import secrets
from getpass import getpass

CONFIG_FILE = "users.json"

def load_users():
    """Load user data from the configuration file."""
    if not os.path.exists(CONFIG_FILE):
        return {}
    
    with open(CONFIG_FILE, 'r') as f:
        try:
            return json.load(f)
        except json.JSONDecodeError:
            return {}

def save_users(users):
    """Save user data to a file."""
    with open(CONFIG_FILE, 'w') as f:
        json.dump(users, f, indent=2)

def add_user_interactive():
    """Add a user interactively."""
    # Enter username
    while True:
        username = input("Enter username: ").strip()
        if not username:
            print("Username cannot be empty")
            continue
        if username in load_users():
            print("Username already exists")
            continue
        break
    
    # Enter and confirm password
    while True:
        pwd = getpass("Enter password: ")
        if not pwd:
            print("Password cannot be empty")
            continue
        confirm_pwd = getpass("Re-enter password: ")
        if pwd != confirm_pwd:
            print("Passwords do not match")
            continue
        break
    
    # Generate credentials
    salt = secrets.token_hex(16)
    hashed_pw = hashlib.sha256(f"{salt}{pwd}".encode()).hexdigest()
    
    # Save to file
    users = load_users()
    users[username] = {
        "salt": salt,
        "hash": hashed_pw
    }
    save_users(users)
    print(f"User {username} added successfully")

if __name__ == "__main__":
    add_user_interactive()
