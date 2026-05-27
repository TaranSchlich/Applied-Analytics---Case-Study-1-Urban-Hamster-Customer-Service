# Urban Hamster — Case Study 1: Customer Service & Return Policy Analysis

**Course:** GB884 — Applied Analytics  
**Role:** Central Analytics Team (Consultant)  
**Stakeholder:** Customer Service Operations  
**Tools:** Snowflake SQL · Tableau Desktop · Python  

---

## Project Overview

Urban Hamster is a fictional online clothing retailer used as the basis for a four-part applied analytics case study series. This repository covers **Case Study 1**, in which the central analytics team was engaged by the Customer Service department to investigate an uptick in product returns, evaluate the company's return policy, and build a monitoring dashboard.

The work follows the full analytics consulting lifecycle:
1. Stakeholder interview to surface business questions
2. Exploratory data analysis
3. SQL-based answers to business questions
4. Presentation of findings
5. Tableau dashboard for ongoing monitoring

---

## Business Context

Customer Service Manager **Sarah Johnson** raised the following questions:

- What product categories have the highest return rates?
- Has the return rate been increasing over time?
- How does our return rate compare to the industry average?
- What is the financial impact of returns?
- Is our strict return policy hurting sales and reputation — and what should we change?

---

## Key Findings

| Metric | Value |
|---|---|
| Overall return rate | 10.0% |
| Industry average (NRF, 2025) | 19.3% |
| Return rate in 2019 | 9.2% |
| Return rate in 2023 | 10.3% |
| Revenue lost to returns | $1,088,903.82 |
| Top return categories | Pants (11.0%), Leggings (10.7%), Socks & Hosiery (10.7%) |

Urban Hamster's return rate sits well below the industry average — but under a strict return policy, this likely reflects suppressed purchases rather than high satisfaction. All three top return categories are fit-sensitive products, suggesting sizing guidance and product descriptions may be contributing factors alongside policy.

**Policy recommendations:** Extend the return window to 30 days, offer prepaid return labels, and maintain stricter restrictions only on sale/clearance items.

---

## Repository Structure

```
├── sql/
│   ├── 01_database_setup.sql        # Snowflake DB, tables, stage, and data load
│   ├── 02_dataset_exploration.sql   # Exploratory queries (volume, trends, QA checks)
│   └── 03_business_questions.sql    # Queries answering stakeholder business questions
│
├── presentation/
│   └── GB884_Case1_ReturnPolicy_Analysis.pptx   # Findings deck presented to the CS team
│
├── dashboard/
│   ├── Urban_Hamster_Return_Rate_Monitor.pdf     # Tableau dashboard export
│   └── query_results.xlsx                        # Raw SQL query output from Snowflake
│
└── scripts/
    └── create_presentation.py       # Python script used to generate the branded PPTX
```

---

## Dashboard

The Tableau dashboard — **Urban Hamster Return Rate Monitor** — was built to give the Customer Service team a single live-connected view to monitor return rates before and after policy changes.

**Four views:**
- Monthly order volume by status (area chart, 2019–2023)
- Monthly return rate by status as % of total (area chart, 2019–2023)
- Orders by product category and status — Top 10 (stacked bar)
- Orders by brand and status — Top 10 (stacked bar)

**Design decisions:**
- Live Snowflake connection — updates automatically when opened
- Consistent color encoding: Fulfilled = gray, Returned = yellow, Cancelled = red
- Filtered to 2019–2023 (2024 excluded as incomplete year)
- Top 10 filter on category and brand charts to apply the 80/20 rule

---

## Data Source

Data is stored in a **Snowflake** database (`hamster`) loaded from S3. Six tables:

| Table | Description |
|---|---|
| `orders` | Order-level data including status and timestamps |
| `order_items` | Line items per order with sale price |
| `products` | Product catalog with category, brand, cost |
| `users` | Customer demographics |
| `events` | Clickstream/session data |
| `distribution_centers` | Fulfillment center locations |

---

## Citations

- National Retail Federation. (2025). *2025 Retail Returns Landscape*. https://nrf.com/research/2025-retail-returns-landscape
- Bower, A. B., & Maxham, J. G. (2012). Return shipping policies of online retailers. *Journal of Marketing, 76*(5), 110–124. https://doi.org/10.1509/jm.10.0419
- Petersen, J. A., & Kumar, V. (2009). Are product returns a necessary evil? *Journal of Marketing, 73*(3), 35–51. https://doi.org/10.1509/jmkg.73.3.35
