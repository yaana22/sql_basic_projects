--sql retail sales analysis p1
--create table
CREATE TABLE retail_sales
(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category 	VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT

);

select * from retail_sales
limit 10

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

__data cleaning

select * from retail_sales
where 
sale_date is null 
or
age is null
or
category is null
or 
quantiy is null
or
transactions_id is null
or
sale_time is null
or
price_per_unit is null
or
cogs is null
or 
total_sale is null
or
customer_id is null
or
gender is null




delete from retail_sales
where
sale_date is null
or
age is null
or
category is null
or 
quantiy is null
or
transactions_id is null
or
sale_time is null
or
price_per_unit is null
or
cogs is null
or 
total_sale is null
or
customer_id is null
or
gender is null

--data exploration
--how many sales do we have 
select count(*) as total_sales from retail_sales

--how many unique  customers do we have 
select count(DISTINCT customer_id) as total_sales from retail_sales

select DISTINCT CATEGORY  from retail_sale


--DATA ANALYSIS AND BUSINESS KEY PROBLEMS 
--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity of the month of Nov-2022.
--3.Write a SQL query to calculate the total sales (total_sale) for each category.
--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender.
--7.Write a SQL query to calculate the average sale for each month. Find out the best selling month in each... (the rest of the question is cut off).
--8.Write a SQL query to find the top 5 customers based on the highest total sales.
--9.Write a SQL query to find the number of unique customers who purchased items from each category.
--10.Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Betw...).



--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
GROUP BY 1

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender.
SELECT
    gender,
    COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY gender;

-- Q.7 Write a SQL query to calculate the average sale for each month.
SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS sale_month,
    AVG(total_sale) AS average_sale
FROM retail_sales
GROUP BY sale_month
ORDER BY sale_month;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customer_count
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning...)

WITH hourly_sale AS (
    SELECT
        *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

--END OF PROJECT