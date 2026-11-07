-- Stock codes with more than one product description (master data issue)
SELECT
    stockcode,
    COUNT(DISTINCT description)            AS description_count,
    GROUP_CONCAT(DISTINCT description)     AS descriptions
FROM sales_clean
GROUP BY stockcode
HAVING COUNT(DISTINCT description) > 1
ORDER BY description_count DESC
LIMIT 15;