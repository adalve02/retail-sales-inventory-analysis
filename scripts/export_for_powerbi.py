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
products = pd.read_sql_query("""
    WITH product_sales AS (
        SELECT pm.stockcode, pm.description, SUM(s.revenue) AS revenue
        FROM product_master pm
        JOIN sales_clean s ON pm.stockcode = UPPER(TRIM(s.stockcode))
        GROUP BY pm.stockcode, pm.description
    ),
    ranked AS (
        SELECT *,
            SUM(revenue) OVER (ORDER BY revenue DESC) * 1.0
              / SUM(revenue) OVER () AS cumulative_share
        FROM product_sales
    )
    SELECT stockcode, description,
        CASE WHEN cumulative_share <= 0.80 THEN 'A'
             WHEN cumulative_share <= 0.95 THEN 'B'
             ELSE 'C' END AS abc_class
    FROM ranked
""", conn)
products.to_csv("data/exports/products.csv", index=False)

conn.close()
print("Exported:", len(sales), "sales rows and", len(products), "products")