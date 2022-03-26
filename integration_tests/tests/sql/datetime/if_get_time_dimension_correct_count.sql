select  1 as col
from    {{ ref('verify_get_time_dimension_hour') }}
having  not(count(*) = 24)

union all

select  1 as col
from    {{ ref('verify_get_time_dimension_minute') }}
having  not(count(*) = 1440)

union all

select  1 as col
from    {{ ref('verify_get_time_dimension_second') }}
having  not(count(*) = 86400)