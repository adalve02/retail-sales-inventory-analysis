-- Large sales that were later cancelled (same product, same customer, same quantity)
SELECT
    s.invoice, s.stockcode, s.description, s.quantity, s.customer_id, s.invoicedate,
    c.invoice AS cancel_invoice
FROM sales s
JOIN sales c
  ON  c.invoice LIKE 'C%'
  AND c.stockcode   = s.stockcode
  AND c.customer_id = s.customer_id
  AND c.quantity    = -s.quantity
WHERE s.invoice NOT LIKE 'C%'
  AND s.quantity >= 1000
ORDER BY s.quantity DESC;