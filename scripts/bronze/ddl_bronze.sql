-- =========================================================
-- Script Name: bronze_layer.sql
-- Purpose:
--     This script creates the Bronze Layer tables for the
--     Data Warehouse project by ingesting raw data from
--     CRM and ERP source systems.
--
-- Description:
--     - Drops existing tables if they already exist
--     - Creates fresh tables under the 'bronze' schema
--     - Stores data in raw format with minimal transformation
--
-- Design Principles:
--     - Idempotent (safe to rerun multiple times)
--     - Flexible schema using VARCHAR for raw ingestion
--     - Minimal constraints (no PK/FK in bronze layer)
--     - Data type enforcement deferred to Silver layer
--
-- Source Systems:
--     - CRM (Customer, Product, Sales)
--     - ERP (Location, Customer, Product Category)
-- =========================================================


-- =========================
-- CRM TABLES
-- =========================

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(255),
    cst_lastname VARCHAR(255),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(20),
    cst_create_date VARCHAR(50)
);


IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(255),
    prd_cost DECIMAL(10,2),
    prd_line VARCHAR(100),
    prd_start_dt VARCHAR(50),
    prd_end_dt VARCHAR(50)
);


IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt VARCHAR(8),
    sls_ship_dt VARCHAR(8),
    sls_due_dt VARCHAR(8),
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);


-- =========================
-- ERP TABLES
-- =========================

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    loc_id INT,
    loc_name VARCHAR(255),
    loc_city VARCHAR(100),
    loc_state VARCHAR(100),
    loc_country VARCHAR(100)
);


IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    cid VARCHAR(50),
    bdate VARCHAR(50),
    gen VARCHAR(20)
);


IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id INT,
    cat VARCHAR(100),
    subcat VARCHAR(100),
    maintenance VARCHAR(50)
);
