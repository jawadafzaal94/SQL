CREATE OR REPLACE TABLE `project.dataset.user_orders` AS
WITH order_data AS (
    SELECT
        orders.user_id,
        orders.creation_time,
                    orders.total_price,
        orders.final_status,
        orders.store_id,
        users.signed_up_time,
        stores.name AS store_name
    FROM orders
    JOIN users
      ON orders.user_id = users.id
    JOIN stores
      ON orders.store_id = stores.id
),

user_order_counts AS (
    SELECT
        order_data.user_id,
        COUNT(*) AS total_orders
    FROM order_data
    GROUP BY order_data.user_id
    HAVING COUNT(*) >= 5
),

order_stats AS (
    SELECT
        order_data.user_id,
        DATE_DIFF(DATE(MAX(order_data.creation_time)), DATE(MIN(order_data.creation_time)), DAY) AS days_between_first_last_order,
        MAX(order_data.creation_time) AS last_order_time,
        AVG(order_data.total_price) AS avg_order_value,
        SUM(IF(order_data.final_status = 'DeliveredStatus', 1, 0)) * 100.0 / COUNT(*) AS pct_delivered,
        MIN(order_data.signed_up_time) AS signup_time
    FROM order_data
    JOIN user_order_counts
      ON order_data.user_id = user_order_counts.user_id
    GROUP BY order_data.user_id
),

favourite_store AS (
    SELECT
        order_data.user_id,
        order_data.store_name,
        ROW_NUMBER() OVER (
            PARTITION BY order_data.user_id
            ORDER BY COUNT(*) DESC, MAX(order_data.creation_time) DESC
        ) AS rn
    FROM order_data
    GROUP BY order_data.user_id, order_data.store_name
),

last_two_orders AS (
    SELECT
        order_data.user_id,
        order_data.creation_time,
        ROW_NUMBER() OVER (
            PARTITION BY order_data.user_id
            ORDER BY order_data.creation_time DESC
        ) AS rn
    FROM order_data
)

SELECT
    user_order_counts.user_id,
    ROUND(DATE_DIFF(DATE(order_stats.last_order_time), DATE(order_stats.signup_time), DAY), 0) AS days_since_signup,
    user_order_counts.total_orders,
    ROUND(order_stats.avg_order_value, 2) AS avg_order_value,
    favourite_store.store_name AS favourite_store,
    ROUND(order_stats.pct_delivered, 2) AS pct_delivered_orders,
    order_stats.last_order_time,
    ROUND(DATE_DIFF(DATE(order_stats.last_order_time), DATE(last_two_orders.creation_time), DAY), 0) AS days_between_last_two_orders
FROM user_order_counts
JOIN order_stats
  ON user_order_counts.user_id = order_stats.user_id
JOIN favourite_store
  ON user_order_counts.user_id = favourite_store.user_id
 AND favourite_store.rn = 1
LEFT JOIN last_two_orders
       ON user_order_counts.user_id = last_two_orders.user_id
      AND last_two_orders.rn = 2;
