



  create  table "surfalytics_dw_r_galiev"."raw"."stg_returns__dbt_tmp"


    as

  (


SELECT
    md5(cast(coalesce(cast(order_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(status as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS dwh_id,
    order_id,
    status,
    now() AS etl_timestamp
FROM "surfalytics_dw_r_galiev"."raw"."returns"
  );
