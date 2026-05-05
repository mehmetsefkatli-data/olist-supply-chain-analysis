/*
Step 2: Delivery Lead Time Analysis

Description: 
Calculates the average delivery time and identifies extreme logistical 
bottlenecks (maximum delay) by calculating the date difference between 
order approval and actual delivery to the customer.
*/

SELECT 
    ROUND(AVG(DATE_PART('day', order_delivered_customer_date - order_approved_at))::numeric, 1) AS "Average Delivery Time (Days)",
    MAX(DATE_PART('day', order_delivered_customer_date - order_approved_at)) AS "Maximum Delay (Days)"
FROM 
    olist_orders
WHERE 
    order_status = 'delivered';
