{{ config(
  materialized='table',
  alias='stg_managers'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['manager', 'region']) }} AS dwh_id,
    manager AS manager_name,
    region,
    {{ dbt.current_timestamp() }} AS etl_timestamp
FROM {{source('raw','users')}}
