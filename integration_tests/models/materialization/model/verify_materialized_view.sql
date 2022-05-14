{{
  config(
    materialized = 'materialized_view',
    unique_key = 'time_key',
    enabled = (target.type != 'snowflake')
  )
}}

select  1 as time_key,
        2 as time_value
