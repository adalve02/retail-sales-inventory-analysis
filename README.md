# retail-sales-inventory-analysis
SQL and Power BI analysis of 1M+ retail transactions: sales trends, top products, ABC analysis and returns.
# Retail Sales & Inventory Analysis (SQL + Power BI)

Analysis of 1M+ transactions from a UK online gift retailer (Dec 2009 – Dec 2011) to find sales trends, top products and data quality issues.

## Business Questions
- How do sales change across the year?
- Which products drive revenue?
- How much of the raw data is not real sales?

## Data
Online Retail II, UCI Machine Learning Repository — 1,067,371 rows, 5,305 products, 5,942 customers.

## Data Cleaning
- Removed cancellations, returns, stock adjustments and zero-price rows
- Excluded non-product codes (postage, fees, manual adjustments)
- Removed bulk orders (1,000+ units) that were later cancelled
- **Result:** 2.8% of rows removed, but 5.6% of revenue (~$1.18M) — raw data overstated sales

## Key Findings
- **Seasonality:** Sep–Dec = 46.8% of 2010 revenue; November peaks at ~2.8× February
- **Growth:** Jan–Nov revenue grew just 2.0% year over year ($8.59M → $8.77M)
- **Long tail:** Top 10 products = only 7.3% of revenue; #1 product = 1.7%
- **Note:** December 2011 is partial (data ends Dec 9)

- **ABC analysis:** 21% of products (A) drive 80% of revenue; 53% of products (C) bring in only 5% — candidates for range review
- **Master data quality:** 646 stock codes (12%) had inconsistent descriptions (typos, spacing, wording), and some codes differed only by upper/lower case — built a product master table with one standard code and description per item

- **Master data quality:** 646 stock codes (12%) had inconsistent descriptions (typos, spacing, wording), and 171 products (3.5%) were split across duplicate codes differing only by upper/lower case — built a product master with one standard code and description per item (4,895 → 4,724 products)

- **ABC analysis:** 1,035 products (22%) drive 80% of revenue; 2,432 products (52%) bring in only 5% — candidates for range review or markdowns
## Tools
SQL (SQLite), Python (Pandas), Power BI, Git

## Project Structure
- `scripts/` — data loading and query runner
- `sql/` — numbered queries, from data checks to analysis