# PastryDB: Bakery Management Database

## Overview
PastryDB is a robust database system designed to streamline operations in bakeries. It manages everything from inventory and orders to employee roles and payroll. This README outlines how to set up and use the PastryDB using SQLite, a lightweight and serverless database engine.

## Prerequisites
- SQLite3 installed on your system.
- Basic familiarity with SQL and command-line operations.

## Setup Instructions

### 1. Cloning the Repository
First, clone this repository to your local machine using:
```bash
git clone https://github.com/stevenpstansberry/CS157A_Final_Project.git
cd (Directory where Repo was cloned)
```

### 2. Creating the Database
Open your command line interface and navigate to the repository directory. Create a new SQLite database using:
```bash
sqlite3 PastryDB.db
```
This command creates a new SQLite database file named `PastryDB.db`.

### 3. Importing the Schema
With the SQLite database open, import the schema from the `PastryDB.sql` file:
```bash
.read PastryDB.sql
```


## Using the Database

- To perform operations on the database, reopen the SQLite interface with the database file:
  ```bash
  sqlite3 PastryDB.db
  ```
- You can then execute SQL commands to interact with the database. For example:
  ```sql
  SELECT * FROM EMPLOYEE;
  INSERT INTO EMPLOYEE (FIRST_NAME, LAST_NAME, ROLE_ID, ...) VALUES ('Jane', 'Doe', 1, ...);
  ```

## Database Views

### GuestMenuView
- **Description**: Provides a user-friendly display of the menu items available to guests. It includes detailed descriptions, prices, ingredients, and allergen warnings. This view supports customer-facing applications, enabling guests to make informed dining choices.

### InventoryView
- **Description**: Aids in inventory management by displaying current stock levels. Key details include quantity in inventory, shelf life, and optimal storage conditions for ingredients. This view is crucial for reducing waste and maintaining the freshness and quality of bakery products.

### ManagerPayrollView
- **Description**: Aggregates important employee details for payroll management purposes. It displays employee IDs, first and last names, roles, and corresponding hourly pay. This view is designed to assist managers with efficient payroll administration and financial oversight.

