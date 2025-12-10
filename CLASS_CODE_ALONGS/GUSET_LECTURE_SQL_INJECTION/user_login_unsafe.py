import duckdb
from constants import DB_PATH

username = input("Enter username: ")
password = input("Enter password: ")

with duckdb.connect(str(DB_PATH)) as conn:
    result = conn.execute(f"""SELECT * FROM users WHERE username = '{username}' AND password = '{password}'
    """)
    # if the password is correct 
    # we will get back a record in the list -> truthy

    # if password is wrong -> empty list -> falsey
    
    if result.fetchall():
        print("You can eat all ice creams you want")
    else:
        print("Sorry dude")

    # a ' OR '1'='1' --
    # WORKS: username: ' OR '1'='1' --, password: vadsomhelst

    # WHERE username = 'a ' OR '1'='1' -- AND password = ...
    # False or True -> True

    # ';DROP TABLE users;--