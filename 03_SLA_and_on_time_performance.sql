/*
===============================================================================
Step 3: SLA & On-Time Delivery (OTD) Compliance
===============================================================================
Description: 
Measures the supply chain reliability by calculating the percentage of 
orders that were delivered before or exactly on the promised estimated date.
Utilizes CASE WHEN statements to create aggregated delivery metrics.
*/

SELECT 
    COUNT(order_id) AS "Total Delivered Orders",
    
    -- Count on-time deliveries
    SUM(CASE WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1 ELSE 0 END) AS "On-Time Deliveries",
    
    -- Count late deliveries
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS "Late Deliveries",
    
    -- Calculate Success Rate: (On-Time / Total) * 100
    ROUND(
        (SUM(CASE WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1 ELSE 0 END)::numeric / COUNT(order_id)) * 100
    , 2) AS "On-Time Delivery Rate (%)"
    
FROM 
    olist_orders
WHERE 
    order_status = 'delivered';
