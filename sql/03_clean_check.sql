SELECT
    (SELECT COUNT(*) FROM sales)        AS original_rows,
    (SELECT COUNT(*) FROM sales_clean)  AS clean_rows,
    (SELECT COUNT(*) FROM sales) - (SELECT COUNT(*) FROM sales_clean) AS rows_removed,
    (SELECT ROUND(SUM(revenue), 0) FROM sales_clean) AS total_revenue
FROM sales LIMIT 1;