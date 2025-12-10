from constants import DB_PATH, SQL_PATH
import duckdb

# connects to glassiker.duckdb and puts in data from our sql file
with duckdb.connect(str(DB_PATH)) as conn, open(SQL_PATH / "create_users.sql") as sql_script:
    sql_code = sql_script.read()
    conn.execute(sql_code)