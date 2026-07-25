/*
=========================================================
Project : Supply Chain & Inventory Analytics
File    : 02_data_cleaning.sql
=========================================================
Purpose:
1. Create cleaned table
2. Remove unnecessary columns
3. Convert data types
=========================================================
*/

DROP TABLE IF EXISTS supply_chain_clean;

CREATE TABLE supply_chain_clean AS
SELECT *
FROM supply_chain_raw;

----------------------------------------------------------
-- Remove unnecessary columns
----------------------------------------------------------

ALTER TABLE supply_chain_clean

DROP COLUMN customer_email,
DROP COLUMN customer_password,
DROP COLUMN product_description,
DROP COLUMN product_image;

----------------------------------------------------------
-- Integer Columns
----------------------------------------------------------

ALTER TABLE supply_chain_clean

ALTER COLUMN days_for_shipping_real TYPE INTEGER USING days_for_shipping_real::INTEGER,
ALTER COLUMN days_for_shipment_scheduled TYPE INTEGER USING days_for_shipment_scheduled::INTEGER,
ALTER COLUMN category_id TYPE INTEGER USING category_id::INTEGER,
ALTER COLUMN customer_id TYPE INTEGER USING customer_id::INTEGER,
ALTER COLUMN department_id TYPE INTEGER USING department_id::INTEGER,
ALTER COLUMN order_customer_id TYPE INTEGER USING order_customer_id::INTEGER,
ALTER COLUMN order_id TYPE INTEGER USING order_id::INTEGER,
ALTER COLUMN order_item_cardprod_id TYPE INTEGER USING order_item_cardprod_id::INTEGER,
ALTER COLUMN order_item_id TYPE INTEGER USING order_item_id::INTEGER,
ALTER COLUMN order_item_quantity TYPE INTEGER USING order_item_quantity::INTEGER,
ALTER COLUMN product_card_id TYPE INTEGER USING product_card_id::INTEGER,
ALTER COLUMN product_category_id TYPE INTEGER USING product_category_id::INTEGER,
ALTER COLUMN product_status TYPE INTEGER USING product_status::INTEGER;

----------------------------------------------------------
-- Numeric Columns
----------------------------------------------------------

ALTER TABLE supply_chain_clean

ALTER COLUMN benefit_per_order TYPE NUMERIC(10,2) USING benefit_per_order::NUMERIC(10,2),
ALTER COLUMN sales_per_customer TYPE NUMERIC(10,2) USING sales_per_customer::NUMERIC(10,2),
ALTER COLUMN latitude TYPE NUMERIC(10,6) USING latitude::NUMERIC(10,6),
ALTER COLUMN longitude TYPE NUMERIC(10,6) USING longitude::NUMERIC(10,6),
ALTER COLUMN order_item_discount TYPE NUMERIC(10,2) USING order_item_discount::NUMERIC(10,2),
ALTER COLUMN order_item_discount_rate TYPE NUMERIC(5,4) USING order_item_discount_rate::NUMERIC(5,4),
ALTER COLUMN order_item_product_price TYPE NUMERIC(10,2) USING order_item_product_price::NUMERIC(10,2),
ALTER COLUMN order_item_profit_ratio TYPE NUMERIC(6,4) USING order_item_profit_ratio::NUMERIC(6,4),
ALTER COLUMN sales TYPE NUMERIC(10,2) USING sales::NUMERIC(10,2),
ALTER COLUMN order_item_total TYPE NUMERIC(10,2) USING order_item_total::NUMERIC(10,2),
ALTER COLUMN order_profit_per_order TYPE NUMERIC(10,2) USING order_profit_per_order::NUMERIC(10,2),
ALTER COLUMN product_price TYPE NUMERIC(10,2) USING product_price::NUMERIC(10,2);

----------------------------------------------------------
-- Timestamp Columns
----------------------------------------------------------

ALTER TABLE supply_chain_clean

ALTER COLUMN order_date_dateorders
TYPE TIMESTAMP
USING TO_TIMESTAMP(order_date_dateorders,'MM/DD/YYYY HH24:MI');

ALTER TABLE supply_chain_clean

ALTER COLUMN shipping_date_dateorders
TYPE TIMESTAMP
USING TO_TIMESTAMP(shipping_date_dateorders,'MM/DD/YYYY HH24:MI');

----------------------------------------------------------
-- Boolean Column
----------------------------------------------------------

ALTER TABLE supply_chain_clean

ALTER COLUMN late_delivery_risk
TYPE BOOLEAN
USING (late_delivery_risk::INTEGER = 1);

----------------------------------------------------------
-- Validation
----------------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM supply_chain_clean;

SELECT *
FROM supply_chain_clean
LIMIT 10;