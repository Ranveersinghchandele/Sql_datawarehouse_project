/*

Script Name : DataWarehouse Initialization Script
Purpose     :
This script is used to initialize the DataWarehouse database environment.
It performs the following actions:
1. Drops the existing 'DataWarehouse' database (if it exists)
2. Recreates a fresh 'DataWarehouse' database
3. Creates schema layers: bronze, silver, and gold

⚠️ WARNING:
- This script will PERMANENTLY DELETE the 'DataWarehouse' database if it exists.
- All data inside the database will be LOST.
- This operation is NOT reversible.
- Use ONLY in development or controlled environments.
- Ensure no critical connections or processes are using the database.

Best Practice:
- Always review before execution.
- Do NOT run in production unless absolutely intended.
======================================================

*/

-- Switch context to system database
USE master;
GO

-- Drop the database if it exists and recreate it
/*
sys.databases → system catalog storing all DBs
SINGLE_USER WITH ROLLBACK IMMEDIATE → forces disconnect of active sessions
*/
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE Datawarehouse;
END;

CREATE DATABASE DataWarehouse;
GO

-- Switch to the newly created database
USE DataWarehouse;
GO

-- Create schema layers for medallion architecture
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
