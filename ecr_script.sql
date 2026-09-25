#Creating a database
CREATE DATABASE IF NOT EXISTS ecr_db;

#Using the created database(here, rfm_db)
USE ecr_db;

#Configurations
SET SQL_SAFE_UPDATES = 0;
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE "secure_file_priv";


#Deleting rows when needed(here, data_raw is a sample)
DELETE FROM data_raw;

#Dropping rows when needed(here, data_raw is a sample)
DROP TABLE dats_raw;

#Importing table data(rows) manually(using INFILE)(here, data.csv is a sample)
LOAD DATA LOCAL INFILE "g:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data.csv"
INTO TABLE data_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

#Describing Table(here, data_raw is a sample)
DESCRIBE data_raw;

#Data at a glance(here, data_raw is a sample)
SELECT * FROM data_raw LIMIT 10;

#Creating 9 raw tables
#1. Customers Table
CREATE TABLE IF NOT EXISTS raw_customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

#2. Geolocation Table
CREATE TABLE IF NOT EXISTS raw_geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

#3. Order Items Table
CREATE TABLE IF NOT EXISTS raw_order_items (
    order_id VARCHAR(50),
    order_item_id VARCHAR(10),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price VARCHAR(30),
    freight_value VARCHAR(30)
);

#4. Order Payments Table
CREATE TABLE IF NOT EXISTS raw_order_payments (
    order_id VARCHAR(50),
    payment_sequential VARCHAR(10),
    payment_type VARCHAR(50),
    payment_installments VARCHAR(10),
    payment_value VARCHAR(30)
);

#5. Order Reviews Table
CREATE TABLE IF NOT EXISTS raw_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score VARCHAR(10),
    review_comment_title LONGTEXT,
    review_comment_message LONGTEXT,
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);

#6. Orders Table
CREATE TABLE IF NOT EXISTS raw_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);

#7. Products Table
CREATE TABLE IF NOT EXISTS raw_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght VARCHAR(20),
    product_description_lenght VARCHAR(20),
    product_photos_qty VARCHAR(20),
    product_weight_g VARCHAR(20),
    product_length_cm VARCHAR(20),
    product_height_cm VARCHAR(20),
    product_width_cm VARCHAR(20)
);

#8. Sellers Table
CREATE TABLE IF NOT EXISTS raw_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

#9. Product Category Translation Table
CREATE TABLE IF NOT EXISTS raw_product_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);

#Imporing all daa with infile
#1. raw_cusomers
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv"
INTO TABLE raw_customers
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_customers LIMIT 10;
SELECT COUNT(*) FROM raw_customers LIMIT 10;


#2. raw_geolocation
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv"
INTO TABLE raw_geolocation
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_geolocation LIMIT 10;
SELECT COUNT(*) FROM raw_geolocation LIMIT 10;


#3. raw_order_items
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv"
INTO TABLE raw_order_items
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_order_items LIMIT 10;
SELECT COUNT(*) FROM raw_order_items LIMIT 10;


#4. raw_order_payments
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv"
INTO TABLE raw_order_payments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_order_payments LIMIT 10;
SELECT COUNT(*) FROM raw_order_payments LIMIT 10;


#5. raw_order_reviews
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv"
INTO TABLE raw_order_reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT * FROM raw_order_reviews LIMIT 10;
SELECT COUNT(*) FROM raw_order_reviews LIMIT 10;


#6. raw_orders
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv"
INTO TABLE raw_orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_orders LIMIT 10;
SELECT COUNT(*) FROM raw_orders LIMIT 10;


#7. raw_product_category_translation
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv"
INTO TABLE raw_product_category_translation
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_product_category_translation LIMIT 10;
SELECT COUNT(*) FROM raw_product_category_translation LIMIT 10;


#8. raw_products
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv"
INTO TABLE raw_products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_products LIMIT 10;
SELECT COUNT(*) FROM raw_products LIMIT 10;


#9. raw_sellers
#Importing table data(rows) manually(using INFILE), here(the file location is a sample)
LOAD DATA LOCAL INFILE "g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv"
INTO TABLE raw_sellers
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM raw_sellers LIMIT 10;
SELECT COUNT(*) FROM raw_sellers LIMIT 10;

