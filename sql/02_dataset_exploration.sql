-- setting the database to Urban Hamsters
USE DATABASE hamster;
-- which table has information about customer returns? Which columns can help us identify returns?
SELECT
    *
FROM
    orders
LIMIT
    10;
SELECT
    order_id,
    status,
    returned_at
FROM
    orders
WHERE
    status = 'Returned';
-- how many years of orders are in this data
SELECT
    MIN(created_at) AS "First Order",
    MAX(created_at) AS "Last Order",
    TIMESTAMPDIFF(year, "First Order", "Last Order") AS "Years of Order Data"
FROM
    orders;
-- how many orders are in the data
SELECT
    COUNT(*) AS "Total Orders"
FROM
    orders;
-- Are there any duplicate order ids?
SELECT
    order_id,
    COUNT(order_id) AS "Order ID Count"
FROM
    orders
GROUP BY
    order_id
HAVING
    "Order ID Count" > 1;
-- What were our orders and cumulatitve orders by year and month
SELECT
    EXTRACT(year, created_at) AS year,
    EXTRACT(month, created_at) AS month,
    COUNT(order_id) AS "Order Count",
    SUM("Order Count") OVER(
        ORDER BY
            year,
            month
    ) AS "Cumulative Order Totals"
FROM
    orders
GROUP BY
    year,
    month
ORDER BY
    year,
    month;
-- How many unique users had an order
SELECT
    COUNT(DISTINCT user_id) AS "Total Unique Users with Orders Placed"
FROM
    orders;
-- How many orders were returned
SELECT
    COUNT(order_id) AS "Total Orders Returned"
FROM
    orders
WHERE
    status = 'Returned';
-- What are the order "statuses" in the data?
SELECT
    status
FROM
    orders
GROUP BY
    status;
-- Count of orders within each status
SELECT
    status,
    COUNT(*) AS "Total Orders by Status"
FROM
    orders
GROUP BY
    status;
-- Do any orders have a return date that is before their shipment date?
SELECT
    order_id
FROM
    orders
WHERE
    shipped_at > returned_at;