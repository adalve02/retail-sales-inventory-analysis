-- Data quality check: size, date range, missing values and returns
SELECT
    COUNT(*)                                             AS total_rows,
    COUNT(DISTINCT invoice)                              AS invoices,
    COUNT(DISTINCT stockcode)                            AS products,
    COUNT(DISTINCT customer_id)                          AS customers,
    MIN(invoicedate)                                     AS first_date,
    MAX(invoicedate)                                     AS last_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer,
    SUM(CASE WHEN quantity < 0 THEN 1 ELSE 0 END)        AS negative_qty_rows,
    SUM(CASE WHEN invoice LIKE 'C%' THEN 1 ELSE 0 END)   AS cancelled_rows,
    SUM(CASE WHEN price <= 0 THEN 1 ELSE 0 END)          AS zero_or_negative_price
FROM sales;