#Checking for nulls or invalid data across the tables
#1. Checking raw_customers
SELECT 
    COUNT(*) AS total_rows,
    SUM(customer_id IS NULL OR TRIM(customer_id) = '') AS null_or_blank_customer_id,
    SUM(customer_unique_id IS NULL OR TRIM(customer_unique_id) = '') AS null_or_blank_customer_unique_id,
    SUM(customer_zip_code_prefix IS NULL OR TRIM(customer_zip_code_prefix) = '') AS null_or_blank_zip,
    SUM(customer_city IS NULL OR TRIM(customer_city) = '') AS null_or_blank_city,
    SUM(customer_state IS NULL OR TRIM(customer_state) = '') AS null_or_blank_state
FROM raw_customers;


#2. Checking raw_geolocation
SELECT 
    COUNT(*) AS total_rows,
    SUM(geolocation_zip_code_prefix IS NULL OR TRIM(geolocation_zip_code_prefix) = '') AS null_or_blank_zip,
    SUM(geolocation_lat IS NULL) AS null_lat,
    SUM(geolocation_lng IS NULL) AS null_lng,
    SUM(geolocation_city IS NULL OR TRIM(geolocation_city) = '') AS null_or_blank_city,
    SUM(geolocation_state IS NULL OR TRIM(geolocation_state) = '') AS null_or_blank_state
FROM raw_geolocation;


#3. Checking raw_order_items
SELECT 
    COUNT(*) AS total_rows,
    SUM(order_id IS NULL OR TRIM(order_id) = '') AS null_or_blank_order_id,
    SUM(order_item_id IS NULL) AS null_order_item_id,
    SUM(product_id IS NULL OR TRIM(product_id) = '') AS null_or_blank_product_id,
    SUM(seller_id IS NULL OR TRIM(seller_id) = '') AS null_or_blank_seller_id,
    SUM(shipping_limit_date IS NULL) AS null_shipping_limit_date,
    SUM(price IS NULL OR price < 0) AS invalid_price,
    SUM(freight_value IS NULL OR freight_value < 0) AS invalid_freight
FROM raw_order_items;


#4. Checking raw_order_payments
SELECT 
    COUNT(*) AS total_rows,
    SUM(order_id IS NULL OR TRIM(order_id) = '') AS null_or_blank_order_id,
    SUM(payment_sequential IS NULL) AS null_payment_seq,
    SUM(payment_type IS NULL OR TRIM(payment_type) = '') AS null_or_blank_payment_type,
    SUM(payment_installments IS NULL) AS null_installments,
    SUM(payment_value IS NULL OR payment_value < 0) AS invalid_payment_value
FROM raw_order_payments;


#5. Checking raw_order_reviews
SELECT 
    COUNT(*) AS total_rows,
    SUM(review_id IS NULL OR TRIM(review_id) = '') AS null_or_blank_review_id,
    SUM(order_id IS NULL OR TRIM(order_id) = '') AS null_or_blank_order_id,
    SUM(review_score IS NULL OR review_score NOT BETWEEN 1 AND 5) AS invalid_score,
    SUM(review_comment_title IS NULL OR TRIM(review_comment_title) = '') AS null_or_blank_titles,
    SUM(review_comment_message IS NULL OR TRIM(review_comment_message) = '') AS null_or_blank_messages
FROM raw_order_reviews;


#6. Checking raw_orders
SELECT 
    COUNT(*) AS total_rows,
    SUM(order_id IS NULL OR TRIM(order_id) = '') AS null_or_blank_order_id,
    SUM(customer_id IS NULL OR TRIM(customer_id) = '') AS null_or_blank_customer_id,
    SUM(order_status IS NULL OR TRIM(order_status) = '') AS null_or_blank_status,
    SUM(order_purchase_timestamp IS NULL) AS null_purchase_date,
    SUM(order_approved_at IS NULL) AS null_approved_date,
    SUM(order_delivered_carrier_date IS NULL) AS null_delivered_carrier_date,
    SUM(order_delivered_customer_date IS NULL) AS null_delivered_customer_date,
    SUM(order_estimated_delivery_date IS NULL) AS null_estimated_delivery_date
FROM raw_orders;


#7. Checking raw_product_category_translation
SELECT 
    COUNT(*) AS total_rows,
    SUM(product_category_name IS NULL OR TRIM(product_category_name) = '') AS null_or_blank_category_pt,
    SUM(product_category_name_english IS NULL OR TRIM(product_category_name_english) = '') AS null_or_blank_category_en
