-- Monthly revenue, orders and customers
SELECT
    year_month,
    ROUND(SUM(revenue), 0)          AS revenue,
    COUNT(DISTINCT invoice)         AS orders,
    COUNT(DISTINCT customer_id)     AS customers,
    ROUND(SUM(revenue) / COUNT(DISTINCT invoice), 2) AS avg_order_value
FROM sales_clean
GROUP BY year_month
ORDER BY year_month;