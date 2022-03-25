select  '{{ dbt_resto.generate_schema_name("dat", model) }}' as actual,
        'dat' as expected

union all

select  '{{ dbt_resto.generate_schema_name(none, model) }}' as actual,
        '{{ target.schema }}' as expected