FROM raw_product_category_translation;


#8. Checking raw_products
SELECT 
    COUNT(*) AS total_rows,
    SUM(product_id IS NULL OR TRIM(product_id) = '') AS null_or_blank_product_id,
    SUM(product_category_name IS NULL OR TRIM(product_category_name) = '') AS null_or_blank_category,
    SUM(product_name_lenght IS NULL OR product_name_lenght <= 0) AS invalid_name_length,
    SUM(product_description_lenght IS NULL OR product_description_lenght <= 0) AS invalid_description_length,
    SUM(product_photos_qty IS NULL OR product_photos_qty < 0) AS invalid_photos_qty,
    SUM(product_weight_g IS NULL OR product_weight_g <= 0) AS invalid_weight,
    SUM(product_height_cm IS NULL OR product_height_cm <= 0) AS invalid_height,
    SUM(product_width_cm IS NULL OR product_width_cm <= 0) AS invalid_width
FROM raw_products;


#9. Checking raw_sellers
SELECT 
    COUNT(*) AS total_rows,
    SUM(seller_id IS NULL OR TRIM(seller_id) = '') AS null_or_blank_seller_id,
    SUM(seller_zip_code_prefix IS NULL OR TRIM(seller_zip_code_prefix) = '') AS null_or_blank_zip,
    SUM(seller_city IS NULL OR TRIM(seller_city) = '') AS null_or_blank_city,
    SUM(seller_state IS NULL OR TRIM(seller_state) = '') AS null_or_blank_state
FROM raw_sellers;

#The olist data is already very cleaned so we have to deal wih only missing or nulls
#There is no mismatched or numeric strings in invalid places( checked with regexp)
# '^-?[0-9]+$'
# '^+?[0-9]+$'
# '^(-|\\+)?([0-9]+\\.[0-9]*|[0-9]*\\.[0-9]+|[0-9]+)$'
#We will move on to a final check for the datetime format

#For table 3
WITH dateTime_data AS (
	SELECT shipping_limit_date AS raw_date,
    CASE
		WHEN STR_TO_DATE(`shipping_limit_date`, '%m/%d/%Y %H:%i') IS NOT NULL THEN 'df1'
        WHEN STR_TO_DATE(`shipping_limit_date`, '%d/%m/%Y %H:%i') IS NOT NULL THEN 'df2'
        WHEN STR_TO_DATE(`shipping_limit_date`, '%Y-%m-%d %H:%i:%s') IS NOT NULL THEN 'df3'
        WHEN STR_TO_DATE(`shipping_limit_date`, '%m/%d/%y %H:%i') IS NOT NULL THEN 'df4'
        ELSE NULL
	END AS date_format
    FROM raw_order_items
    )
    SELECT * FROM datetime_data WHERE date_format != 'df3';
    
#For table 5
WITH dateTime_data AS (
	SELECT review_creation_date AS raw_date,
    CASE
		WHEN STR_TO_DATE(`review_creation_date`, '%m/%d/%Y %H:%i') IS NOT NULL THEN 'df1'
        WHEN STR_TO_DATE(`review_creation_date`, '%d/%m/%Y %H:%i') IS NOT NULL THEN 'df2'
        WHEN STR_TO_DATE(`review_creation_date`, '%Y-%m-%d %H:%i:%s') IS NOT NULL THEN 'df3'
        WHEN STR_TO_DATE(`review_creation_date`, '%m/%d/%y %H:%i') IS NOT NULL THEN 'df4'
        ELSE NULL
	END AS date_format
    FROM raw_order_reviews
    )
    SELECT * FROM datetime_data WHERE date_format != 'df3';
    
#For table 6
WITH dateTime_data AS (
	SELECT order_delivered_carrier_date AS raw_date,
    CASE
		WHEN STR_TO_DATE(`order_delivered_carrier_date`, '%m/%d/%Y %H:%i') IS NOT NULL THEN 'df1'
        WHEN STR_TO_DATE(`order_delivered_carrier_date`, '%d/%m/%Y %H:%i') IS NOT NULL THEN 'df2'
        WHEN STR_TO_DATE(`order_delivered_carrier_date`, '%Y-%m-%d %H:%i:%s') IS NOT NULL THEN 'df3'
        WHEN STR_TO_DATE(`order_delivered_carrier_date`, '%m/%d/%y %H:%i') IS NOT NULL THEN 'df4'
        ELSE NULL
	END AS date_format
    FROM raw_orders
    )
    SELECT * FROM datetime_data WHERE date_format != 'df3';
    
