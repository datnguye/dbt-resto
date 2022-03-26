with data as (
  select   cast('2022-03-01' as {{ dbt_resto.type_date() }}) as expected
          ,'20220301'     as "yyyymmdd"
          ,'SOME_TEXT'    as "invalid"
          ,'03/01/22'     as "mm/dd/yy"
          ,'22.03.01'     as "yy.mm.dd"
          ,'01/03/22'     as "dd/mm/yy"
          ,'01.03.22'     as "dd.mm.yy"
          ,'01-03-22'     as "dd-mm-yy"
          ,'01-Mar-22'    as "dd-Mon-yy"
          ,'Mar 01, 22'   as "Mon dd, yy"
          ,'03-01-22'     as "mm-dd-yy"
          ,'22/03/01'     as "yy/mm/dd"
          ,'220301'       as "yymmdd"
          ,'2022-03-01'   as "yyyy-mm-dd"
          ,'03/01/2022'   as "mm/dd/yyyy"
          ,'2022.03.01'   as "yyyy.mm.dd"
          ,'01/03/2022'   as "dd/mm/yyyy"
          ,'01.03.2022'   as "dd.mm.yyyy"
          ,'01-03-2022'   as "dd-mm-yyyy"
          ,'01 Mar 2022'  as "dd Mon yyyy"
          ,'Mar 01, 2022' as "Mon dd, yyyy"
          ,'03-01-2022'   as "mm-dd-yyyy"
          ,'2022/03/01'   as "yyyy/mm/dd"
)

select {{ dbt_resto.str_to_date('"yyyymmdd"'                    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"invalid"'                     ) }} as actual, null as expected from data union all
select {{ dbt_resto.str_to_date('"mm/dd/yy"'    , "mm/dd/yy"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"yy.mm.dd"'    , "yy.mm.dd"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd/mm/yy"'    , "dd/mm/yy"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd.mm.yy"'    , "dd.mm.yy"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd-mm-yy"'    , "dd-mm-yy"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd-Mon-yy"'   , "dd-Mon-yy"   ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"Mon dd, yy"'  , "Mon dd, yy"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"mm-dd-yy"'    , "mm-dd-yy"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"yy/mm/dd"'    , "yy/mm/dd"    ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"yymmdd"'      , "yymmdd"      ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"yyyy-mm-dd"'  , "yyyy-mm-dd"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"mm/dd/yyyy"'  , "mm/dd/yyyy"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"yyyy.mm.dd"'  , "yyyy.mm.dd"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd/mm/yyyy"'  , "dd/mm/yyyy"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd.mm.yyyy"'  , "dd.mm.yyyy"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd-mm-yyyy"'  , "dd-mm-yyyy"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"dd Mon yyyy"' , "dd Mon yyyy" ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"Mon dd, yyyy"', "Mon dd, yyyy") }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"mm-dd-yyyy"'  , "mm-dd-yyyy"  ) }} as actual, expected from data union all
select {{ dbt_resto.str_to_date('"yyyy/mm/dd"'  , "yyyy/mm/dd"  ) }} as actual, expected from data