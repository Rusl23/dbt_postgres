
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (








select dwh_id
from "surfalytics_dw_r_galiev"."raw"."stg_returns"
where dwh_id is null






    ) dbt_internal_test