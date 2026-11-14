# E-Commerce Customer Churn Analysis

## Overview
This project focuses on analyzing customer churn patterns in an e-commerce business using SQL to understand customer behavior, purchasing patterns, and factors influencing customer attrition.

## Objectives
- Analyze active and churned customers.
- Identify factors influencing customer churn.
- Explore customer purchasing and payment preferences.
- Examine customer satisfaction and complaints.
- Analyze customer returns and refund details.
- Generate insights to support customer retention strategies.

## Tools & Technologies
- MySQL
- MySQL Workbench
- SQL

## Project Workflow

### 1. Data Cleaning
- Handle missing values using mean and mode imputation.
- Identify and handle outliers.
- Remove inconsistent values.
- Standardize payment modes and categorical values.

### 2. Data Transformation
- Rename columns.
- Create `ComplaintReceived` and `ChurnStatus` columns.
- Drop unnecessary columns.

### 3. Data Exploration & Analysis
- Retrieve active and churned customer counts.
- Calculate average tenure and total cashback.
- Analyze customer complaints and satisfaction scores.
- Identify preferred payment modes and order categories.
- Explore customer behavior based on city tier, gender, and marital status.
- Analyze warehouse-to-home distance categories.
- Identify purchasing patterns and customer preferences.

### 4. Customer Returns Analysis
- Create the `customer_returns` table.
- Insert customer return records.
- Join customer and return details.
- Identify churned customers who have made complaints.

## SQL Concepts Covered
- SELECT and WHERE
- Aggregate Functions
- GROUP BY and HAVING
- ORDER BY and LIMIT
- CASE Statements
- Subqueries
- JOIN Operations

## Key Learnings
- Practical application of SQL for data cleaning.
- Working with aggregate functions and subqueries.
- Understanding customer churn patterns.
- Analyzing customer behavior and purchasing trends.
- Combining multiple tables using joins.

## Conclusion
This project demonstrates how SQL can be used to clean, transform, and analyze e-commerce customer data to identify churn patterns and generate actionable business insights.
