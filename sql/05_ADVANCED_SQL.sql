-- =====================================================
-- 05_ADVANCED_SQL.SQL
-- =====================================================


-- =====================================================
-- Q1. Top 3 Products in Every Category
-- =====================================================

WITH product_revenue AS (

    SELECT

        category_name,

        product_card_id,

        product_name,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY
        category_name,
        product_card_id,
        product_name

),

ranked_products AS (

    SELECT

        *,

        ROW_NUMBER() OVER(

            PARTITION BY category_name

            ORDER BY revenue DESC

        ) AS row_num

    FROM product_revenue

)

SELECT *

FROM ranked_products

WHERE row_num <=3;



-- =====================================================
-- Q2. Rank Customers By Revenue
-- =====================================================

WITH customer_revenue AS (

    SELECT

        customer_id,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY customer_id

)

SELECT

    *,

    RANK() OVER(

        ORDER BY revenue DESC

    ) AS customer_rank

FROM customer_revenue;



-- =====================================================
-- Q3. Dense Rank Products By Profit
-- =====================================================

WITH product_profit AS (

    SELECT

        product_card_id,

        product_name,

        SUM(order_profit_per_order) AS profit

    FROM supply_chain_clean

    GROUP BY
        product_card_id,
        product_name

)

SELECT

    *,

    DENSE_RANK() OVER(

        ORDER BY profit DESC

    ) AS profit_rank

FROM product_profit;



-- =====================================================
-- Q4. Running Monthly Revenue
-- =====================================================

WITH monthly_revenue AS (

    SELECT

        DATE_TRUNC('month',order_date) AS month,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY DATE_TRUNC('month',order_date)

)

SELECT

    month,

    revenue,

    SUM(revenue) OVER(

        ORDER BY month

    ) AS running_revenue

FROM monthly_revenue;



-- =====================================================
-- Q5. Month Over Month Growth
-- =====================================================

WITH monthly_revenue AS (

    SELECT

        DATE_TRUNC('month',order_date) AS month,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY DATE_TRUNC('month',order_date)

),

monthly_growth AS (

    SELECT

        month,

        revenue,

        LAG(revenue) OVER(

            ORDER BY month

        ) AS previous_month

    FROM monthly_revenue

)

SELECT

    *,

    ROUND(

        ((revenue-previous_month)*100.0)
        /previous_month,

        2

    ) AS growth_percentage

FROM monthly_growth;



-- =====================================================
-- Q6. Revenue Contribution By Category
-- =====================================================

WITH category_revenue AS (

    SELECT

        category_name,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY category_name

)

SELECT

    *,

    ROUND(

        revenue*100.0/

        SUM(revenue) OVER(),

        2

    ) AS contribution_percentage

FROM category_revenue

ORDER BY contribution_percentage DESC;



-- =====================================================
-- Q7. Pareto Analysis (80-20 Rule)
-- =====================================================

WITH product_revenue AS (

    SELECT

        product_card_id,

        product_name,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY
        product_card_id,
        product_name

),

pareto AS (

    SELECT

        *,

        SUM(revenue) OVER(

            ORDER BY revenue DESC

        ) AS cumulative_revenue,

        SUM(revenue) OVER() AS total_revenue

    FROM product_revenue

)

SELECT

    *,

    ROUND(

        cumulative_revenue*100.0

        /total_revenue,

        2

    ) AS cumulative_percentage

FROM pareto;



-- =====================================================
-- Q8. Rolling 3 Month Revenue
-- =====================================================

WITH monthly_revenue AS (

    SELECT

        DATE_TRUNC('month',order_date) AS month,

        SUM(sales) AS revenue

    FROM supply_chain_clean

    GROUP BY DATE_TRUNC('month',order_date)

)

SELECT

    month,

    revenue,

    ROUND(

        AVG(revenue) OVER(

            ORDER BY month

            ROWS BETWEEN 2 PRECEDING

            AND CURRENT ROW

        ),

        2

    ) AS rolling_average

FROM monthly_revenue;



-- =====================================================
-- Q9. Most Profitable Product In Every Category
-- =====================================================

WITH product_profit AS (

    SELECT

        category_name,

        product_card_id,

        product_name,

        SUM(order_profit_per_order) AS profit

    FROM supply_chain_clean

    GROUP BY
        category_name,
        product_card_id,
        product_name

),

ranked_products AS (

    SELECT

        *,

        ROW_NUMBER() OVER(

            PARTITION BY category_name

            ORDER BY profit DESC

        ) AS row_num

    FROM product_profit

)

SELECT *

FROM ranked_products

WHERE row_num=1;



-- =====================================================
-- Q10. Customer Lifetime Value
-- =====================================================

SELECT

    customer_id,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(sales) AS lifetime_revenue,

    SUM(order_profit_per_order) AS lifetime_profit,

    ROUND(

        SUM(sales)

        /COUNT(DISTINCT order_id),

        2

    ) AS average_order_value

FROM supply_chain_clean

GROUP BY customer_id

ORDER BY lifetime_revenue DESC;
