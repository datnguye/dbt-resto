{% if target.type in ['sqlserver'] %}
with indexes as (
  {{ sqlserver__get_indexes(ref('verify_materialized_view')) }}
)

select  1 as result
where   not exists (
  select  1
  from    "{{ ref('verify_materialized_view').database }}".information_schema.tables
  where   table_type = 'view'
    and   table_schema = '{{ ref("verify_materialized_view").schema }}'
    and   table_name = '{{ ref("verify_materialized_view").table }}'
)

union all

select  1 as result
where   not exists (
  select  1
  from    indexes
  where   object_type = 'view'
    and   index_type = 'Clustered index'
    and   [unique] = 'Unique'
    and   table_view = '{{ ref("verify_materialized_view").schema ~ '.' ~ ref("verify_materialized_view").table }}'
)

{% else %}

select  1 as result where 1 = 0

{% endif %}