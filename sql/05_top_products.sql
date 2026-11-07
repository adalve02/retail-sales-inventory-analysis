-- Top 10 products by revenue
SELECT
    stockcode,
    description,
    SUM(quantity)                AS units_sold,
    ROUND(SUM(revenue), 0)       AS revenue,
    COUNT(DISTINCT invoice)      AS orders
FROM sales_clean
GROUP BY stockcode, description
ORDER BY revenue DESC
LIMIT 10;