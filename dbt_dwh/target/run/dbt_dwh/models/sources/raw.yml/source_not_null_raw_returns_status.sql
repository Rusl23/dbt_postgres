
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (








select status
from "surfalytics_dw_r_galiev"."raw"."returns"
where status is null






    ) dbt_internal_test