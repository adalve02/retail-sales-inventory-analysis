-- ABC analysis using the clean product master
WITH product_sales AS (
    SELECT
        pm.stockcode,
        pm.description,
        SUM(s.revenue) AS revenue
    FROM sales_clean s
    JOIN product_master pm
      ON pm.stockcode = UPPER(TRIM(s.stockcode))
    GROUP BY pm.stockcode, pm.description
),
ranked AS (
    SELECT *,
        SUM(revenue) OVER (ORDER BY revenue DESC) * 1.0
          / SUM(revenue) OVER () AS cumulative_share
    FROM product_sales
)
SELECT
    CASE WHEN cumulative_share <= 0.80 THEN 'A'
         WHEN cumulative_share <= 0.95 THEN 'B'
         ELSE 'C' END                      AS abc_class,
    COUNT(*)                               AS products,
    ROUND(SUM(revenue), 0)                 AS revenue,
    ROUND(SUM(revenue) * 100.0 / (SELECT SUM(revenue) FROM product_sales), 1) AS revenue_pct
FROM ranked
GROUP BY abc_class
ORDER BY abc_class;