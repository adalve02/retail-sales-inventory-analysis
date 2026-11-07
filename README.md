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

## Tools
SQL (SQLite), Python (Pandas), Power BI, Git

## Project Structure
- `scripts/` — data loading and query runner
- `sql/` — numbered queries, from data checks to analysis