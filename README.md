# dbt-resto
This is dbt package for everyone
- Default warehouse: Snowflake
- Supported warehouses:
    - Snowflake
    - SQL Server

## Developer's Guide
See [integration_tests](./integration_tests/README.md)

## Macros:
### get_table_alias ([source](/macros/config/get_table_alias.sql))
  Document ([here](/macros/config/get_table_alias.yml))
  Usage:
  ```
  {{ config(alias=dbt_resto.get_table_alias(this)) }}
  ```

### money_to_words ([source](/macros/num2words/money_to_words.sql))
  Document ([here](/macros/num2words/money_to_words.yml))
  Usage:
  ```
  select {{ dbt_resto.money_to_words('my_column_name', 'en') }} as my_column_name_in_words
  ```

### generate_schema_name ([source](/macros/override_default/generate_schema_name.sql))
  Document ([here](/macros/override_default/generate_schema_name.yml))

### get_base_times ([source](/macros/sql/get_base_times.sql))
  Document ([here](/macros/sql/get_base_times.yml))
  Usage:
  ```
  with base_times as (
    {{ dbt_resto.get_base_times('hour') }}
  )
  select * from base_times;

  with base_times as (
    {{ dbt_resto.get_base_times('minute') }}
  )
  select * from base_times;
  ```

### get_time_dimension ([source](/macros/sql/get_time_dimension.sql))
  Document ([here](/macros/sql/get_time_dimension.yml))
  Usage:
  ```
  # models/my_model.yml
  {{ get_time_dimension() }}
  ```

### str_to_date ([source](/macros/sql/str_to_date.sql))
  Document ([here](/macros/sql/str_to_date.yml))
  Usage:
  ```
  select   {{ str_to_date(column) }} as date_column
  from     table
  ```


## Generic Tests:
### test_column_values_to_match_regex ([source](/macros/generic_test/test_column_values_to_match_regex.sql))
  Document ([here](/macros/generic_test/test_column_values_to_match_regex.yml))

  Usage:
  ```
  models:
    - name: table_name
      columns:
        - name: column_name
          tests:
            - dbt_resto.test_column_values_to_match_regex:
                regex_expr: '[a-zA-Z]' # matching text only
  ```