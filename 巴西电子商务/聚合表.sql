CREATE OR REPLACE VIEW v_master_ecommerce_data AS
SELECT 
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    oi.order_item_id,
    oi.product_id,
    oi.price,
    oi.freight_value,
    
    p.product_category_name,
    IFNULL(t.product_category_name_english, 'Unknown') AS category_english,
    p.product_photos_qty,
    p.product_weight_g,
    
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    cg.lat AS customer_lat,
    cg.lng AS customer_lng,
    
    s.seller_id,
    s.seller_city,
    s.seller_state,
    
    -- aggregated review metrics (order level)
    r.review_score,
    r.review_comment_message,

    -- aggregated payment info (pre-aggregated by order to avoid Cartesian duplication)
    pay.payment_total,
    pay.payment_installments,
    pay.payment_types

FROM olist_order_items_dataset oi
LEFT JOIN olist_orders_dataset o ON oi.order_id = o.order_id
LEFT JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
LEFT JOIN olist_products_dataset p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
LEFT JOIN olist_sellers_dataset s ON oi.seller_id = s.seller_id

-- aggregate reviews to order level to prevent duplicates when joining to items
LEFT JOIN (
  SELECT
    order_id,
    AVG(review_score) AS review_score,
    MAX(review_comment_message) AS review_comment_message,
    COUNT(*) AS review_count
  FROM olist_order_reviews_dataset
  GROUP BY order_id
) r ON oi.order_id = r.order_id

LEFT JOIN v_unique_geolocation cg ON c.customer_zip_code_prefix = cg.zip_code

-- aggregate payments to order level before joining to avoid multiplying payments by number of items
LEFT JOIN (
  SELECT
    order_id,
    SUM(payment_value) AS payment_total,
    -- use a representative installments value for the order (e.g. max installments among payments)
    IFNULL(MAX(payment_installments), 1) AS payment_installments,
    -- list of payment types used for the order
    GROUP_CONCAT(DISTINCT payment_type ORDER BY payment_type SEPARATOR ',') AS payment_types
  FROM olist_order_payments_dataset
  /* 若你只想统计已确认/已支付的流水，请取消下面注释并替换为真实的状态字段与取值，例如:
     WHERE payment_status IN ('approved','paid') 
  */
  GROUP BY order_id
) pay ON oi.order_id = pay.order_id;
