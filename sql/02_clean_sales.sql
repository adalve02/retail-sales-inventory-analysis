-- Build a clean sales table: real sales only, with revenue calculated
DROP TABLE IF EXISTS sales_clean;

CREATE TABLE sales_clean AS
SELECT
    invoice,
    stockcode,
    description,
    quantity,
    price,
    ROUND(quantity * price, 2)        AS revenue,
    invoicedate,
    strftime('%Y-%m', invoicedate)    AS year_month,
    customer_id,
    country
FROM sales
WHERE invoice NOT LIKE 'C%'     -- remove cancellations
  AND quantity > 0              -- remove returns and stock adjustments
  AND price > 0;                -- remove free items and adjustments