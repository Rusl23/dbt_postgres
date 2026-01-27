{{ config(
  materialized='table',
  alias='stg_returns'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['order_id', 'status']) }} AS dwh_id,
    order_id,
    status,
    {{ dbt.current_timestamp() }} AS etl_timestamp
FROM {{source('raw','returns')}}
