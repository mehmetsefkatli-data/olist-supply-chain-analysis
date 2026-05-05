/*
===============================================================================
Step 4: Regional Bottlenecks (State-Level Logistics)
===============================================================================
Description: 
Joins the Orders and Customers tables to pinpoint geographical locations 
causing the most severe delays. This helps in understanding where new 
fulfillment centers or regional inventory positioning are needed.
*/

SELECT 
    c.customer_state AS "Customer State",
    ROUND(AVG(DATE_PART('day', o.order_delivered_customer_date - o.order_approved_at))::numeric, 1) AS "Avg Delivery Time (Days)",
    COUNT(o.order_id) AS "Total Orders"
FROM 
    olist_orders o
JOIN 
    olist_customers c ON o.customer_id = c.customer_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    c.customer_state
ORDER BY 
    "Avg Delivery Time (Days)" DESC
LIMIT 10;
