/*
===============================================================================
                    SUPPLY CHAIN & INVENTORY ANALYTICS
===============================================================================

Author      : Utkarsh Yadav
Role        : Data Analyst Portfolio Project
Database    : PostgreSQL 18
Tools       : PostgreSQL, pgAdmin 4, Power BI

Dataset     : DataCo Smart Supply Chain Dataset
Source      : Kaggle

Project Objective
-----------------
Analyze sales, customers, products, shipping performance and market trends
using SQL and Power BI to generate actionable business insights.

Project Workflow
----------------
1. Database Setup
2. Data Import
3. Data Cleaning
4. Exploratory Data Analysis
5. Advanced SQL Analysis
6. Business Views
7. Power BI Dashboard
8. Business Insights

===============================================================================
*/

---------------------------------------------------------
-- Create Database
---------------------------------------------------------

CREATE DATABASE supply_chain_db;

---------------------------------------------------------
-- Connect to Database
---------------------------------------------------------

-- Run the following command only in psql.
-- pgAdmin users should simply connect to supply_chain_db.

/*
\c supply_chain_db
*/

---------------------------------------------------------
-- Create Schema (Optional)
---------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS analytics;

---------------------------------------------------------
-- Set Search Path
---------------------------------------------------------

SET search_path TO public;

---------------------------------------------------------
-- PostgreSQL Version
---------------------------------------------------------

SELECT version();

---------------------------------------------------------
-- Current Database
---------------------------------------------------------

SELECT current_database();

---------------------------------------------------------
-- Current Schema
---------------------------------------------------------

SELECT current_schema();

---------------------------------------------------------
-- Current User
---------------------------------------------------------

SELECT current_user;

---------------------------------------------------------
-- Timestamp
---------------------------------------------------------

SELECT CURRENT_TIMESTAMP;

---------------------------------------------------------
-- End of Setup
---------------------------------------------------------
