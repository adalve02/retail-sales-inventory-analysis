-- Build a clean sales table: real product sales only
DROP TABLE IF EXISTS sales_clean;

-- Speed up the cancellation check
CREATE INDEX IF NOT EXISTS idx_sales_match ON sales (stockcode, customer_id, quantity);

CREATE TABLE sales_clean AS
SELECT
    s.invoice,
    s.stockcode,
    s.description,
    s.quantity,
    s.price,
    ROUND(s.quantity * s.price, 2)      AS revenue,
    s.invoicedate,
    strftime('%Y-%m', s.invoicedate)    AS year_month,
    s.customer_id,
    s.country
FROM sales s
WHERE s.invoice NOT LIKE 'C%'           -- remove cancellations
  AND s.quantity > 0                    -- remove returns and stock adjustments
  AND s.price > 0                       -- remove free items and adjustments
  -- remove fees, postage and manual adjustments (not real products)
  AND s.stockcode NOT IN ('POST','DOT','M','D','C2','CRUK','PADS','B','S',
                          'BANK CHARGES','AMAZONFEE','ADJUST','ADJUST2')
  AND s.stockcode NOT LIKE 'TEST%'
  AND s.stockcode NOT LIKE 'gift%'
  -- remove large orders (1,000+ units) that were later cancelled
  AND NOT (s.quantity >= 1000 AND EXISTS (
        SELECT 1 FROM sales c
        WHERE c.invoice LIKE 'C%'
          AND c.stockcode   = s.stockcode
          AND c.customer_id = s.customer_id
          AND c.quantity    = -s.quantity));