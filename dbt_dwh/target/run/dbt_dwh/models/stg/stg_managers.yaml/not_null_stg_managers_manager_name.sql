
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (








select manager_name
from "surfalytics_dw_r_galiev"."raw"."stg_managers"
where manager_name is null






    ) dbt_internal_test