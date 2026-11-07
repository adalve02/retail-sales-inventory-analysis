import pandas as pd
import sqlite3

# Read both yearly sheets from the Excel file
print("Reading Excel file... (this takes 1-2 minutes)")
sheets = pd.read_excel("data/online_retail_II.xlsx", sheet_name=None)
df = pd.concat(sheets.values(), ignore_index=True)

# Clean column names, e.g. "Customer ID" -> "customer_id"
df.columns = [c.strip().lower().replace(" ", "_") for c in df.columns]

print("Rows loaded:", len(df))
print("Columns:", list(df.columns))
print(df.head())

# Save into a SQLite database
conn = sqlite3.connect("data/retail.db")
df.to_sql("sales", conn, if_exists="replace", index=False)
conn.close()
print("Done! Saved to data/retail.db")