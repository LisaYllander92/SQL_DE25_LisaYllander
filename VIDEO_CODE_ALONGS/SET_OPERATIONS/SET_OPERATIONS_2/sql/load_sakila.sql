install sqlite;

load sqlite;

call sqlite_attach(
    'data/sqlite-sakila.db'
);