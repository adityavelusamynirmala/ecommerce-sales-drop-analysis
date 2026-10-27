/*
Project: E-Commerce Sales Drop Analysis
Dialect: SQLite
Expected imported table names: orders, customers, products

Run sections in order. These queries are intended to validate the dataset,
confirm the trend, and investigate potential drivers. They do not prove causality.
*/

-- 1. Table sizes
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products;

-- 2. Check duplicate order IDs
SELECT order_id, COUNT(*) AS row_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- 3. Check missing order dates and quantify the affected revenue
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_date IS NULL OR TRIM(order_date) = '' OR LOWER(order_date) = 'nat' THEN 1 ELSE 0 END) AS rows_missing_date,
    ROUND(SUM(CASE WHEN order_date IS NULL OR TRIM(order_date) = '' OR LOWER(order_date) = 'nat' THEN revenue ELSE 0 END), 2) AS revenue_missing_date,
    ROUND(100.0 * SUM(CASE WHEN order_date IS NULL OR TRIM(order_date) = '' OR LOWER(order_date) = 'nat' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_rows_missing_date
FROM orders;

-- 4. Check for unmatched customer/product keys
SELECT COUNT(*) AS orders_without_customer_match
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS orders_without_product_match
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 5. Overall monthly trend. Exclude undated rows; do not invent dates.
SELECT
    substr(order_date, 1, 7) AS order_month,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS average_order_value,
    ROUND(SUM(profit_estimate), 2) AS estimated_profit
FROM orders
WHERE order_date IS NOT NULL
  AND TRIM(order_date) <> ''
  AND LOWER(order_date) <> 'nat'
GROUP BY substr(order_date, 1, 7)
ORDER BY order_month;

-- 6. July-to-September 2026 comparison for the main metrics
WITH monthly AS (
    SELECT
        substr(order_date, 1, 7) AS order_month,
        COUNT(DISTINCT order_id) AS orders,
        SUM(quantity) AS units_sold,
        SUM(revenue) AS revenue,
        SUM(profit_estimate) AS estimated_profit
    FROM orders
    WHERE order_date IS NOT NULL
      AND TRIM(order_date) <> ''
      AND LOWER(order_date) <> 'nat'
    GROUP BY substr(order_date, 1, 7)
),
periods AS (
    SELECT
        MAX(CASE WHEN order_month = '2026-07' THEN revenue END) AS july_revenue,
        MAX(CASE WHEN order_month = '2026-09' THEN revenue END) AS september_revenue,
        MAX(CASE WHEN order_month = '2026-07' THEN orders END) AS july_orders,
        MAX(CASE WHEN order_month = '2026-09' THEN orders END) AS september_orders,
        MAX(CASE WHEN order_month = '2026-07' THEN units_sold END) AS july_units,
        MAX(CASE WHEN order_month = '2026-09' THEN units_sold END) AS september_units,
        MAX(CASE WHEN order_month = '2026-07' THEN estimated_profit END) AS july_profit,
        MAX(CASE WHEN order_month = '2026-09' THEN estimated_profit END) AS september_profit
    FROM monthly
)
SELECT
    ROUND(july_revenue, 2) AS july_revenue,
    ROUND(september_revenue, 2) AS september_revenue,
    ROUND(100.0 * (september_revenue - july_revenue) / NULLIF(july_revenue, 0), 2) AS revenue_change_pct,
    july_orders,
    september_orders,
    ROUND(100.0 * (september_orders - july_orders) / NULLIF(july_orders, 0), 2) AS orders_change_pct,
    ROUND(100.0 * (september_units - july_units) / NULLIF(july_units, 0), 2) AS units_change_pct,
    ROUND(100.0 * (september_profit - july_profit) / NULLIF(july_profit, 0), 2) AS estimated_profit_change_pct
FROM periods;

-- 7. Revenue and order trends by sales channel and month
SELECT
    substr(order_date, 1, 7) AS order_month,
    sales_channel,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS average_order_value
FROM orders
WHERE order_date IS NOT NULL
  AND TRIM(order_date) <> ''
  AND LOWER(order_date) <> 'nat'
GROUP BY substr(order_date, 1, 7), sales_channel
ORDER BY order_month, revenue DESC;

-- 8. Revenue by product category and month
SELECT
    substr(o.order_date, 1, 7) AS order_month,
    p.category,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(o.quantity) AS units_sold,
    ROUND(SUM(o.revenue), 2) AS revenue,
    ROUND(SUM(o.profit_estimate), 2) AS estimated_profit
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id
WHERE o.order_date IS NOT NULL
  AND TRIM(o.order_date) <> ''
  AND LOWER(o.order_date) <> 'nat'
GROUP BY substr(o.order_date, 1, 7), p.category
ORDER BY order_month, revenue DESC;

-- 9. Revenue by customer region and month
SELECT
    substr(o.order_date, 1, 7) AS order_month,
    c.region,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(o.revenue), 2) AS revenue,
    ROUND(SUM(o.revenue) / NULLIF(COUNT(DISTINCT o.order_id), 0), 2) AS average_order_value
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date IS NOT NULL
  AND TRIM(o.order_date) <> ''
  AND LOWER(o.order_date) <> 'nat'
GROUP BY substr(o.order_date, 1, 7), c.region
ORDER BY order_month, revenue DESC;

-- 10. Revenue by customer segment and month
SELECT
    substr(o.order_date, 1, 7) AS order_month,
    c.customer_segment,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(o.revenue), 2) AS revenue
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date IS NOT NULL
  AND TRIM(o.order_date) <> ''
  AND LOWER(o.order_date) <> 'nat'
GROUP BY substr(o.order_date, 1, 7), c.customer_segment
ORDER BY order_month, revenue DESC;

-- 11. Largest products in the latest observed month (September 2026)
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity) AS units_sold,
    ROUND(SUM(o.revenue), 2) AS revenue,
    ROUND(SUM(o.profit_estimate), 2) AS estimated_profit
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id
WHERE substr(o.order_date, 1, 7) = '2026-09'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- 12. Discount profile by month: investigate association, not causation
SELECT
    substr(order_date, 1, 7) AS order_month,
    ROUND(AVG(discount_pct) * 100, 2) AS average_discount_pct,
    ROUND(SUM(discount_amount), 2) AS total_discount_amount,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(profit_estimate), 2) AS estimated_profit
FROM orders
WHERE order_date IS NOT NULL
  AND TRIM(order_date) <> ''
  AND LOWER(order_date) <> 'nat'
GROUP BY substr(order_date, 1, 7)
ORDER BY order_month;

-- 13. Customer acquisition channel performance by month
SELECT
    substr(o.order_date, 1, 7) AS order_month,
    c.acquisition_channel,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.customer_id) AS purchasing_customers,
    ROUND(SUM(o.revenue), 2) AS revenue
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date IS NOT NULL
  AND TRIM(o.order_date) <> ''
  AND LOWER(o.order_date) <> 'nat'
GROUP BY substr(o.order_date, 1, 7), c.acquisition_channel
ORDER BY order_month, revenue DESC;
