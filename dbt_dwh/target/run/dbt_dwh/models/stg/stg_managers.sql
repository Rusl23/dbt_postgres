



  create  table "surfalytics_dw_r_galiev"."raw"."stg_managers__dbt_tmp"


    as

  (


SELECT
    md5(cast(coalesce(cast(manager as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(region as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS dwh_id,
    manager AS manager_name,
    region,
    now() AS etl_timestamp
FROM "surfalytics_dw_r_galiev"."raw"."users"
  );
