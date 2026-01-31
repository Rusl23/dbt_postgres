

SELECT
    md5(cast(coalesce(cast(order_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(order_date as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS dwh_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    order_priority,
    product_container,
    customer_name,
    customer_segment,
    zip_code,
    city,
    state,
    region,
    product_category,
    product_sub_category,
    product_name,
    unit_price,
    order_quantity,
    sales,
    profit,
    discount,
    shipping_cost,
    product_base_margin,
    now() AS etl_timestamp
FROM "surfalytics_dw_r_galiev"."raw"."orders"