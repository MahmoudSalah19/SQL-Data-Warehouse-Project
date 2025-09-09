/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/




CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	        SET @batch_start_time=GETDATE();
			PRINT '===================================== Loading The Bronze Layer =====================================';
			PRINT '';
			PRINT '---------------- Loading CRM Tables ----------------';
			SET @start_time =GETDATE();
			PRINT '>>>>>Truncating Table : bronze.crm_cust_info';
 			TRUNCATE TABLE bronze.crm_cust_info;
			PRINT '>>>>>Inserting Into Table : bronze.crm_cust_info';
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\musta\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT 'The Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds'


			PRINT '';
			PRINT '-------------';
			PRINT '';


	
			PRINT '>>>>>Truncating Table : bronze.crm_prd_info';
			SET @start_time =GETDATE();
			TRUNCATE TABLE bronze.crm_prd_info;
			PRINT '>>>>>Inserting Into Table : bronze.crm_prd_info';
			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\musta\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT 'The Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds'


			PRINT '';
			PRINT '-------------';
			PRINT '';



			PRINT '>>>>>Truncating Table : bronze.crm_sales_details';
			SET @start_time =GETDATE();
			TRUNCATE TABLE bronze.crm_sales_details;
			PRINT '>>>>>Inserting Into Table : bronze.crm_sales_details';
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\musta\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT 'The Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds'


			PRINT '';
			PRINT '';
			PRINT '';


			PRINT '---------------- Loading ERP Tables ----------------';
			PRINT '>>>>>Truncating Table : bronze.erp_cust_az12';
			SET @start_time =GETDATE();
			TRUNCATE TABLE bronze.erp_cust_az12;
			PRINT '>>>>>Inserting Into Table : bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\musta\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT 'The Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds'


			PRINT '';
			PRINT '-------------';
			PRINT '';



			PRINT '>>>>>Truncating Table : bronze.erp_loc_a101';
			SET @start_time =GETDATE();
			TRUNCATE TABLE bronze.erp_loc_a101;
			PRINT '>>>>>Inserting Into Table : bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\musta\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT 'The Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds'


			PRINT '';
			PRINT '-------------';
			PRINT '';



			PRINT '>>>>>Truncating Table : bronze.erp_px_cat_g1v2';
			SET @start_time =GETDATE();
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;
			PRINT '>>>>>Inserting Into Table : bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\musta\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT 'The Load Duration : '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds'
			SET @batch_end_time=GETDATE();


			PRINT '';
			PRINT '';
			PRINT '===================================== LOADING BRONZE LAYER IS COMPLETED SUCCESSFULLY =====================================';
			PRINT '';
			PRINT '- The Total Load Duration Of The Bronze Layer : '+CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+' seconds';

	END TRY
	BEGIN CATCH
			PRINT '************************* Error Occur *************************';
			PRINT 'Error Message : '+ ERROR_MESSAGE();
			PRINT 'This Error Occur In The Line : '+CAST(ERROR_LINE() AS NVARCHAR);
			PRINT 'This Error Occur In The Procedure : '+ERROR_PROCEDURE();
			PRINT 'Error Number : '+ CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error State : '+ CAST(ERROR_STATE() AS NVARCHAR);

	END CATCH
END
