-- setting the database
USE DATABASE hamster;

-- What percent of orders were returned
SELECT
ROUND(((SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*)) * 100), 1) AS "Percent of Returned Orders"
FROM orders;

-- How does the return rate found compare to the industry average.
-- National Retail Federation (2025) found that ~19.3% of online purchases are returned in 2025.
-- National Retail Federation. (2025, October 15). *2025 retail returns landscape*. https://nrf.com/research/2025-retail-returns-landscape

-- Has the return rate increased from 2019 and 2023
SELECT
EXTRACT(year, created_at) AS year,
ROUND(((SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*)) * 100), 1) AS "Percent of Returned Orders by Year"
FROM orders
GROUP BY year
ORDER BY year;

-- Which three product categories have the highest return rates?
SELECT
p.category,
ROUND(((SUM(CASE WHEN o.status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*)) * 100), 1) AS "Percent of Returned Orders"
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY "Percent of Returned Orders" DESC
LIMIT 3;

-- How much revenue was lost on returns
SELECT
SUM(ot.sale_price) AS "Revenue Loss to Returns"
FROM orders o JOIN order_items ot ON o.order_id = ot.order_id
WHERE o.status = 'Returned';