WITH dateTime_data AS (
	SELECT order_delivered_customer_date AS raw_date,
    CASE
		WHEN STR_TO_DATE(`order_delivered_customer_date`, '%m/%d/%Y %H:%i') IS NOT NULL THEN 'df1'
        WHEN STR_TO_DATE(`order_delivered_customer_date`, '%d/%m/%Y %H:%i') IS NOT NULL THEN 'df2'
        WHEN STR_TO_DATE(`order_delivered_customer_date`, '%Y-%m-%d %H:%i:%s') IS NOT NULL THEN 'df3'
        WHEN STR_TO_DATE(`order_delivered_customer_date`, '%m/%d/%y %H:%i') IS NOT NULL THEN 'df4'
        ELSE NULL
	END AS date_format
    FROM raw_orders
    )
    SELECT * FROM datetime_data WHERE date_format != 'df3';
    
WITH dateTime_data AS (
	SELECT order_estimated_delivery_date AS raw_date,
    CASE
		WHEN STR_TO_DATE(`order_estimated_delivery_date`, '%m/%d/%Y %H:%i') IS NOT NULL THEN 'df1'
        WHEN STR_TO_DATE(`order_estimated_delivery_date`, '%d/%m/%Y %H:%i') IS NOT NULL THEN 'df2'
        WHEN STR_TO_DATE(`order_estimated_delivery_date`, '%Y-%m-%d %H:%i:%s') IS NOT NULL THEN 'df3'
        WHEN STR_TO_DATE(`order_estimated_delivery_date`, '%m/%d/%y %H:%i') IS NOT NULL THEN 'df4'
        ELSE NULL
	END AS date_format
    FROM raw_orders
    )
    SELECT * FROM datetime_data WHERE date_format != 'df3';
    
#A detailed analysis shows only 1 datetime format is present

#Creating cleaned tables with appropriate datatype and data
#1. Cleaned Customers Table
CREATE TABLE customers AS
SELECT 
    TRIM(customer_id) AS customer_id,
    TRIM(customer_unique_id) AS customer_unique_id,
    TRIM(customer_zip_code_prefix) AS customer_zip_code_prefix,
    TRIM(customer_city) AS customer_city,
    TRIM(customer_state) AS customer_state
FROM raw_customers;

#2. Cleaned & Deduplicated Geolocation Table
CREATE TABLE geolocation AS
SELECT 
    TRIM(geolocation_zip_code_prefix) AS geolocation_zip_code_prefix,
    AVG(CAST(geolocation_lat AS DECIMAL(10,8))) AS geolocation_lat,
    AVG(CAST(geolocation_lng AS DECIMAL(11,8))) AS geolocation_lng,
    MAX(TRIM(geolocation_city)) AS geolocation_city,
    MAX(TRIM(geolocation_state)) AS geolocation_state
FROM raw_geolocation
GROUP BY TRIM(geolocation_zip_code_prefix);

#3. Cleaned Order Items Table
CREATE TABLE order_items AS
SELECT 
    TRIM(order_id) AS order_id,
    CAST(order_item_id AS UNSIGNED) AS order_item_id,
    TRIM(product_id) AS product_id,
    TRIM(seller_id) AS seller_id,
    STR_TO_DATE(NULLIF(TRIM(shipping_limit_date), ''), '%Y-%m-%d %H:%i:%s') AS shipping_limit_date,
    CAST(price AS DECIMAL(10,2)) AS price,
    CAST(freight_value AS DECIMAL(10,2)) AS freight_value
FROM raw_order_items;

#4. Cleaned Order Payments Table
CREATE TABLE order_payments AS
SELECT 
    TRIM(order_id) AS order_id,
    CAST(payment_sequential AS UNSIGNED) AS payment_sequential,
    TRIM(payment_type) AS payment_type,
    CAST(payment_installments AS UNSIGNED) AS payment_installments,
    CAST(payment_value AS DECIMAL(10,2)) AS payment_value
FROM raw_order_payments;

