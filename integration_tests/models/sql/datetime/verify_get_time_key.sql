with data as (
  select cast('2022-03-25 14:55:45' as {{ dbt_resto.type_timestamp() }}) as input
)

select  {{ dbt_resto.get_time_key('input') }} as actual,
        '145545' as expected
from    data
union all
select  {{ dbt_resto.get_time_key('input', h24=False) }} as actual,
        '025545' as expected
from    data

union all

select  {{ dbt_resto.get_time_key('input', parts=['hour','minute']) }} as actual,
        '145500' as expected
from    data
union all
select  {{ dbt_resto.get_time_key('input', parts=['hour','minute'], h24=False) }} as actual,
        '025500' as expected
from    data

union all

select  {{ dbt_resto.get_time_key('input', parts=['hour']) }} as actual,
        '140000' as expected
from    data
union all
select  {{ dbt_resto.get_time_key('input', parts=['hour'], h24=False) }} as actual,
        '020000' as expected
from    data