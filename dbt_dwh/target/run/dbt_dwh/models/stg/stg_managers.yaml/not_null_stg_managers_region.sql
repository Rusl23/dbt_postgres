
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (








select region
from "surfalytics_dw_r_galiev"."raw"."stg_managers"
where region is null






    ) dbt_internal_test