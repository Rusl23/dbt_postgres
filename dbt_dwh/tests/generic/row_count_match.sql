{% test row_count_match(model, compare_model) %}

with model_cnt as (
    select count(*) as cnt
    from {{ model }}
),
compare_cnt as (
    select count(*) as cnt
    from {{ compare_model }}
)
select
    model_cnt.cnt as model_count,
    compare_cnt.cnt as compare_count
from model_cnt
cross join compare_cnt
where model_cnt.cnt <> compare_cnt.cnt

{% endtest %}
