/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database along with the list of tables and their schema.
    - To inspect the columns and metadata for a specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

USE DataWarehouseAnalytics;
GO

-- Retrieve a list of all tables in the database
SELECT 
	TABLE_CATALOG,
	TABLE_SCHEMA,
	TABLE_NAME,
	TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;
GO

-- Retrieve all columns for a specific table (dim_customers)
SELECT
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
GO
