# 🟫 Data Warehouse Bronze Layer (CRM + ERP)

## 📌 Overview

This project sets up the **Bronze Layer** of a data warehouse using SQL Server.

The Bronze layer represents **raw, ingested data** from source systems:

* CRM (Customer Relationship Management)
* ERP (Enterprise Resource Planning)

Data is stored **as-is** with minimal transformation to ensure:

* High ingestion reliability
* Schema flexibility
* Traceability of source data

---

## 🏗️ Architecture

```
Source Systems → Bronze → Silver → Gold
```

* **Bronze** → Raw data (this repo)
* **Silver** → Cleaned & standardized data
* **Gold** → Business-ready data (analytics, reporting)

---

## 📂 Tables Created

### 🔹 CRM Tables

* `crm_cust_info` → Customer information
* `crm_prd_info` → Product information
* `crm_sales_details` → Sales transactions

### 🔹 ERP Tables

* `erp_loc_a101` → Location data
* `erp_cust_az12` → Customer demographic data
* `erp_px_cat_g1v2` → Product category data

---

## ⚙️ Design Decisions

### 1. Data Types Strategy

* `VARCHAR` used for:

  * Dates (e.g., `YYYYMMDD`)
  * Uncertain or raw fields
* `INT / DECIMAL` used only when data is guaranteed numeric

👉 This prevents ingestion failures due to bad data.

---

### 2. Idempotent Scripts

Each table uses:

```sql
IF OBJECT_ID('table_name', 'U') IS NOT NULL
    DROP TABLE table_name;
```

This ensures:

* Safe re-execution
* Easy pipeline reruns

---

### 3. No Constraints in Bronze

* No primary keys
* No foreign keys
* No validations

👉 All validation is deferred to the **Silver Layer**

---

## 🚀 How to Run

1. Open SQL Server Management Studio (SSMS)
2. Connect to your database
3. Run the SQL script:

```
bronze_layer.sql
```

---

## 📈 Next Steps

* Build **Silver Layer**:

  * Data type conversions
  * Null handling
  * Standardization

* Build **Gold Layer**:

  * Aggregations
  * KPIs
  * Business reporting

---

## 🧠 Learning Outcome

This project demonstrates:

* Data warehouse layering (Bronze/Silver/Gold)
* Schema design for raw ingestion
* SQL Server DDL best practices
* ETL-ready table structures

---

## 👨‍💻 Author

Ranveer Singh (learnt and followed the project by Data with baraa) 
