-- =========================================================
-- Procedure Name: bronze.load_bronze
-- Purpose:
--     Loads raw data into Bronze layer tables from CRM and ERP CSV files.
--
-- Description:
--     - Truncates existing Bronze tables
--     - Performs BULK INSERT from source CSV files
--     - Tracks execution time for each load
--     - Uses TABLOCK for faster bulk loading
--     - Includes TRY-CATCH for error handling
--
-- Usage Example:
--     EXEC bronze.load_bronze;
--
-- Notes:
--     - Ensure file paths are accessible from SQL Server
--     - CSV files must have correct format (comma-separated)
--     - FIRSTROW = 2 assumes header row exists
--
-- Author: Ranveer Singh
-- =========================================================


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=====================================================';
		PRINT 'BRONZE LAYER LOADING';
		PRINT '=====================================================';

		PRINT '-----------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '-----------------------------------------------';
		-- CRM csv 1
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table bronze.crm_cust_info <<<';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>> Loading data into bronze.crm_cust_info <<<';
		BULK INSERT bronze.crm_cust_info
		FROM '\\Mac\Home\Downloads\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		set @end_time = GETDATE();
		PRINT '-----------';
		PRINT ('The load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds');
		PRINT '-----------';

		-- CRM csv 2
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table bronze.crm_prd_info <<<';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>> Loading data into bronze.crm_prd_info <<<';
		BULK INSERT bronze.crm_prd_info
		FROM '\\Mac\Home\Downloads\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '-----------';
		PRINT ('The load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds');
		PRINT '-----------';

		-- CRM csv 3
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table bronze.crm_sales_details<<<';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>> Loading data into bronze.crm_sales_details <<<';
		BULK INSERT bronze.crm_sales_details
		FROM '\\Mac\Home\Downloads\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '-----------';
		PRINT ('The load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds');
		PRINT '-----------';

		PRINT '-----------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '-----------------------------------------------';

		-- ERP csv 1
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table bronze.erp_cust_az12 <<<';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>> Loading data into bronze.erp_cust_az12 <<<';
		BULK INSERT bronze.erp_cust_az12
		FROM '\\Mac\Home\Downloads\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '-----------';
		PRINT ('The load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds');
		PRINT '-----------';

		-- ERP csv 2
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table bronze.erp_loc_a101 <<<';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>> Loading data into bronze.erp_loc_a101 <<<';
		BULK INSERT bronze.erp_loc_a101
		FROM '\\Mac\Home\Downloads\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '-----------';
		PRINT ('The load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds');
		PRINT '-----------';

		-- ERP csv 3
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table bronze.erp_px_cat_g1v2 <<<';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>> Loading data into bronze.erp_px_cat_g1v2 <<<';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM '\\Mac\Home\Downloads\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '-----------';
		PRINT ('The load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds');
		PRINT '-----------';

		SET @batch_end_time = GETDATE();
		PRINT '=====================================================';
		PRINT ('LOADING BRONZE LAYER COMPLETED SUCCESSFULLY');
		PRINT ('Total batch load duration ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds');
		PRINT '=====================================================';

	END TRY
	BEGIN CATCH
		PRINT '=====================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT 'ERROR STATE: ' + CAST(ERROR_STATE() AS VARCHAR);
		PRINT '=====================================================';
	END CATCH
END;
