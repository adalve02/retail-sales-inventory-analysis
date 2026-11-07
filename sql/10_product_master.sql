-- One clean record per product: standard code (uppercase) + most-used description
DROP TABLE IF EXISTS product_master;

CREATE TABLE product_master AS
WITH descriptions AS (
    SELECT
        UPPER(TRIM(stockcode))   AS stockcode,
        TRIM(description)        AS description,
        COUNT(*)                 AS times_used
    FROM sales_clean
    GROUP BY UPPER(TRIM(stockcode)), TRIM(description)
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY stockcode ORDER BY times_used DESC) AS rn
    FROM descriptions
)
SELECT stockcode, description
FROM ranked
WHERE rn = 1;