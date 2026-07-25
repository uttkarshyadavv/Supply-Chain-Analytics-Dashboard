-- ==========================================
-- 03_EXECUTIVE_DASHBOARD_KPIS.SQL
-- ==========================================

-- ==========================================
-- REVENUE KPIs
-- ==========================================

-- Gross Revenue
SELECT
    SUM(sales) AS gross_revenue
FROM supply_chain_clean;

-- Net Revenue
SELECT
    SUM(order_item_total) AS net_revenue
FROM supply_chain_clean;

-- Total Profit
SELECT
    SUM(order_profit_per_order) AS total_profit
FROM supply_chain_clean;

-- Profit Margin (%)
SELECT
    ROUND(
        (SUM(order_profit_per_order) / SUM(order_item_total)) * 100,
        2
    ) AS profit_margin
FROM supply_chain_clean;


-- ==========================================
-- ORDER KPIs
-- ==========================================

-- Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM supply_chain_clean;

-- Average Order Value (AOV)
SELECT
    ROUND(
        SUM(order_item_total) /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM supply_chain_clean;


-- ==========================================
-- CUSTOMER KPI
-- ==========================================

-- Total Customers
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM supply_chain_clean;


-- ==========================================
-- PRODUCT KPI
-- ==========================================

-- Total Quantity Sold
SELECT
    SUM(order_item_quantity) AS total_quantity_sold
FROM supply_chain_clean;