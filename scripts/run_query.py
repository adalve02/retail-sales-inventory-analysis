import sys
import sqlite3
import pandas as pd

if len(sys.argv) < 2:
    print("Please give a SQL file, e.g.: python scripts/run_query.py sql/01_data_check.sql")
    sys.exit()

query = open(sys.argv[1], encoding="utf-8").read()
conn = sqlite3.connect("data/retail.db")

# SELECT queries print results; other commands (CREATE, DROP) just run
if query.strip().upper().startswith(("SELECT", "WITH", "--")) and "CREATE" not in query.upper():
    result = pd.read_sql_query(query, conn)
    pd.set_option("display.max_columns", None)
    pd.set_option("display.width", 200)
    print(result)
else:
    conn.executescript(query)
    conn.commit()
    print("Done.")

conn.close()