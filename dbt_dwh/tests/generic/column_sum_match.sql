{% test column_sum_match(model, column_name, compare_model, compare_column_name=None, tolerance=0) %}

{% set rhs_column = compare_column_name if compare_column_name is not none else column_name %}

with model_sum as (
    select coalesce(sum(cast({{ column_name }} as {{ dbt.type_numeric() }})), 0) as total
    from {{ model }}
),
compare_sum as (
    select coalesce(sum(cast({{ rhs_column }} as {{ dbt.type_numeric() }})), 0) as total
    from {{ compare_model }}
)
select
    model_sum.total as model_total,
    compare_sum.total as compare_total
from model_sum
cross join compare_sum
where abs(model_sum.total - compare_sum.total) > {{ tolerance }}

{% endtest %}
