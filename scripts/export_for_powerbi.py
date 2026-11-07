import sqlite3
import pandas as pd
import os

os.makedirs("data/exports", exist_ok=True)
conn = sqlite3.connect("data/retail.db")

# Clean sales with the standard product code
sales = pd.read_sql_query("""
    SELECT s.invoice, UPPER(TRIM(s.stockcode)) AS stockcode, s.quantity, s.price,
           s.revenue, s.invoicedate, s.year_month, s.customer_id, s.country
    FROM sales_clean s
""", conn)
sales.to_csv("data/exports/sales.csv", index=False)

# Product master
products = pd.read_sql_query("SELECT * FROM product_master", conn)
products.to_csv("data/exports/products.csv", index=False)

conn.close()
print("Exported:", len(sales), "sales rows and", len(products), "products")