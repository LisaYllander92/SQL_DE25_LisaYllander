import pandas as pd
import duckdb

"""convinience function to open a duckdb database connection and query it"""


def query_database(
    query: str, db_path: str = "data/lecture_13_15.duckdb"
) -> pd.DataFrame:
    with duckdb.connect(db_path) as conn:
        return conn.execute(query=query).df()


query_database("FROM staging.students;")