#5. Cleaned Order Reviews Table
CREATE TABLE order_reviews AS
SELECT 
    TRIM(review_id) AS review_id,
    TRIM(order_id) AS order_id,
    CAST(review_score AS UNSIGNED) AS review_score,
    COALESCE(NULLIF(TRIM(review_comment_title), ''), 'No Comment Title') AS review_comment_title,
    COALESCE(NULLIF(TRIM(review_comment_message), ''), 'No Comment Message') AS review_comment_message,
    STR_TO_DATE(NULLIF(TRIM(review_creation_date), ''), '%Y-%m-%d %H:%i:%s') AS review_creation_date,
    STR_TO_DATE(NULLIF(TRIM(review_answer_timestamp), ''), '%Y-%m-%d %H:%i:%s') AS review_answer_timestamp
FROM raw_order_reviews;

#6. Cleaned Orders Table
CREATE TABLE orders AS
SELECT 
    TRIM(order_id) AS order_id,
    TRIM(customer_id) AS customer_id,
    TRIM(order_status) AS order_status,
    STR_TO_DATE(NULLIF(TRIM(order_purchase_timestamp), ''), '%Y-%m-%d %H:%i:%s') AS order_purchase_timestamp,
    STR_TO_DATE(NULLIF(TRIM(order_approved_at), ''), '%Y-%m-%d %H:%i:%s') AS order_approved_at,
    STR_TO_DATE(NULLIF(TRIM(order_delivered_carrier_date), ''), '%Y-%m-%d %H:%i:%s') AS order_delivered_carrier_date,
    STR_TO_DATE(NULLIF(TRIM(order_delivered_customer_date), ''), '%Y-%m-%d %H:%i:%s') AS order_delivered_customer_date,
    STR_TO_DATE(NULLIF(TRIM(order_estimated_delivery_date), ''), '%Y-%m-%d %H:%i:%s') AS order_estimated_delivery_date
FROM raw_orders;

#7. Cleaned Product Category Translation Table
CREATE TABLE product_category_translation AS
SELECT 
    TRIM(product_category_name) AS product_category_name,
    TRIM(product_category_name_english) AS product_category_name_english
FROM raw_product_category_translation;

#8. Cleaned Products Table
CREATE TABLE products AS
SELECT 
    TRIM(product_id) AS product_id,
    COALESCE(NULLIF(TRIM(product_category_name), ''), 'uncategorized') AS product_category_name,
    CAST(NULLIF(TRIM(product_name_lenght), '') AS UNSIGNED) AS product_name_length,
    CAST(NULLIF(TRIM(product_description_lenght), '') AS UNSIGNED) AS product_description_length,
    CAST(NULLIF(TRIM(product_photos_qty), '') AS UNSIGNED) AS product_photos_qty,
    CAST(NULLIF(TRIM(product_weight_g), '') AS DECIMAL(10,2)) AS product_weight_g,
    CAST(NULLIF(TRIM(product_length_cm), '') AS DECIMAL(10,2)) AS product_length_cm,
    CAST(NULLIF(TRIM(product_height_cm), '') AS DECIMAL(10,2)) AS product_height_cm,
    CAST(NULLIF(TRIM(product_width_cm), '') AS DECIMAL(10,2)) AS product_width_cm
FROM raw_products;

#9. Cleaned Sellers Table
CREATE TABLE sellers AS
SELECT 
    TRIM(seller_id) AS seller_id,
    TRIM(seller_zip_code_prefix) AS seller_zip_code_prefix,
    TRIM(seller_city) AS seller_city,
    TRIM(seller_state) AS seller_state
FROM raw_sellers;

#Adding Primary Keys based on the relational schema for the olist dataset at kaggle
ALTER TABLE customers ADD PRIMARY KEY (customer_id);
ALTER TABLE products ADD PRIMARY KEY (product_id);
ALTER TABLE sellers ADD PRIMARY KEY (seller_id);
ALTER TABLE orders ADD PRIMARY KEY (order_id);
ALTER TABLE order_items ADD PRIMARY KEY (order_id, order_item_id);
ALTER TABLE order_payments ADD PRIMARY KEY (order_id, payment_sequential);
ALTER TABLE order_reviews ADD PRIMARY KEY (review_id, order_id);
ALTER TABLE geolocation ADD PRIMARY KEY (geolocation_zip_code_prefix);
ALTER TABLE product_category_translation ADD PRIMARY KEY (product_category_name);

