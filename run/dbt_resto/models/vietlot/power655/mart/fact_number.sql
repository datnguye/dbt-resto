

      create or replace transient table vietlot_power655.mart.fact_number  as
      (with numbers as (
  select 1 as number_value  union all
  select 2 as number_value  union all
  select 3 as number_value  union all
  select 4 as number_value  union all
  select 5 as number_value  union all
  select 6 as number_value  union all
  select 7 as number_value  union all
  select 8 as number_value  union all
  select 9 as number_value  union all
  select 10 as number_value  union all
  select 11 as number_value  union all
  select 12 as number_value  union all
  select 13 as number_value  union all
  select 14 as number_value  union all
  select 15 as number_value  union all
  select 16 as number_value  union all
  select 17 as number_value  union all
  select 18 as number_value  union all
  select 19 as number_value  union all
  select 20 as number_value  union all
  select 21 as number_value  union all
  select 22 as number_value  union all
  select 23 as number_value  union all
  select 24 as number_value  union all
  select 25 as number_value  union all
  select 26 as number_value  union all
  select 27 as number_value  union all
  select 28 as number_value  union all
  select 29 as number_value  union all
  select 30 as number_value  union all
  select 31 as number_value  union all
  select 32 as number_value  union all
  select 33 as number_value  union all
  select 34 as number_value  union all
  select 35 as number_value  union all
  select 36 as number_value  union all
  select 37 as number_value  union all
  select 38 as number_value  union all
  select 39 as number_value  union all
  select 40 as number_value  union all
  select 41 as number_value  union all
  select 42 as number_value  union all
  select 43 as number_value  union all
  select 44 as number_value  union all
  select 45 as number_value  union all
  select 46 as number_value  union all
  select 47 as number_value  union all
  select 48 as number_value  union all
  select 49 as number_value  union all
  select 50 as number_value  union all
  select 51 as number_value  union all
  select 52 as number_value  union all
  select 53 as number_value  union all
  select 54 as number_value  union all
  select 55 as number_value 

),

staging_box as (
  select * from vietlot_power655.staging.staging_power655_box
)

select       numbers.number_value

            ,sum(case when staging_box.box_id is null then 0 else 1 end) as occurrence
            ,sum(case when staging_box.box_result_number_1 = numbers.number_value then 1 else 0 end) as occurrence_pos_1
            ,sum(case when staging_box.box_result_number_2 = numbers.number_value then 1 else 0 end) as occurrence_pos_2
            ,sum(case when staging_box.box_result_number_3 = numbers.number_value then 1 else 0 end) as occurrence_pos_3
            ,sum(case when staging_box.box_result_number_4 = numbers.number_value then 1 else 0 end) as occurrence_pos_4
            ,sum(case when staging_box.box_result_number_5 = numbers.number_value then 1 else 0 end) as occurrence_pos_5
            ,sum(case when staging_box.box_result_number_6 = numbers.number_value then 1 else 0 end) as occurrence_pos_6
            ,sum(case when staging_box.box_result_number_7 = numbers.number_value then 1 else 0 end) as occurrence_pos_7

            ,max(staging_box.box_date) as last_appearance
            ,max(case when staging_box.box_result_number_1 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_1
            ,max(case when staging_box.box_result_number_2 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_2
            ,max(case when staging_box.box_result_number_3 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_3
            ,max(case when staging_box.box_result_number_4 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_4
            ,max(case when staging_box.box_result_number_5 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_5
            ,max(case when staging_box.box_result_number_6 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_6
            ,max(case when staging_box.box_result_number_7 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_7

from        numbers
left join   staging_box
  on        staging_box.box_result_number_1 = numbers.number_value
  or        staging_box.box_result_number_2 = numbers.number_value
  or        staging_box.box_result_number_3 = numbers.number_value
  or        staging_box.box_result_number_4 = numbers.number_value
  or        staging_box.box_result_number_5 = numbers.number_value
  or        staging_box.box_result_number_6 = numbers.number_value
  or        staging_box.box_result_number_7 = numbers.number_value

group by    numbers.number_value
      );
    