{{ config(
  materialized='incremental',
  incremental_strategy='append',
  unique_key=['dwh_id'],
  alias='stg_orders_append'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['order_id', 'order_date', 'ship_date', 'ship_mode', 'order_priority', 'product_container', 'customer_name', 'customer_segment', 'zip_code', 'city', 'state', 'region', 'product_category', 'product_sub_category', 'product_name', 'unit_price', 'order_quantity', 'sales', 'profit', 'discount', 'shipping_cost', 'product_base_margin']) }} AS dwh_id,
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
    {{ dbt.current_timestamp() }} AS etl_timestamp
FROM {{source ('raw','orders')}}
{% if is_incremental() %}
    WHERE order_date >= (SELECT max(order_date) FROM {{ this }}) - interval '7 day'
{% endif %}
