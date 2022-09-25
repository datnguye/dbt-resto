{{
  config(
    enabled = target.type not in ['postgres'],
  )
}}

{{ dbt_resto.get_base_times(level='second') }}