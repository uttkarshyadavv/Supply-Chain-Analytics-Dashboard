-- =====================================================
-- 04_BUSINESS_ANALYSIS.SQL
-- =====================================================

-- =====================================================
-- PRODUCT ANALYSIS
-- =====================================================

-- Q1. Top 10 Products by Revenue

-- Business Question:
-- Which products generate the highest revenue?

SELECT
    product_card_id,
    product_name,
    SUM(sales) AS revenue
FROM supply_chain_clean
GROUP BY product_card_id, product_name
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================

-- Q2. Top 10 Products by Profit

-- Business Question:
-- Which products generate the highest profit?

SELECT
    product_card_id,
    product_name,
    SUM(order_profit_per_order) AS profit
FROM supply_chain_clean
GROUP BY product_card_id, product_name
ORDER BY profit DESC
LIMIT 10;


-- =====================================================

-- Q3. Top 10 Products by Quantity Sold

-- Business Question:
-- Which products sell the highest number of units?

SELECT
    product_card_id,
    product_name,
    SUM(order_item_quantity) AS quantity_sold
FROM supply_chain_clean
GROUP BY product_card_id, product_name
ORDER BY quantity_sold DESC
LIMIT 10;


-- =====================================================

-- Q4. High Revenue but Low Profit Products

-- Business Question:
-- Which products generate high revenue but have poor profit margins?

WITH product_summary AS (

    SELECT
        product_card_id,
        product_name,
        SUM(sales) AS revenue,
        SUM(order_profit_per_order) AS profit,
        SUM(order_profit_per_order)/SUM(sales) AS profit_margin
    FROM supply_chain_clean
    GROUP BY product_card_id, product_name

)

SELECT *
FROM product_summary
WHERE revenue >
(
    SELECT AVG(revenue)
    FROM product_summary
)
ORDER BY profit_margin
LIMIT 10;


-- =====================================================

-- Q5. Products with Highest Average Discount %

-- Business Question:
-- Which products receive the highest average discount?

SELECT
    product_card_id,
    product_name,
    AVG(order_item_discount_rate)*100 AS discount_percentage
FROM supply_chain_clean
GROUP BY product_card_id, product_name
ORDER BY discount_percentage DESC;


-- =====================================================

-- Q6. Products with Negative Profit

-- Business Question:
-- Which products are losing money?

SELECT
    product_card_id,
    product_name,
    SUM(sales) AS revenue,
    SUM(order_profit_per_order) AS total_profit,
    SUM(order_profit_per_order)/SUM(sales) AS profit_margin
FROM supply_chain_clean
GROUP BY product_card_id, product_name
HAVING SUM(order_profit_per_order) < 0;


-- =====================================================
-- SHIPPING ANALYSIS
-- =====================================================

-- Q7. Shipping Mode Performance

-- Business Question:
-- Which shipping mode has the highest late delivery rate?

WITH late_del AS (

    SELECT
        shipping_mode,
        COUNT(*) AS late_shipments
    FROM supply_chain_clean
    WHERE delivery_status = 'Late delivery'
    GROUP BY shipping_mode

),

total_del AS (

    SELECT
        shipping_mode,
        COUNT(*) AS total_shipments
    FROM supply_chain_clean
    WHERE delivery_status <> 'Shipping canceled'
    GROUP BY shipping_mode

)

SELECT
    t.shipping_mode,
    t.total_shipments,
    l.late_shipments,
    ROUND((l.late_shipments*100.0)/t.total_shipments,2) AS late_delivery_rate
FROM total_del t
JOIN late_del l
ON t.shipping_mode = l.shipping_mode
ORDER BY late_delivery_rate DESC;


-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================

-- Q8. Repeat Customers

-- Business Question:
-- Which customers place the highest number of orders?

SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM supply_chain_clean
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- =====================================================

-- Q9. Top Customers by Revenue

-- Business Question:
-- Which customers generate the highest revenue?

SELECT
    customer_id,
    SUM(sales) AS revenue
FROM supply_chain_clean
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================

-- Q10. Top Customers by Profit

-- Business Question:
-- Which customers generate the highest profit?

SELECT
    customer_id,
    SUM(order_profit_per_order) AS profit
FROM supply_chain_clean
GROUP BY customer_id
ORDER BY profit DESC
LIMIT 10;
