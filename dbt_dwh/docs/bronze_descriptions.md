{% docs stg_orders_desc %}
Customer orders with product, shipping, and sales details.
{% enddocs %}

{% docs stg_managers_desc %}
Links specific managers to geographical regions for sales performance analysis.
{% enddocs %}

{% docs stg_returns_desc %}
Returned orders and their return status.
{% enddocs %}

{% docs col_dwh_id_desc %}
Technical surrogate key generated for each row in the staging model.
{% enddocs %}

{% docs col_etl_timestamp_desc %}
Timestamp when the row was processed in the dbt transformation layer.
{% enddocs %}

{% docs col_order_id_desc %}
Unique order identifier from the source system.
{% enddocs %}
