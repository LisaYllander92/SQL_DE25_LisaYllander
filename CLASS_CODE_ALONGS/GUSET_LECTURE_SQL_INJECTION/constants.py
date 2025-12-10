""" What pathlib does """

from pathlib import Path # makes it able to run the file wherever  your location is

SQL_PATH = Path(__file__).parent / "sql"
# .parent goes up to the main(parent) file
DB_PATH = Path(__file__).parent / "glassiker.duckdb"

#print("---"*20)
#print(SQL_PATH)
#print("---"*20)

#with open("sql/create_user.sql") as file:
    #print(file.read()) # can only be run when im in the right location in the terminal