#Adding Performance Indexes on Foreign Keys & Date Columns
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_purchase_date ON orders(order_purchase_timestamp);
CREATE INDEX idx_items_product ON order_items(product_id);
CREATE INDEX idx_items_seller ON order_items(seller_id);

#At this point we have successfully cleaned and organised the table
#Missing values have been replaced by appropriate tags
#And some fields with nulls are kept as it is without deletion so it does not inflates or dwflates calculation
#We will now create tables for extracting insights as well as these will be used by other tools

#1. Monthly Revenue Metrics
CREATE TABLE monthly_revenue_metrics AS
WITH monthly_base AS (
    SELECT 
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS sales_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(oi.order_item_id) AS total_items_sold,
        ROUND(SUM(oi.price), 2) AS product_revenue,
        ROUND(SUM(oi.freight_value), 2) AS total_freight,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS gross_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
      AND o.order_purchase_timestamp IS NOT NULL
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
),
monthly_calc AS (
    SELECT 
        sales_month,
        total_orders,
        total_items_sold,
        product_revenue,
        total_freight,
        gross_revenue,
        ROUND(gross_revenue / NULLIF(total_orders, 0), 2) AS average_order_value,
        LAG(gross_revenue, 1) OVER (ORDER BY sales_month) AS prior_month_revenue,
        SUM(gross_revenue) OVER (ORDER BY sales_month) AS running_total_revenue
    FROM monthly_base
)
SELECT 
    sales_month,
    total_orders,
    total_items_sold,
    product_revenue,
    total_freight,
    gross_revenue,
    average_order_value,
    prior_month_revenue,
    ROUND(((gross_revenue - prior_month_revenue) / NULLIF(prior_month_revenue, 0)) * 100, 2) AS mom_growth_pct,
    running_total_revenue
FROM monthly_calc
ORDER BY sales_month ASC;

#2. Customer Cohorts
CREATE TABLE customer_cohorts AS
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_order_timestamp,
        MAX(o.order_purchase_timestamp) AS latest_order_timestamp,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS lifetime_value
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY c.customer_unique_id
)
SELECT 
    customer_unique_id,
    DATE_FORMAT(first_order_timestamp, '%Y-%m') AS cohort_month,
    first_order_timestamp,
    latest_order_timestamp,
    total_orders,
    COALESCE(lifetime_value, 0) AS lifetime_value
FROM customer_orders;

#3. Product Performance
CREATE TABLE product_performance AS
SELECT 
    p.product_id,
    p.product_category_name,
    COALESCE(pct.product_category_name_english, p.product_category_name) AS category_name_english,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(oi.order_item_id) AS total_units_sold,
    ROUND(SUM(oi.price), 2) AS total_product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS total_freight_cost,
    ROUND(AVG(oi.price), 2) AS avg_unit_price,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM products p
LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY p.product_id, p.product_category_name, pct.product_category_name_english;

#4. Delivery Performance
CREATE TABLE delivery_performance AS
SELECT 
    o.order_id,
    o.customer_id,
    c.customer_state,
    c.customer_city,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    ROUND(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp), 1) AS actual_delivery_days,
    ROUND(DATEDIFF(o.order_estimated_delivery_date, o.order_purchase_timestamp), 1) AS estimated_delivery_days,
    ROUND(DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date), 1) AS delay_days,
    CASE 
        WHEN o.order_delivered_customer_date IS NULL THEN 'Undelivered'
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On-Time'
        ELSE 'Delayed'
    END AS delivery_status,
    r.review_score
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;
  
#5. Item Price Freight Extract
CREATE TABLE item_price_freight_extract AS
SELECT 
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    COALESCE(pct.product_category_name_english, p.product_category_name) AS category_name_english,
    oi.price,
    oi.freight_value,
    ROUND((oi.freight_value / NULLIF(oi.price, 0)) * 100, 2) AS freight_to_price_ratio_pct,
    c.customer_state,
    c.customer_city,
    s.seller_state,
    s.seller_city
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN sellers s ON oi.seller_id = s.seller_id
WHERE o.order_status NOT IN ('canceled', 'unavailable');

#New tables at a glance
SELECT * FROM monthly_revenue_metrics;
SELECT * FROM customer_cohorts;
SELECT * FROM product_performance;
SELECT * FROM delivery_performance;
SELECT * FROM item_price_freight_extract;