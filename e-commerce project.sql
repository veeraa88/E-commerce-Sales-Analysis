CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE sales_data (
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(100),
    Product_Category VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    Discount VARCHAR(10),
    Revenue DECIMAL(15,2),
    Profit DECIMAL(15,2),
    Order_ID VARCHAR(20),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Customer_Segment VARCHAR(50),
    Purchase_Date DATE,
    Delivery_Date DATE,
    Payment_Mode VARCHAR(50),
    Product_Rating DECIMAL(3,1)
);
select * from sales_data;


-- 1.Total Revenue of All Orders
 select sum(revenue) as total_revenue from sales_data ;
 
 -- 2. Total Profit of All Orders
 select sum(profit) as total_profit from sales_data;
 
 --  3. Revenue by Product Category
 select product_category,sum(revenue)  as revenue
 from sales_data group by product_category order by revenue desc;
 
 -- 4.Top 5 Products by Revenue
 select product_name,sum(revenue) as total_revenue
 from sales_data group by product_name order by total_revenue desc
 limit 5;
 
 -- 5.Total Revenue by Payment Mode
 select payment_mode,sum(revenue) as total_revenue 
 from sales_data group by payment_mode order by total_revenue desc; 
 
 -- 6.Monthly Sales Trend (Revenue per Month)
select monthname(purchase_date) as months,sum(revenue) as total_revenue
from sales_data group by monthname(purchase_date) order by months,total_revenue ;
 
 -- 7. Average Product Rating by Product Category
 select product_category,avg(product_rating) as average_rating
 from sales_data group by product_category order by average_rating desc;
 
 -- 8. Top 5 Customers by Revenue
  select customer_name,customer_city,sum(revenue) as total_revenue
  from sales_data group by customer_id,customer_name,customer_city
  order by total_revenue desc limit 5;
  
  --  9. Number of Orders per Customer Segment
 select customer_segment,count(order_id) as number_of_order
 from sales_data group by customer_segment order by number_of_order desc;
 
 -- 10. Average Delivery Time (in Days) by City
 select customer_city,avg(datediff(delivery_date ,purchase_date)) as avg_deli_time
 from sales_data group by customer_city order by avg_deli_time;
 
 -- 11. Top 3 Products by Revenue in Each Category
 select product_category,product_name,sum(revenue) as total_revenue
 from sales_data group by product_category,product_name order by product_category,total_revenue desc limit 3;
 
 -- 12.Best Customer in Each City by Revenue
 select customer_city,customer_name,sum(revenue) as total_revenue
 from sales_data group by customer_city,customer_id,customer_name order by customer_city,total_revenue desc;
 
 -- 13. Total Discount Amount Given per Product Category
 SELECT Product_Category,SUM((Price * Quantity) * (SUBSTRING_INDEX(Discount, '%', 1) / 100)) AS Total_Discount
FROM sales_data
GROUP BY Product_Category
ORDER BY Total_Discount DESC;

-- 14.Find Customers with Multiple Orders
SELECT Customer_ID, Customer_Name, COUNT(DISTINCT Order_ID) AS Total_Orders
FROM sales_data GROUP BY Customer_ID, Customer_Name
HAVING Total_Orders > 1
ORDER BY Total_Orders DESC;

-- 15.Which Month Had the Highest Revenue?
SELECT DATE_FORMAT(Purchase_Date, '%Y-%m') AS Months, SUM(Revenue) AS Monthly_Revenue
FROM sales_data GROUP BY Months ORDER BY Monthly_Revenue DESC
LIMIT 1;



 
 
 
 
 
 
 
 
 
 
  