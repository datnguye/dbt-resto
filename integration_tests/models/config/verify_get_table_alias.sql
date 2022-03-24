{{
  config(alias=dbt_resto.get_table_alias(this))
}}

select  '{{ this.table }}' as actual,
        concat('verify_get_table_alias', '{{ var("table_suffix") }}') as expected