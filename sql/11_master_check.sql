SELECT
    (SELECT COUNT(DISTINCT stockcode) FROM sales_clean)              AS codes_before,
    (SELECT COUNT(DISTINCT UPPER(TRIM(stockcode))) FROM sales_clean) AS codes_after_case_fix,
    (SELECT COUNT(*) FROM product_master)                            AS master_products;