
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (








select etl_timestamp
from "surfalytics_dw_r_galiev"."raw"."stg_returns"
where etl_timestamp is null






    ) dbt_internal_test