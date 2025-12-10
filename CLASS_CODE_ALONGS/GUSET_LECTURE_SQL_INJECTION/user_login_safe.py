import duckdb
from constants import DB_PATH

username = input("Enter username: ")
password = input("Enter password: ")

with duckdb.connect(str(DB_PATH)) as conn:
    result = conn.execute(f"SELECT * FROM users WHERE username = ? AND password = ?, parameters=(username, password)")
    

if result.fetchall():
    print("You can eat all the ice cream you want")
else:
    print("Sorry dude")