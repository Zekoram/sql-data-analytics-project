/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
      This script is to create a new database named 'DataWarehouseAnalytics', after checking if it's already exist.
      If the database exists, it will be dropped and recreated. Additionally, this script create schema 'gold'.
      Followed by creating tables and inserting data into it.

WARNING:
      Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists.
      All the data in the database will be permenantly delete.
      Proceed with caution and ensure you have proper backups before running this script.
*/

-- Use Master Database
USE master;
GO

-- Check if the database already exist.
-- If yes, then drop the database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
	ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Create the Database 'DataWarehouseAnalytics'
CREATE DATABASE DataWarehouseAnalytics;
GO

-- Use DataWarehouseAnalytics Database
USE DataWarehouseAnalytics;
GO

-- Create Schemas
CREATE SCHEMA gold;
GO

-- Create tables for this schema

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	country NVARCHAR(50),
	marital_status NVARCHAR(50),
	gender NVARCHAR(50),
	birthdate DATE,
	create_date DATE
);
GO

CREATE TABLE gold.dim_products(
	product_key int,
	product_id int,
	product_number NVARCHAR(50),
	product_name NVARCHAR(50),
	category_id NVARCHAR(50),
	category NVARCHAR(50),
	subcategory NVARCHAR(50),
	maintenance NVARCHAR(50),
	cost INT,
	product_line NVARCHAR(50),
	start_date DATE
);
GO

CREATE TABLE gold.fact_sales(
	order_number NVARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INT,
	quantity INT,
	price INT
);
GO

-- Delete the data in the tables if already exist and reinsert the data.
TRUNCATE TABLE gold.dim_customers;
GO

BULK INSERT gold.dim_customers
FROM 'D:\SQL BY BARA\sql-data-analytics-project-main\sql-data-analytics-project-main\datasets\csv-files\gold.dim_customers.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.dim_products;
GO

BULK INSERT gold.dim_products
FROM 'D:\SQL BY BARA\sql-data-analytics-project-main\sql-data-analytics-project-main\datasets\csv-files\gold.dim_products.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.fact_sales;
GO

BULK INSERT gold.fact_sales
FROM 'D:\SQL BY BARA\sql-data-analytics-project-main\sql-data-analytics-project-main\datasets\csv-files\gold.fact_sales.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO



