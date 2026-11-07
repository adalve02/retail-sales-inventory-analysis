SELECT COUNT(*) AS stockcodes_with_multiple_descriptions
FROM (
    SELECT stockcode
    FROM sales_clean
    GROUP BY stockcode
    HAVING COUNT(DISTINCT description) > 1
);