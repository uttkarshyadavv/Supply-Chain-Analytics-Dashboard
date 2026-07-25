/*
=========================================================
Project : Supply Chain & Inventory Analytics
File    : 01_data_import.sql
Author  : Utkarsh Yadav
Database: PostgreSQL
=========================================================
Purpose:
1. Create raw table.
2. Import CSV using pgAdmin Import/Export Wizard.
=========================================================
*/

DROP TABLE IF EXISTS supply_chain_raw;

CREATE TABLE supply_chain_raw (

    type TEXT,
    days_for_shipping_real TEXT,
    days_for_shipment_scheduled TEXT,
    benefit_per_order TEXT,
    sales_per_customer TEXT,
    delivery_status TEXT,
    late_delivery_risk TEXT,
    category_id TEXT,
    category_name TEXT,
    customer_city TEXT,
    customer_country TEXT,
    customer_email TEXT,
    customer_fname TEXT,
    customer_id TEXT,
    customer_lname TEXT,
    customer_password TEXT,
    customer_segment TEXT,
    customer_state TEXT,
    customer_street TEXT,
    customer_zipcode TEXT,
    department_id TEXT,
    department_name TEXT,
    latitude TEXT,
    longitude TEXT,
    market TEXT,
    order_city TEXT,
    order_country TEXT,
    order_customer_id TEXT,
    order_date_dateorders TEXT,
    order_id TEXT,
    order_item_cardprod_id TEXT,
    order_item_discount TEXT,
    order_item_discount_rate TEXT,
    order_item_id TEXT,
    order_item_product_price TEXT,
    order_item_profit_ratio TEXT,
    order_item_quantity TEXT,
    sales TEXT,
    order_item_total TEXT,
    order_profit_per_order TEXT,
    order_region TEXT,
    order_state TEXT,
    order_status TEXT,
    order_zipcode TEXT,
    product_card_id TEXT,
    product_category_id TEXT,
    product_description TEXT,
    product_image TEXT,
    product_name TEXT,
    product_price TEXT,
    product_status TEXT,
    shipping_date_dateorders TEXT,
    shipping_mode TEXT

);

/*
---------------------------------------------------------
Import Instructions

1. Right-click supply_chain_raw
2. Import/Export Data
3. Import
4. Select DataCoSupplyChainDataset.csv
5. Format : CSV
6. Encoding : LATIN1
7. Header : Yes

---------------------------------------------------------
Validation
---------------------------------------------------------
*/

SELECT COUNT(*) AS total_rows
FROM supply_chain_raw;

SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name='supply_chain_raw';
