/*===================================================================
                   DATA WAREHOUSE INITIALIZATION SCRIPT          
===================================================================*/

/*
=============================================================
SCRIPT PURPOSE
=============================================================
This script performs a full reset of the 'DataWarehouse' 
environment by:
1. Dropping existing database (if present) with active connections
2. Creating a fresh database with UTF-8 collation
3. Establishing standard medallion architecture schemas:
   - bronze: Raw/landing zone data
   - silver: Cleaned/validated data  
   - gold: Business-ready aggregated data

WARNING: THIS IS DESTRUCTIVE OPERATION
=============================================================
- Destroys all existing database objects and data permanently
- Requires SYSTEM ADMIN privileges
- Execute only in development/test environments
- Ensure backups exist before running in production
=============================================================
*/


USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
