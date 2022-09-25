{{
  config(
    materialized = ('table' if target.type in ['postgres'] else 'view'),
  )
}}

{{ dbt_resto.get_time_dimension(level='minute') }}